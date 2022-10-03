package minetest.math;

import haxe.extern.EitherType;

/**
    A vector of 3 floats.
    @since Minetest 5.5.0
**/
@:native("vector")
extern class Vector {
    var x: Float;
    var y: Float;
    var z: Float;

    @:native("new")
    public function new(x: Float, y: Float, z: Float);

    @:native("zero")
    public static function zero(): Vector;

    @:native("offset")
    public static function offset(v: Vector, x: Float, y: Float, z: Float): Vector;

    @:native("add")
    public static function add(a: Vector, b: EitherType<Vector, Float>): Vector;
}
