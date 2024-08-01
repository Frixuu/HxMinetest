import { Path } from "../../../docs/reference/generation/path.ts";
import { Abstract, Class, Interface, Type } from "../types.ts";

export class Context {
  classes: Map<string, Class>;
  interfaces: Map<string, Interface>;
  abstracts: Map<string, Abstract>;
  knownSubtypes: Map<string, Type[]>;
  knownImplementors: Map<string, Class[]>;

  constructor() {
    this.classes = new Map();
    this.interfaces = new Map();
    this.abstracts = new Map();
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

  getAbstracts(inNamespace?: string[]): Abstract[] {

    if (inNamespace === undefined || inNamespace.length == 0) {
      return Array.from(this.abstracts.values());
    }

    const results: Abstract[] = [];
    this.abstracts.forEach(a => {
      if (a.path.isInPackage(inNamespace))
        results.push(a);
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

  registerAbstract(abstract: Abstract) {
    this.abstracts.set(abstract.path.toString(), abstract);
  }

  registerType(typ: Type) {
    if (typ instanceof Class) {
      this.registerClass(typ);
    } else if (typ instanceof Interface) {
      this.registerInterface(typ);
    } else if (typ instanceof Abstract) {
      this.registerAbstract(typ);
    } else {
      throw new Error(`Invalid type: ${typ}`);
    }
  }
}
