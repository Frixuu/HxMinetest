import { path } from "../../deps.ts";
import { Class, Interface, Path, Type } from "../types.ts";
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

function renderLinkToTypePath(p: Path): string {
  let markdown = "[";
  markdown += p.shortName();
  markdown += "](/";
  markdown += path.join("reference", ...p.pack, p.shortName());
  markdown += ")";
  return markdown;
}

function renderClassTypeInfo(ctx: Context, clazz: Class): string {

  let markdown = "";

  if (clazz.superTypePaths.length > 0) {
    markdown += "- extends: ";
    markdown += renderLinkToTypePath(clazz.superTypePaths[0])
    markdown += "\n";
  }

  const interfaces = (clazz.interfacePaths ?? []).filter(i => i.isInPackage(["minetest"]))
  if (interfaces.length > 0) {
    markdown += "- implements: ";
    for (const [i, iface] of interfaces.entries()) {
      markdown += renderLinkToTypePath(iface);
      if (i < interfaces.length - 1) {
        markdown += ", ";
      }
    }
    markdown += "\n";
  }

  const knownSubclasses = ctx.knownSubtypes.get(clazz.path.toString()) ?? [];
  if (knownSubclasses.length > 0) {
    markdown += "- direct subclasses: ";
    for (const [i, subc] of knownSubclasses.entries()) {
      markdown += renderLinkToTypePath(subc.path);
      if (i < knownSubclasses.length - 1) {
        markdown += ", ";
      }
    }
    markdown += "\n";
  }

  return markdown;
}

function renderInterfaceTypeInfo(ctx: Context, iface: Interface): string {

  let markdown = "";

  const superIfaces = iface.superTypePaths;
  if (superIfaces.length > 0) {
    markdown += "- extends: ";
    for (const [i, superi] of superIfaces.entries()) {
      markdown += renderLinkToTypePath(superi);
      if (i < superIfaces.length - 1) {
        markdown += ", ";
      }
    }
    markdown += "\n";
  }

  const directImplementors = ctx.getImplementors(iface);
  if (directImplementors.length > 0) {
    markdown += "- direct implementors: ";
    for (const [i, impl] of directImplementors.entries()) {
      markdown += renderLinkToTypePath(impl.path);
      if (i < directImplementors.length - 1) {
        markdown += ", ";
      }
    }
    markdown += "\n";
  }

  const knownSubifaces = ctx.getSubTypes(iface);
  if (knownSubifaces.length > 0) {
    markdown += "- direct subinterfaces: ";
    for (const [i, subi] of knownSubifaces.entries()) {
      markdown += renderLinkToTypePath(subi.path);
      if (i < knownSubifaces.length - 1) {
        markdown += ", ";
      }
    }
    markdown += "\n";
  }


  return markdown;
}

export function renderType(ctx: Context, t: Type): string {

  let markdown = renderH1(t);
  markdown += "\n";
  markdown += `- package: ${t.path.pack.join(".")}\n`;

  switch (t.discriminator) {
    case "class": {
      markdown += renderClassTypeInfo(ctx, t as Class);
      break;
    }
    case "interface": {
      markdown += renderInterfaceTypeInfo(ctx, t as Interface);
      break;
    }
    default: {
      console.error(`Invalid type discriminator: ${t.discriminator}`);
    }
  }

  markdown += `\n${t.documentation ?? ""}\n`;

  return markdown;
}
