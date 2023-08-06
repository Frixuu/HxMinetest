export interface Path {
  package: string[];
  name: string;
}

export function splitPackagePath(path: string): Path {
  const parts = path.split(".");
  const name = parts.pop()!;
  return { package: parts, name: name };
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
