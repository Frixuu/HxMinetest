import { XmlNode } from "./xml";

export interface Documentible {
  documentation?: string;
}

const NEW_LINE_REGEX = new RegExp("\r\n|\n");

export function tryReadDocumentation(element: Documentible, elementNode: XmlNode) {
  const docNode = elementNode["haxe_doc"] as XmlNode | undefined;
  if (docNode) {
    element.documentation = (docNode["#text"] as string)
      .split(NEW_LINE_REGEX)
      .map(line => line.trimStart())
      .join("\n");
  }
}
