import { path } from "../../deps.ts";
import { Class, Type } from "../types.ts";
import { Context } from "./context.ts";

function renderH1(typ: Type): string {
  let markdown = "# <small>";
  if (typ.isPrivate) markdown += "private ";
  if (typ.isExtern) markdown += "extern ";
  if (typ.isAbstract) markdown += "abstract ";
  if (typ.isFinal) markdown += "final ";
  markdown += typ.discriminator;
  markdown += "</small> ";
  markdown += typ.path.shortName();
  markdown += "\n";
  return markdown;
}

export function renderClass(ctx: Context, clazz: Class): string {

  let markdown = renderH1(clazz);
  markdown += `\n- package: ${clazz.path.pack.join(".")}\n`;

  const superc = clazz.superClassPath;
  if (superc) {
    markdown += "- extends: [";
    markdown += superc.shortName();
    markdown += "](/";
    markdown += path.join("reference", ...superc.pack, superc.shortName());
    markdown += ")\n";
  }

  const interfaces = (clazz.interfacePaths ?? []).filter(i => i.isInPackage(["minetest"]))
  if (interfaces.length > 0) {
    markdown += "- implements: ";
    for (const [i, iface] of interfaces.entries()) {
      markdown += "[";
      markdown += iface.shortName();
      markdown += "](/";
      markdown += path.join("reference", ...iface.pack, iface.shortName());
      markdown += ")";
      if (i < interfaces.length - 1) {
        markdown += ", ";
      }
    }
    markdown += "\n";
  }

  const knownSubclasses = ctx.knownSubclasses.get(clazz.path.toString()) ?? [];
  if (knownSubclasses.length > 0) {
    markdown += "- known subclasses: ";
    for (const [i, subc] of knownSubclasses.entries()) {
      markdown += "[";
      markdown += subc.path.shortName();
      markdown += "](/";
      markdown += path.join("reference", ...subc.path.pack, subc.path.shortName());
      markdown += ")";
      if (i < interfaces.length - 1) {
        markdown += ", ";
      }
    }
    markdown += "\n";
  }

  markdown += `\n${clazz.documentation ?? ""}\n`;

  return markdown;
}
