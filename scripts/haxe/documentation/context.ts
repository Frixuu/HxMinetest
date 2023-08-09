import { Class, Interface, Path, Type } from "../types.ts";

export class Context {
  classes: Map<string, Class>;
  interfaces: Map<string, Interface>;
  knownSubtypes: Map<string, Type[]>;
  knownImplementors: Map<string, Class[]>;

  constructor() {
    this.classes = new Map();
    this.interfaces = new Map();
    this.knownImplementors = new Map();
    this.knownSubtypes = new Map();
  }

  getClasses(inNamespace?: string[]): Class[] {

    if (inNamespace === undefined || inNamespace.length == 0) {
      return Array.from(this.classes.values());
    }

    const results: Class[] = [];
    this.classes.forEach(clazz => {
      if (clazz.path.isInPackage(inNamespace))
        results.push(clazz);
    });
    return results;
  }

  getInterfaces(inNamespace?: string[]): Interface[] {

    if (inNamespace === undefined || inNamespace.length == 0) {
      return Array.from(this.interfaces.values());
    }

    const results: Interface[] = [];
    this.interfaces.forEach(iface => {
      if (iface.path.isInPackage(inNamespace))
        results.push(iface);
    });
    return results;
  }

  registerClass(clazz: Class) {
    this.classes.set(clazz.path.toString(), clazz);
    for (const superClassPath of clazz.superTypePaths) {
      this.registerExtends(clazz, superClassPath)
    }
    for (const interfacePath of clazz.interfacePaths) {
      this.registerImplements(clazz, interfacePath);
    }

  }

  private registerExtends(sub: Type, superPath: Path) {
    const key = superPath.toString();
    const subclasses = this.knownSubtypes.get(key) ?? [];
    subclasses.push(sub);
    this.knownSubtypes.set(key, subclasses);
  }

  getSubTypes(superPath: Type): Type[] {
    return this.knownSubtypes.get(superPath.path.toString()) ?? [];
  }

  private registerImplements(clazz: Class, interfacePath: Path) {
    const key = interfacePath.toString();
    const implementors = this.knownImplementors.get(key) ?? [];
    implementors.push(clazz);
    this.knownImplementors.set(key, implementors);
  }

  getImplementors(iface: Interface): Class[] {
    return this.knownImplementors.get(iface.path.toString()) ?? [];
  }

  registerInterface(iface: Interface) {
    this.interfaces.set(iface.path.toString(), iface);
    for (const superIfacePath of iface.superTypePaths) {
      this.registerExtends(iface, superIfacePath)
    }
  }
}
