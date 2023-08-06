// SPDX-License-Identifier: Zlib
import { path, semver } from "./deps.ts";

const textDecoder = new TextDecoder();
const textEncoder = new TextEncoder();
const rootDir = path.join(pathFromMeta(import.meta), "..", "..");

export function encodeUtf8(text: string): Uint8Array {
  return textEncoder.encode(text);
}

export function decodeUtf8(bytes: Uint8Array): string {
  return textDecoder.decode(bytes).trim()
}

export function mustArray<T>(o: T | T[] | null | undefined): T[] {
  if (Array.isArray(o)) {
    return o;
  }
  if (o === undefined || o === null) {
    return [];
  }
  return [o];
}

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
 * Invokes the Haxe compiler, assuming it exists.
 */
export async function invokeHaxe(opts: {
  classpaths?: string[],
  libraries?: string[],
  initMacros?: string[],
  other?: string[],
}, cwd?: string): Promise<Deno.CommandOutput> {

  const args: string[] = [];

  for (const classpath of opts.classpaths ?? []) {
    args.push("--class-path", classpath)
  }

  for (const library of opts.libraries ?? []) {
    args.push("--library", library)
  }

  for (const macro of opts.initMacros ?? []) {
    args.push("--macro", macro)
  }

  args.push(...opts.other ?? []);

  const command = new Deno.Command("haxe", {
    cwd: cwd ? path.join(rootDir, cwd) : rootDir,
    stderr: "piped",
    stdout: "piped",
    args: args
  });

  return await command.output();
}

/**
 * Asserts that Haxe is present on the PATH and is newer than some version, otherwise quits.
 * @param minVersion The minimum version required to pass the assertion. Defaults to 4.3.0.
 */
export async function assertHaxeExists(minVersion?: string): Promise<void> {
  minVersion = semver.valid(minVersion ?? null) ?? "4.3.0";
  try {
    const { stdout } = await invokeHaxe({ other: ["--version"] });
    const version = decodeUtf8(stdout);
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
