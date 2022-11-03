package minetest.node;

import minetest.math.Vector;
import haxe.extern.EitherType;
import minetest.util.LuaArray;
import minetest.util.LuaMap;

@:structInit
class NodeDefinition {
    @:native("description")
    public var description: Null<String> = null;

    @:native("tiles")
    public var tiles: Null<LuaArray<String>> = null;

    @:native("is_ground_content")
    public var isGroundContent: Null<Bool> = null;

    @:native("groups")
    public var groups: Null<LuaMap<String, Int>> = null;

    @:native("drop")
    public var drop: Null<EitherType<String, Dynamic>> = null;

    @:native("on_destruct")
    public var onDestruct: Null<Dynamic> = null;
}
