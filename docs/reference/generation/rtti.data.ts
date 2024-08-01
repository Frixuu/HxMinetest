import { defineLoader } from "vitepress";
import { Definition } from "./definition";
import { parseRttiXml } from "./parse";

declare const data: Definition[];
export { data };

export default defineLoader({
  watch: ["../classes.xml"],
  async load(watchedFiles): Promise<Definition[]> {
    const file = await Deno.readTextFile(watchedFiles[0]);
    return parseRttiXml(file);
  }
});
