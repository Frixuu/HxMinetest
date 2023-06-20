package minetest.node;

import minetest.math.Vector;
import haxe.extern.EitherType;
import minetest.util.NativeArray;
import minetest.util.NativeMap;

@:structInit
class NodeDefinition {
    @:native("description")
    public var description: Null<String> = null;

    @:native("tiles")
    public var tiles: Null<NativeArray<String>> = null;

    @:native("is_ground_content")
    public var isGroundContent: Null<Bool> = null;

    @:native("groups")
    public var groups: Null<NativeMap<String, Int>> = null;

    @:native("drop")
    public var drop: Null<EitherType<String, Dynamic>> = null;

    @:native("on_destruct")
    public var onDestruct: Null<Dynamic> = null;
}
