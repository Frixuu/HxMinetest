import { Documentible } from "../types.ts";
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
