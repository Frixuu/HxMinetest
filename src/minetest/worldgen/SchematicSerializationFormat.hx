package minetest.worldgen;

enum abstract SchematicSerializationFormat(String) {

    /**
        Binary MTS data.
    **/
    var Mts = "mts";

    /**
        Lua code representing the schematic.
    **/
    var Lua = "lua";
}
