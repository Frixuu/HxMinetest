package minetest;

interface MapNode {
    @:native("name") public var name: String;
    @:native("param1") public var param1: Int;
    @:native("param2") public var param2: Int;
}
