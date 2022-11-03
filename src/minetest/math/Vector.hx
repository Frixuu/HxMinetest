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
    public function offset(x: Float, y: Float, z: Float): Vector;

    @:native("add")
    public function add(other: EitherType<Vector, Float>): Vector;

    @:native("distance")
    private static function distanceRaw(p1: Vector, p2: Vector): Float;

    public inline function distance(other: Vector): Float {
        return distanceRaw(this, other);
    }
}
