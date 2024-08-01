import { Definition } from "./definition";
import { Path } from "./path";

export class TypedefDefinition extends Definition {
  constructor(path: Path) {
    super(path);
  }
}
