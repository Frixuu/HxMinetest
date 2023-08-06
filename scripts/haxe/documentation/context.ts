import { Class, Interface, Path } from "../types.ts";

export class Context {
  classes: Map<string, Class>;
  interfaces: Map<string, Interface>;
  knownSubclasses: Map<string, Class[]>;
  knownImplementors: Map<string, Class[]>;

  constructor() {
    this.classes = new Map();
    this.interfaces = new Map();
    this.knownImplementors = new Map();
    this.knownSubclasses = new Map();
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
    if (clazz.superClassPath) {
      const keySuper = clazz.superClassPath.toString();
      const subclasses = this.knownSubclasses.get(keySuper) ?? [];
      subclasses.push(clazz);
      this.knownSubclasses.set(keySuper, subclasses);
    }
  }

  registerInterface(iface: Interface) {
    this.interfaces.set(iface.path.toString(), iface);
  }
}
