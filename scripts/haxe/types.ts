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

export interface Type {
  discriminator: "class" | "interface" | "abstract" | "typedef";
  path: Path;
}

export interface Class extends Type {
  discriminator: "class"
  isPrivate: boolean;
  isFinal: boolean;
  isExtern: boolean;
  isAbstract: boolean;
  superClassPath?: Path;
  interfacePaths?: Path[];
}

export interface Interface extends Type {
  discriminator: "interface"
  isPrivate: boolean;
  isFinal: boolean;
  isExtern: boolean;
  interfacePaths?: Path[];
}
