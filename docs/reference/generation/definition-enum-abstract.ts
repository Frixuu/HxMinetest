import { AbstractDefinition } from "./definition-abstract";
import { Path } from "./path";
import { XmlNode } from "./xml";


export class EnumAbstractDefinition extends AbstractDefinition {
  constructor(path: Path) {
    super(path);
  }
}

export function isNodeEnumAbstract(node: XmlNode): boolean {
  if (node["~name"] !== "abstract") return false;
  const metaParentNode = node["meta"] as XmlNode | undefined;
  if (!metaParentNode) return false;
  const metaNodes = metaParentNode["~children"] as XmlNode[] ?? [];
  return metaNodes.some(m => m["@n"] === ":enum");
}
