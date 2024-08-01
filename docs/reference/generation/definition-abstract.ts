import { Definition } from "./definition";
import { Path } from "./path";

export class AbstractDefinition extends Definition {
  constructor(path: Path) {
    super(path);
  }
}
