// SPDX-License-Identifier: Zlib
import { path } from "./deps.ts";
import { assertHaxeExists, pathFromMeta } from "./common.ts";
const textEncoder = new TextEncoder();
const textDecoder = new TextDecoder();

await assertHaxeExists();

const examplesDir = path.join(pathFromMeta(import.meta), "..", "..", "examples");
const examples = Array.from(Deno.readDirSync(examplesDir));
console.log(`Building ${examples.length} examples...`);
let success = true;
for (const example of examples) {

  Deno.stdout.writeSync(textEncoder.encode(`${example.name}: `));

  const t0 = performance.now();
  const cwd = path.join(examplesDir, example.name);
  const haxe = Deno.run({ cmd: ["haxe", "build.hxml"], cwd, stderr: "piped" });
  const [status, stderr] = await Promise.all([haxe.status(), haxe.stderrOutput()]);
  haxe.close();
  const t1 = performance.now();

  if (status.code == 0) {
    console.log(`%cOK %c(${Math.round(t1 - t0)} ms)`, "color: green;", "");
  } else {
    console.log(`%cFAILED %c(${Math.round(t1 - t0)} ms)`, "color: red;", "");
    console.error(textDecoder.decode(stderr));
    success = false;
  }
}

if (!success) {
  console.error("%cBuilding some of the examples failed.", "color: red;");
  Deno.exit(1);
}
