import { NamedOptionalArgument } from "./argument";
import { Documentible } from "./documentible";
import { Meta } from "./meta";

export class EnumConstructor implements Documentible {
  name: string;
  mrgs: NamedOptionalArgument[];
  documentation?: string;
  meta: Meta[];
}
