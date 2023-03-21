package minetest.worldgen;

interface SchematicData {
    @:native("size")
    var size: Any;
    @:native("yslice_prob")
    var ysliceProb: Null<Any>;
    @:native("data")
    var data: Any;
}
