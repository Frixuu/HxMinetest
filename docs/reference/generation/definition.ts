import { Documentible, tryReadDocumentation } from "./documentible";
import { Path } from "./path";
import { XmlNode } from "./xml";

export class Definition implements Documentible {
  path: Path;
  documentation?: string;
  constructor(path: Path) {
    this.path = path;
  }

  readRttiNode(node: XmlNode): void {
    tryReadDocumentation(this, node);
  }

  renderMarkdownReference(): string {
    return `# ${this.path.shortName()}\n\n${this.documentation ?? ""}`;
  }
}
