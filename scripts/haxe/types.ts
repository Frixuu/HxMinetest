import { Path } from "../../docs/reference/generation/path.ts";

export class RuntimeType {
  constructor(
    public path: Path,
    public typeParams: RuntimeType[]) { }
}

export class FunctionArgument {
  constructor(
    public name: string,
    public optional: boolean,
    public type: RuntimeType,
    public defaultValue?: string) { }
}

export interface Documentible {
  documentation?: string;
}

type TypeDiscriminator = "class" | "interface" | "abstract" | "typedef";

export abstract class Type implements Documentible {

  discriminator: TypeDiscriminator;
  path: Path;
  documentation?: string;
  isPrivate?: boolean;
  isFinal?: boolean;
  isExtern?: boolean;
  isAbstract?: boolean;
  superTypePaths?: Path[];
  interfacePaths?: Path[];
  typeMembers: Member[];
  instanceMembers: Member[];

  constructor(path: Path, kind: TypeDiscriminator) {
    this.path = path;
    this.discriminator = kind;
    this.typeMembers = [];
    this.instanceMembers = [];
  }
}

export class Class extends Type {

  isPrivate: boolean;
  isFinal: boolean;
  isExtern: boolean;
  isAbstract: boolean;
  superTypePaths: Path[];
  interfacePaths: Path[];

  constructor(path: Path) {
    super(path, "class");
    this.isPrivate = false;
    this.isFinal = false;
    this.isExtern = false;
    this.isAbstract = false;
    this.superTypePaths = [];
    this.interfacePaths = [];
  }
}

export class Interface extends Type {

  isPrivate: boolean;
  isFinal: boolean;
  isExtern: boolean;
  superTypePaths: Path[];
  interfacePaths: Path[];

  constructor(path: Path) {
    super(path, "interface");
    this.isPrivate = false;
    this.isFinal = false;
    this.isExtern = false;
    this.superTypePaths = [];
    this.interfacePaths = [];
  }
}

export class Abstract extends Type {

  isEnum: boolean;

  constructor(path: Path) {
    super(path, "abstract");
    this.isEnum = false;
  }
}

export interface Typedef extends Type { }

export abstract class Member implements Documentible {

  name: string;
  documentation?: string;
  isPrivate: boolean;
  isFinal: boolean;
  isOverride: boolean;

  constructor(name: string) {
    this.name = name;
    this.isPrivate = false;
    this.isFinal = false;
    this.isOverride = false;
  }
}

export class Property extends Member {
  constructor(name: string, public type: RuntimeType) {
    super(name);
  }
}

export class Method extends Member {
  constructor(name: string, public args: FunctionArgument[], public returnType: RuntimeType) {
    super(name);
  }
}
