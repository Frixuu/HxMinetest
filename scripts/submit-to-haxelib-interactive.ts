// SPDX-License-Identifier: Zlib
import { compress, datetime, path } from "./deps.ts";
import { assertHaxeExists, pathFromMeta } from "./common.ts";

await assertHaxeExists();

const root = path.join(pathFromMeta(import.meta), "..", "..");
const projectName = path.basename(root);
const now = datetime.format(new Date(), "yyyy-MM-dd'T'HH-mm-ss");

const zipPath = path.join(root, `${projectName}_${now}.zip`);
await compress(
  ["haxelib.json", "*.hxml", "LICENSE.txt", "README.md", "src/", "templates/"],
  zipPath,
  { flags: [], overwrite: true }
);

console.log(`Created zip file, size is ${Deno.statSync(zipPath).size} bytes`);
await Deno.run({ cmd: ["haxelib", "submit", zipPath], cwd: root }).status();
