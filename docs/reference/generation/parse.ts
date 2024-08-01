import * as xml from "@lowlighter/xml";
import { Definition } from "./definition";
import { AbstractDefinition } from "./definition-abstract";
import { ClassDefinition } from "./definition-class";
import { EnumDefinition } from "./definition-enum";
import { EnumAbstractDefinition, isNodeEnumAbstract } from "./definition-enum-abstract";
import { InterfaceDefinition } from "./definition-interface";
import { TypedefDefinition } from "./definition-typedef";
import { Path } from "./path";
import { XmlDocument, XmlNode, XmlParseOptions } from "./xml";

const PARSE_OPTIONS: XmlParseOptions = {
  mode: "xml",
  clean: {
    attributes: false,
    comments: true,
    doctype: true,
    instructions: true,
  },
  flatten: {
    attributes: false,
    empty: false,
    text: false,
  },
  revive: {
    trim: false,
    entities: false,
    booleans: false,
    numbers: false,
  },
} as const;

export function parseRttiXml(xmlContents: string): Definition[] {

  const document: XmlDocument = xml.parse(xmlContents, PARSE_OPTIONS);
  const rootNode = document["haxe"]! as XmlNode;
  const typeNodes = rootNode["~children"] as XmlNode[];

  const typeDefinitions = typeNodes.map(typeNode => {

    const path = Path.fromDotPath(typeNode["@path"]! as string);
    let def: Definition;
    switch (typeNode["~name"]) {
      case "class":
        def = new ClassDefinition(path);
        break;
      case "interface":
        def = new InterfaceDefinition(path);
        break;
      case "abstract":
        if (isNodeEnumAbstract(typeNode)) {
          def = new EnumAbstractDefinition(path);
        } else {
          def = new AbstractDefinition(path);
        }
        break;
      case "enum":
        def = new EnumDefinition(path);
        break;
      case "typedef":
        def = new TypedefDefinition(path);
        break;
      default:
        return undefined;
    }

    def.readRttiNode(typeNode);
    return def;

  });

  return typeDefinitions.filter(Boolean) as Definition[];
}
