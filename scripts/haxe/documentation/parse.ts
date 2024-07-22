import { xml } from "../../deps.ts";
import { Context } from "./context.ts";

export function parse(documentString: string): Context {
  const document = xml.parse(documentString);
  const root = document["haxe"]!;
  const ctx = new Context();
  parseAllClassesAndInterfaces(root, ctx);
  parseAllAbstracts(root, ctx);
  parseAllTypedefs(root, ctx);
  return ctx;
}

function parseAllClassesAndInterfaces(root: any, ctx: Context) {
  for (const clazz of root["class"]) {
  }
}

function parseAllAbstracts(root: any, ctx: Context) {
  for (const clazz of root["class"]) {
  }
}

function parseAllTypedefs(root: any, ctx: Context) {
  for (const clazz of root["class"]) {
  }
}
