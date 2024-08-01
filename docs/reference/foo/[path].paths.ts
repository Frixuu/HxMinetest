import { readFileSync } from "node:fs";
import { join } from "node:path";
import { parseRttiXml } from "../generation/parse";

export default {

  async paths() {
    const pathname = new URL(import.meta.url).pathname;
    const rttiFile = readFileSync(join(pathname, "..", "..", "classes.xml"), { encoding: "utf-8" });
    const typeDefs = parseRttiXml(rttiFile);
    return typeDefs.map(def => {
      return {
        params: { path: def.path.toString(), },
        content: def.renderMarkdownReference(),
      }
    });
  }
}
