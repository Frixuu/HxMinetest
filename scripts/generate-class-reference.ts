// SPDX-License-Identifier: Zlib

import { abort, assertHaxeExists, decodeUtf8, encodeUtf8, invokeHaxe, mustArray, pathFromMeta } from "./common.ts";
import { path, xml } from "./deps.ts";
import { Context } from "./haxe/documentation/context.ts";
import { applyDocIfExists, getTypeParams } from "./haxe/documentation/parse.ts";
import { renderType } from "./haxe/documentation/render.ts";
import { Class, FunctionArgument, Interface, Method, Path, Property, Type } from "./haxe/types.ts";

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
const documentString = await Deno.readTextFile(xmlPath);

type XmlNode = xml.xml_node;
const parseOptions: xml.parse_options = {
  mode: "xml",
  clean: { attributes: false, comments: true, doctype: true, instructions: true },
  flatten: { attributes: false, empty: false, text: false }
};
const document = xml.parse(documentString, parseOptions)["haxe"]! as XmlNode;

const context = new Context();
const xmlSpecialRegex = new RegExp("^(~|@|$)");
const reservedNodeNames = new Set(["haxe_doc", "extends", "implements", "haxe_dynamic", "meta"]);

for (const typeNode of document["~children"] as XmlNode[]) {

  const path = Path.fromDotPath(typeNode["@path"]! as string);
  let type: Type;
  switch (typeNode["~name"]) {
    case "class":
      type = new Class(path);
      break;
    case "interface":
      type = new Interface(path);
      break;
    // TODO: abstracts and typedefs
    default:
      continue;
  }

  applyDocIfExists(typeNode, type);

  type.isPrivate = typeNode["@private"] !== undefined;
  type.isExtern = typeNode["@extern"] !== undefined;
  type.isFinal = typeNode["@final"] !== undefined;
  type.isAbstract = typeNode["@abstract"] !== undefined;

  type.interfacePaths = (mustArray(typeNode["implements"]) as XmlNode[])
    .map(n => Path.fromDotPath(n["@path"]! as string));
  type.superTypePaths = (mustArray(typeNode["extends"]) as XmlNode[])
    .map(n => Path.fromDotPath(n["@path"]! as string));

  const memberNodes = (typeNode["~children"] as XmlNode[])
    .filter(child => !xmlSpecialRegex.test(child["~name"]))
    .filter(child => !reservedNodeNames.has(child["~name"]));

  for (const memberNode of memberNodes) {

    const memberName = memberNode["~name"];
    const signatureNode = (mustArray(memberNode["f"]) as XmlNode[]).at(0);
    let member;
    {
      if (signatureNode) {
        const paramNames = (signatureNode["@a"] as string ?? "").split(":");
        const paramDefaultValues = (signatureNode["@v"] as string ?? "").split(":");
        const typeParams = getTypeParams(signatureNode);
        const returnType = typeParams.pop()!;
        const args = typeParams.map((p, i) => {
          const name = paramNames[i];
          let defaultValue: string | undefined = paramDefaultValues[i];
          const optional = defaultValue != undefined && defaultValue.startsWith("?");
          if (optional) {
            defaultValue = defaultValue.slice(1);
          }
          else if (defaultValue == "") {
            defaultValue = undefined;
          }
          return new FunctionArgument(name, optional, p, defaultValue);
        });
        const method = new Method(memberName, args, returnType);
        member = method;
      } else {

        const property = new Property(memberName, getTypeParams(memberNode).at(0)!);
        member = property;
      }
    }

    applyDocIfExists(memberNode, member);

    member.isPrivate = memberNode["@public"] === undefined;
    member.isFinal = memberNode["@final"] !== undefined;
    member.isOverride = memberNode["@override"] !== undefined;

    if (memberNode["@static"]) {
      type.typeMembers.push(member);
    } else {
      type.instanceMembers.push(member);
    }
  }

  context.registerType(type);
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
