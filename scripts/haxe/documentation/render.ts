import { path } from "../../deps.ts";
import { Class, Interface, Member, Method, Path, Property, Type } from "../types.ts";
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

function renderPropertySignature(property: Property): string {
  let markdown = `<PropertySignature name="${property.name}" :type='${JSON.stringify(property.type)}'>`;
  markdown += "</PropertySignature>";
  return markdown;
}

function renderMethodSignature(method: Method): string {
  let markdown = `<MethodSignature name="${method.name}" `;
  markdown += `:args='${JSON.stringify(method.args)}' `;
  markdown += `:returnType='${JSON.stringify(method.returnType)}'`;
  markdown += "></MethodSignature>";
  return markdown;
}

function renderDoc(doc: string | undefined): string {
  if (!doc) return "\n";
  return doc.split("\n")
    .reduce((s, line) => line.startsWith("@") ? `${s}  \n${line}` : `${s}\n${line}`)
    + "\n";
}

function renderMember(ctx: Context, member: Member): string {
  let markdown = "";
  markdown += `#### {#${member.name}}\n`;
  if (member instanceof Property) {
    markdown += renderPropertySignature(member);
  } else if (member instanceof Method) {
    markdown += renderMethodSignature(member);
  } else {
    console.error(`Invalid member: ${member}`);
  }
  markdown += "  \n";
  markdown += renderDoc(member.documentation);
  return markdown;
}

export function renderType(ctx: Context, typ: Type): string {

  let markdown = renderH1(typ);
  markdown += "\n";
  markdown += `- package: ${typ.path.pack.join(".")}\n`;

  if (typ instanceof Class) {
    markdown += renderClassTypeInfo(ctx, typ);
  } else if (typ instanceof Interface) {
    markdown += renderInterfaceTypeInfo(ctx, typ);
  } else {
    console.error(`Invalid type: ${typ}`);
  }

  markdown += renderDoc(typ.documentation);

  const collator = new Intl.Collator("en");

  if (typ.typeMembers.length > 0) {
    markdown += "## Static members\n";
    for (const member of typ.typeMembers.sort((a, b) => collator.compare(a.name, b.name))) {
      markdown += renderMember(ctx, member);
    }
    markdown += "\n";
  }

  if (typ.instanceMembers.length > 0) {
    markdown += "## Instance members\n";
    for (const member of typ.instanceMembers.sort((a, b) => collator.compare(a.name, b.name))) {
      markdown += renderMember(ctx, member);
    }
    markdown += "\n";
  }

  return markdown;
}
