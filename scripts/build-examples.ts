// SPDX-License-Identifier: Zlib
import { path } from "./deps.ts";
import { assertHaxeExists, pathFromMeta } from "./common.ts";

await assertHaxeExists();

const textEncoder = new TextEncoder();
const textDecoder = new TextDecoder();

const examplesDir = path.join(pathFromMeta(import.meta), "..", "..", "examples");
const examples = Array.from(Deno.readDirSync(examplesDir));

const countTotal = examples.length;
let countFailed = 0;

console.log(`Building ${countTotal} examples...`);
for (const [i, example] of examples.entries()) {

  const index = (i + 1).toString(10).padStart(2);
  Deno.stdout.writeSync(textEncoder.encode(` ${index}) ${example.name}: `));

  const t0 = performance.now();
  const cwd = path.join(examplesDir, example.name);
  const command = new Deno.Command("haxe", { args: ["build.hxml"], cwd, stderr: "piped" });
  const { success, stderr } = await command.output();
  const t1 = performance.now();

  if (success) {
    console.log(`%cOK %c(${Math.round(t1 - t0)} ms)`, "color: green;", "");
  } else {
    console.log(`%cFAILED %c(${Math.round(t1 - t0)} ms)`, "color: red;", "");
    console.error(textDecoder.decode(stderr));
    countFailed += 1;
  }
}

if (countFailed > 0) {
  console.error(`%cBuilding ${countFailed} out of ${countTotal} examples failed.`, "color: red;");
  Deno.exit(1);
}
