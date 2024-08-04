import { readFile } from "node:fs/promises";
import { join } from "node:path";
import { defineLoader } from "vitepress";
import { Definition } from "./definition";
import { parseRttiXml } from "./parse";

const RTTI_PATH = join(import.meta.dirname, "classes.xml");
const READ_OPTS = { encoding: "utf-8" } as const;

const data: Definition[] = parseRttiXml(await readFile(RTTI_PATH, READ_OPTS));
export { data };

export default defineLoader({
  watch: [RTTI_PATH],
  async load(watchedFiles): Promise<Definition[]> {
    return parseRttiXml(await readFile(watchedFiles[0], READ_OPTS));
  }
});
