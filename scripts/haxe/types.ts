/** Path represents an identifier of a Haxe type. */
export class Path {

  /** Package of a certain type. */
  pack: string[];
  /** The module this type is in. */
  module: string;
  /** Name of a certain type. May be different than the module. */
  name: string;

  constructor(pack: string[], module: string, name?: string) {
    this.pack = pack;
    this.module = module;
    this.name = name ?? module;
  }

  shortName(): string {
    if (this.isSubpath()) {
      return this.module + "." + this.name;
    }
    return this.name;
  }

  isSubpath(): boolean {
    return this.module != this.name;
  }

  isInPackage(namespace: string[]): boolean {
    const pack = this.pack;
    if (pack.length < namespace.length) {
      return false;
    }
    for (let i = 0; i < namespace.length; i++) {
      if (pack[i] !== namespace[i]) {
        return false;
      }
    }
    return true;
  }

  toString(): string {

    let s = "";

    if (this.pack.length > 0) {
      s += this.pack.join(".");
      s += ".";
    }

    s += this.module;

    if (this.isSubpath()) {
      s += ".";
      s += this.name;
    }

    return s;
  }

  /** Returns a new Path from a string like "foo.bar.Name". */
  static fromDotPath(path: string): Path {
    const parts = path.split(".");
    const name = parts.pop()!;
    let module = name;
    if (parts.length > 0) {
      const ch = parts[parts.length - 1].charAt(0);
      if (ch == ch.toUpperCase()) {
        module = parts.pop()!;
      }
    }
    return new Path(parts, module, name);
  }
}

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
