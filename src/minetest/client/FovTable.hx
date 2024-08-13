package minetest.client;

#if hxminetest._clientside
interface FovTable {
    @:native("x")
    var x: Float;
    @:native("y")
    var y: Float;
    @:native("max")
    var max: Float;
    @:native("actual")
    var actual: Float;
}
#end
