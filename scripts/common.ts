// SPDX-License-Identifier: Zlib
import { semver } from "./deps.ts";

const textDecoder = new TextDecoder();

/**
 * Asserts that Haxe is present on the PATH and is newer than some version, otherwise quits.
 * @param minVersion The minimum version required to pass the assertion. Defaults to 4.3.0.
 */
export async function assertHaxeExists(minVersion?: string): Promise<void> {
  minVersion = semver.valid(minVersion ?? null) ?? "4.3.0";
  try {
    const haxe = Deno.run({ cmd: ["haxe", "--version"], stdout: "piped" });
    const version = textDecoder.decode(await haxe.output()).trim();
    haxe.close();
    if (!semver.valid(version)) {
      console.error(
        `%cHaxe exists, but running --version gave unexpected output: "${version}"`,
        "color: red",
      );
      Deno.exit(33);
    } else if (semver.gt(minVersion, version)) {
      console.error(
        `%cHaxe exists, but version ${minVersion} is required (have: ${version})`,
        "color: red",
      );
      Deno.exit(34);
    }
  } catch (e) {
    if (e instanceof Deno.errors.NotFound) {
      console.error(
        "%cHaxe was not found on this machine, bailing",
        "color: red",
      );
      Deno.exit(2);
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
