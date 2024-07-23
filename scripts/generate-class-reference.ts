// SPDX-License-Identifier: Zlib
// deno-lint-ignore-file no-explicit-any

import { abort, assertHaxeExists, decodeUtf8, encodeUtf8, invokeHaxe, mustArray, pathFromMeta } from "./common.ts";
import { path, xml } from "./deps.ts";
import { Context } from "./haxe/documentation/context.ts";
import { renderType } from "./haxe/documentation/render.ts";
import { Class, Interface, Method, Path, Property, Type } from "./haxe/types.ts";

await assertHaxeExists();

// First, dump the compiler output to an XML file
const { success, stderr } = await invokeHaxe({
  classpaths: ["src"],
  libraries: ["partials"],
  initMacros: ["include('doctest')", "include('minetest')"],
  other: ["--lua", "not.applicable", "--no-output", "--xml", "docs/reference/classes.xml"]
});

if (!success) {
  abort(`Generating XML failed: ${decodeUtf8(stderr)}`);
}

// Then, try to read all the classes
const root = path.join(pathFromMeta(import.meta), "..", "..");
const docRoot = path.join(root, "docs");
const referenceRoot = path.join(docRoot, "reference");
const xmlPath = path.join(referenceRoot, "classes.xml");
const documentString = decodeUtf8(await Deno.readFile(xmlPath));
const document = xml.parse(documentString)["haxe"]! as any;

const context = new Context();
const newLineRegex = new RegExp("\r\n|\n");

for (const typeNode of document["class"]) {

  const path = Path.fromDotPath(typeNode["@path"]);
  const typ = typeNode["@interface"] ? new Interface(path) : new Class(path);

  const doc: string | undefined = typeNode["haxe_doc"];
  if (doc) {
    typ.documentation = doc.split(newLineRegex).map(line => line.trimStart()).join("\n");
  }

  typ.isPrivate = typeNode["@private"] !== undefined;
  typ.isExtern = typeNode["@extern"] !== undefined;
  typ.isFinal = typeNode["@final"] !== undefined;
  typ.isAbstract = typeNode["@abstract"] !== undefined;

  typ.interfacePaths = mustArray(typeNode["implements"]).map(i => Path.fromDotPath(i["@path"] ?? ""));
  typ.superTypePaths = mustArray(typeNode["extends"]).map(i => Path.fromDotPath(i["@path"] ?? ""));

  const memberNames = Object.keys(typeNode)
    .filter(k => !k.startsWith("@") && !k.startsWith("#") && !k.startsWith("~"))
    .filter(k => !new Set(["haxe_doc", "extends", "implements", "haxe_dynamic", "meta"]).has(k));

  for (const name of memberNames) {

    const memberNode = typeNode[name];
    const signatureNode = mustArray(memberNode["f"]).at(0);
    let member;
    {
      if (signatureNode) {
        //const paramNames = (signatureNode["@a"] ?? "").split(":");
        const method = new Method(name);
        member = method;
      } else {
        const property = new Property(name);
        member = property;
      }
    }

    const doc: string | undefined = memberNode["haxe_doc"];
    if (doc) {
      member.documentation = doc.split(newLineRegex).map(line => line.trimStart()).join("\n");
    }

    member.isPrivate = memberNode["@public"] === undefined;
    member.isFinal = memberNode["@final"] !== undefined;
    member.isOverride = memberNode["@override"] !== undefined;

    if (memberNode["@static"]) {
      typ.typeMembers.push(member);
    } else {
      typ.instanceMembers.push(member);
    }
  }

  context.registerType(typ);
}

for (const abstract of document["abstract"]) {
  //const path = Path.fromDotPath(abstract["@path"]);

}

// Render to Markdown
try {
  await Deno.remove(path.join(referenceRoot, "minetest"), { recursive: true });
} catch (e) {
  if (!(e instanceof Deno.errors.NotFound)) {
    throw e;
  }
}

const visitedTypes: Type[] = [];

const types: Type[] = [
  context.getClasses(["minetest"]),
  context.getInterfaces(["minetest"])
].flat();

for (const typ of types) {
  visitedTypes.push(typ);
  const packDir = path.join(referenceRoot, ...typ.path.pack);
  await Deno.mkdir(packDir, { recursive: true });
  const markdown = renderType(context, typ);
  await Deno.writeFile(path.join(packDir, `${typ.path.shortName()}.md`), encodeUtf8(markdown));
}

// Generate sidebar

interface PathItem {
  pathSoFar: string[];
  childPackages: Map<string, PathItem>;
  types: Type[];
}

const sidebarRoot: PathItem = {
  pathSoFar: [],
  childPackages: new Map(),
  types: [],
}

for (const typ of visitedTypes) {
  let root = sidebarRoot;
  let packRemaining = typ.path.pack;
  const pathSoFar = [];
  while (packRemaining.length > 0) {
    const first = packRemaining[0];
    pathSoFar.push(first);
    packRemaining = packRemaining.slice(1);
    let child = root.childPackages.get(first);
    if (child === undefined) {
      child = { pathSoFar, childPackages: new Map(), types: [] };
      root.childPackages.set(first, child);
    }
    root = child;
  }
  root.types.push(typ);
}

interface SidebarItemDto {
  text: string;
}

interface TypeDto extends SidebarItemDto {
  link: string;
}

function generateType(type: Type): TypeDto {
  return {
    text: type.path.shortName(),
    link: `/${path.join("reference", ...type.path.pack, type.path.shortName())}`
  };
}

function generateItems(el: PathItem): SidebarItemDto[] {
  const children = Array.from(el.childPackages.values()).map(p => generatePathItem(p) as SidebarItemDto);
  const types = el.types.map(t => generateType(t) as SidebarItemDto);
  return children.concat(types);
}

interface PathItemDto extends SidebarItemDto {
  collapsed?: boolean;
  items: SidebarItemDto[];
}

function generatePathItem(el: PathItem): PathItemDto {
  return {
    text: el.pathSoFar[el.pathSoFar.length - 1],
    collapsed: true,
    items: generateItems(el),
  };
}


let sidebarText = "export default ";
sidebarText += JSON.stringify(generateItems(sidebarRoot));
sidebarText += ";\n";
await Deno.writeFile(path.join(docRoot, ".vitepress", "reference-sidebar.autogenerated.ts"), encodeUtf8(sidebarText));
