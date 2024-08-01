import { Type } from "./type";

export interface NamedArgument {
  name: string;
  type: Type;
}

export interface NamedOptionalArgument extends NamedArgument {
  isOptional: boolean;
}

export interface NamedDefaultArgument extends NamedOptionalArgument {
  defaultValue?: string;
}
