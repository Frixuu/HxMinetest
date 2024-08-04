import type { DefaultTheme } from "vitepress";
import { Definition } from "./definition";
import { data as typeDefs } from "./rtti.data";

// The types are currently stored in a flat structure.
// We want subpackages to be collapsible items on the sidebar,
// so we need to build a tree to generate it.

interface PackageTreeNode {
  currentPath: string[];
  subpackages: Map<string, PackageTreeNode>;
  directTypes: Definition[];
}

const sidebarRoot: PackageTreeNode = {
  currentPath: [],
  subpackages: new Map(),
  directTypes: [],
}

for (const typeDef of typeDefs) {
  let root = sidebarRoot;
  let pack = typeDef.path.pack;
  const pathSoFar: string[] = [];
  while (pack.length > 0) {
    const nextSubpackage = pack[0];
    pathSoFar.push(nextSubpackage);
    pack = pack.slice(1);
    let child = root.subpackages.get(nextSubpackage);
    if (child === undefined) {
      child = { currentPath: pathSoFar, subpackages: new Map(), directTypes: [] };
      root.subpackages.set(nextSubpackage, child);
    }
    root = child;
  }
  root.directTypes.push(typeDef);
}

type SidebarItem = DefaultTheme.SidebarItem;

function buildLeaf(def: Definition): SidebarItem {
  return {
    text: def.path.shortName(),
    link: `/reference/${def.path.toString()}`
  };
}

function buildNode(el: PackageTreeNode): SidebarItem {
  return {
    text: el.currentPath.at(-1),
    collapsed: true,
    items: buildEdges(el),
  };
}

function buildEdges(el: PackageTreeNode): SidebarItem[] {
  const children = Array.from(el.subpackages.values()).map(p => buildNode(p));
  const types = el.directTypes.map(t => buildLeaf(t));
  return children.concat(types);
}

const sidebar = buildEdges(sidebarRoot);
sidebar[0].collapsed = false;

export default sidebar;
