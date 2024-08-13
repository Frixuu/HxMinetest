// SPDX-License-Identifier: Zlib

import { abort, assertHaxeExists, decodeUtf8, invokeHaxe } from "./common.ts";

await assertHaxeExists();

const { success, stderr } = await invokeHaxe({
  classpaths: ["src"],
  libraries: ["partials"],
  defines: ["hxminetest._clientside", "hxminetest._serverside"],
  initMacros: ["include('doctest')", "include('minetest')"],
  other: ["--lua", "not.applicable", "--no-output", "--xml", "docs/reference/generation/classes.xml"]
});

if (!success) {
  abort(`Generating XML failed: ${decodeUtf8(stderr)}`);
}
