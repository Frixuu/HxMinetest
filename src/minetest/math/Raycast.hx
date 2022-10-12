package minetest.math;

@:native("Raycast")
extern final class Raycast {
    @:selfCall
    public function new(start: Any, end: Any, includeObjects: Bool, includeLiquids: Bool);

    @:native("next")
    public function next(): Null<Any>;
}
