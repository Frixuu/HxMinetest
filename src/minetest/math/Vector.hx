package minetest.math;

import haxe.extern.EitherType;

/**
    A vector of 3 floats.
    @since Minetest 5.5.0
**/
extern class Vector {}
@:native("vector")
private extern class Externs {
    @:native("new")
    public static function create(x: Float, y: Float, z: Float): Vector;

    @:native("zero")
    public static function zero(): Vector;

    @:native("offset")
    public static function offset(v: Vector, x: Float, y: Float, z: Float): Vector;

    @:native("add")
    public static function add(a: Vector, b: EitherType<Vector, Float>): Vector;
}
