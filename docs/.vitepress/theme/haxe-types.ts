export interface Path {
  pack: string[];
  module: string;
  name: string;
}

export interface RuntimeType {
  path: Path;
  typeParams: RuntimeType[];
}

export interface FunctionArgument {
  name: string;
  optional: boolean;
  type: RuntimeType;
  defaultValue?: string;
}
