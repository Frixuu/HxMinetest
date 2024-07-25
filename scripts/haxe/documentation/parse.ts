import { Documentible, Path, RuntimeType } from "../types.ts";
import { XmlNode } from "./schema.ts";

const newLineRegex = new RegExp("\r\n|\n");

export function applyDocIfExists(elementNode: XmlNode, element: Documentible) {
  const docNode = elementNode["haxe_doc"] as XmlNode | undefined;
  if (docNode) {
    element.documentation = docNode["#text"]
      .split(newLineRegex)
      .map(line => line.trimStart())
      .join("\n");
  }
}

function dynamicType(): RuntimeType {
  return new RuntimeType(Path.fromDotPath("Dynamic"), []);
}

export function getTypeParams(node: XmlNode): RuntimeType[] {
  return (node["~children"] as XmlNode[])
    .map(getRuntimeTypeOfNode)
    .filter(Boolean) as RuntimeType[];
}

export function getRuntimeTypeOfNode(node: XmlNode): RuntimeType | null {
  switch (node["~name"]) {
    case "c":   // class (or interface)
    case "t":   // typedef
    case "e":   // enum
    case "x": { // abstract
      const path = Path.fromDotPath((node["@path"] as string | undefined) || "Dynamic");
      return new RuntimeType(path, getTypeParams(node));
    }
    case "f": { // function
      return dynamicType();
    }
    case "a": { // anonymous
      return new RuntimeType(Path.fromDotPath("&#123;anon&#125;"), []);
    }
    case "d": { // dynamic
      const path = Path.fromDotPath("Dynamic");
      return new RuntimeType(path, getTypeParams(node));
    }
    case "unknown": {
      return new RuntimeType(Path.fromDotPath("???"), []);
    }
    default: {
      return null;
    }
  }
}
