import { NamedDefaultArgument } from "./argument";

export class Type { }


export class Enum extends Type { }
export class ClassOrInterface extends Type { }
export class Typedef extends Type { }
export class Abstract extends Type { }

export class Function extends Type {
  args: NamedDefaultArgument[];
  returnType: Type;
  constructor(args: NamedDefaultArgument[], returnType: Type) {
    super();
    this.args = args;
    this.returnType = returnType;
  }
}

export class Anonymous extends Type { }

export class Dynamic extends Type {
  fieldValueConstraint?: Type;
  constructor(fieldValueConstraint?: Type) {
    super();
    this.fieldValueConstraint = fieldValueConstraint;
  }
}

export class Unknown extends Type { }

