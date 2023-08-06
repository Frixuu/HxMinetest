// SPDX-License-Identifier: Zlib
// deno-lint-ignore-file no-explicit-any

import { path, xml } from "./deps.ts";
import { abort, assertHaxeExists, decodeUtf8, encodeUtf8, invokeHaxe, mustArray, pathFromMeta } from "./common.ts";
import { Class, Interface, splitPackagePath } from "./haxe/types.ts";

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
const referenceRoot = path.join(root, "docs", "reference");
const xmlPath = path.join(referenceRoot, "classes.xml");
const documentString = decodeUtf8(await Deno.readFile(xmlPath));
const document = xml.parse(documentString)["haxe"]! as any;

const classes: Class[] = []
const interfaces: Interface[] = []

for (const clazz of document["class"]) {

  const discriminator = clazz["@interface"] ? "interface" : "class";
  const path = splitPackagePath(clazz["@path"]);
  const isPrivate = clazz["@private"] !== undefined;
  const isExtern = clazz["@extern"] !== undefined;
  const isFinal = clazz["@final"] !== undefined;
  const isAbstract = clazz["@abstract"] !== undefined;
  const interfacePaths = mustArray(clazz["implements"]).map(i => splitPackagePath(i["@path"] ?? ""));

  const superClass = clazz["extends"]?.["@path"];

  if (discriminator == "class") {
    classes.push({
      discriminator, path, isPrivate, isExtern, isFinal, isAbstract, interfacePaths,
      superClassPath: superClass ? splitPackagePath(superClass) : undefined,
    });
  } else {
    interfaces.push({
      discriminator, path, isPrivate, isExtern, isFinal, interfacePaths
    });
  }
}

// Finally, render to Markdown

try {
  await Deno.remove(path.join(referenceRoot, "minetest"), { recursive: true });
} catch (e) {
  if (!(e instanceof Deno.errors.NotFound)) {
    throw e;
  }
}

for (const clazz of classes.filter(c => (c.path.package.at(0) ?? "") == "minetest")) {

  const packDir = path.join(referenceRoot, ...clazz.path.package);
  await Deno.mkdir(packDir, { recursive: true });

  let fileText = `# <small>class</small> ${clazz.path.name}\n\n`;
  fileText += `- package: ${clazz.path.package.join(".")}\n`;

  if (clazz.superClassPath) {
    const superClass = clazz.superClassPath;
    fileText += `- extends: [${superClass.name}](/${path.join("reference", ...superClass.package, superClass.name)})\n`;
  }

  const ifaces = (clazz.interfacePaths ?? []).filter(i => (i.package.at(0) ?? "") == "minetest");
  if (ifaces.length > 0) {
    fileText += "- implements: ";
    for (const [i, iface] of ifaces.entries()) {
      fileText += "[";
      fileText += iface.name;
      fileText += "](/";
      fileText += path.join("reference", ...iface.package, iface.name);
      fileText += ")";
      if (i < ifaces.length - 1) {
        fileText += ", ";
      }
    }
    fileText += "\n";
  }

  await Deno.writeFile(path.join(packDir, `${clazz.path.name}.md`), encodeUtf8(fileText));
}
