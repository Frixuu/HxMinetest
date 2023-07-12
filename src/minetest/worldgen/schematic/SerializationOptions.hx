// SPDX-License-Identifier: Zlib
package minetest.worldgen.schematic;

/**
    Options controlling the process of schematic serialization.
**/
@:structInit
final class SerializationOptions {

    /**
        If the schematic is serialized as Lua code,
        will add positional comments for easier reading.
    **/
    @:native("lua_use_comments")
    public var luaUseComments: Null<Bool>;

    /**
        If the schematic is serialized as Lua code,
        will use that many spaces as indentation. (instead of tab)
    **/
    @:native("lua_num_indent_spaces")
    public var luaNumIndentSpaces: Null<Int>;
}
