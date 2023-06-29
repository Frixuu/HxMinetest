package minetest;

import haxe.extern.EitherType;
import minetest.math.Vector;
import minetest.util.NativeArray;

@:structInit
class AbmDefinition {
    @:native("nodenames")
    public var nodeNames: Null<EitherType<String, NativeArray<String>>>;

    /**
        If specified, any of the neighbors can be present to run the ABM.
    **/
    @:native("neighbors")
    public var neighbors: Null<EitherType<String, NativeArray<String>>>;
    @:native("action")
    public var action: (pos: Vector<Int>, node: MapNode, count: UInt, countWider: UInt) -> Void;

    /**
        Runs every X seconds.
    **/
    @:native("interval")
    public var interval: Null<Float>;

    /**
        Chance for a node to get selected (1 in X).
    **/
    @:native("chance")
    public var chance: Null<UInt>;
    @:native("min_y")
    public var minY: Null<Int>;
    @:native("max_y")
    public var maxY: Null<Int>;
    @:native("catch_up")
    public var catchUp: Null<Bool>;

    @:native("mod_origin")
    @:dox(hide)
    @:noCompletion
    public var modOrigin: Null<String>;
}
