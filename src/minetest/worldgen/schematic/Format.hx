// SPDX-License-Identifier: Zlib
package minetest.worldgen.schematic;

enum abstract Format(String) {

    /**
        Binary MTS data.
    **/
    public var Mts = "mts";

    /**
        Lua code representing the schematic.
    **/
    public var Lua = "lua";
}
