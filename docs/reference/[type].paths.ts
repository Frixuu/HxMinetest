import { data as typeDefs } from "./generation/rtti.data";

export default {

  async paths() {

    return typeDefs.map(def => {
      return {
        params: { type: def.path.toString(), },
        content: def.renderMarkdownReference(),
      }
    });
  }
}
