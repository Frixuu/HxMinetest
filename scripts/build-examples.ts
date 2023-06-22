// SPDX-License-Identifier: Zlib
import { path } from "./deps.ts";
import { abort, assertHaxeExists, pathFromMeta, print } from "./common.ts";

await assertHaxeExists();

const textDecoder = new TextDecoder();

const examplesDir = path.join(pathFromMeta(import.meta), "..", "..", "examples");
const examples = Array.from(Deno.readDirSync(examplesDir));

const countTotal = examples.length;
let countFailed = 0;

console.log(`Building ${countTotal} examples...`);
for (const [i, example] of examples.entries()) {

  print(` ${(i + 1).toString(10).padStart(2)}) ${example.name}: `);

  const timeStart = performance.now();
  const cwd = path.join(examplesDir, example.name);
  const command = new Deno.Command("haxe", { args: ["build.hxml"], cwd, stderr: "piped" });
  const { success, stderr } = await command.output();
  const timeSpent = Math.round(performance.now() - timeStart);

  if (success) {
    console.log(`%cOK %c(${timeSpent} ms)`, "color: green;", "");
  } else {
    console.log(`%cFAILED %c(${timeSpent} ms)`, "color: red;", "");
    console.error(textDecoder.decode(stderr));
    countFailed += 1;
  }
}

if (countFailed > 0) {
  abort(`Building ${countFailed} out of ${countTotal} examples failed.`);
}
