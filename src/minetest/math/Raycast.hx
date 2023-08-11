package minetest.math;

import lua.HaxeIterator;

@:native("Raycast")
extern final class Raycast {
    @:selfCall
    public function new(start: Any, end: Any, includeObjects: Bool, includeLiquids: Bool);

    @:selfCall
    public function next(): Null<Hit>;

    public inline function iterator(): HaxeIterator<Hit> {
        return new HaxeIterator(cast this);
    }
}

interface Hit extends PointedThing {
    @:native("intersection_point")
    public var intersectionPoint: Vector<Float>;
    @:native("intersection_normal")
    public var intersectionNormal: Vector<Float>;
    @:native("box_id")
    public var boxIndex: Int;
}
