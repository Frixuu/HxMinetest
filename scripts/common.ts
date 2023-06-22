// SPDX-License-Identifier: Zlib
import { semver } from "./deps.ts";

const textDecoder = new TextDecoder();
const textEncoder = new TextEncoder();

/**
 * Logs an error message and exits Deno.
 */
export function abort(msg: string, returnCode?: number): never {
  console.error("%c" + msg, "color: red");
  Deno.exit(returnCode ?? 1);
}

/**
 * Pushes text to the standard output without a line break.
 */
export function print(msg: string): void {
  Deno.stdout.writeSync(textEncoder.encode(msg));
}

/**
 * Asserts that Haxe is present on the PATH and is newer than some version, otherwise quits.
 * @param minVersion The minimum version required to pass the assertion. Defaults to 4.3.0.
 */
export async function assertHaxeExists(minVersion?: string): Promise<void> {
  minVersion = semver.valid(minVersion ?? null) ?? "4.3.0";
  try {
    const command = new Deno.Command("haxe", { args: ["--version"], stdout: "piped" });
    const { stdout } = await command.output();
    const version = textDecoder.decode(stdout).trim();
    if (!semver.valid(version)) {
      abort(`Haxe exists, but running --version gave unexpected output: "${version}"`, 33);
    } else if (semver.gt(minVersion, version)) {
      abort(`Haxe exists, but version ${minVersion} is required (have: ${version})`, 34);
    }
  } catch (e) {
    if (e instanceof Deno.errors.NotFound) {
      abort("Haxe was not found on this machine, bailing", 2);
    } else {
      throw e;
    }
  }
}

/**
 * Given an `import.meta` of a TS file, returns a valid path string of that file.
 */
export function pathFromMeta(meta: ImportMeta): string {
  const pathname = new URL(meta.url).pathname;
  return (Deno.build.os == "windows") ? pathname.slice(1) : pathname;
}
