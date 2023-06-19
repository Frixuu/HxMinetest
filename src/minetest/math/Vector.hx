package minetest.math;

import haxe.extern.EitherType;

/**
    A structure consisting of 3 numbers.
**/
@:native("vector")
extern class Vector<T = Float> {
    public var x: T;
    public var y: T;
    public var z: T;

    @:native("new")
    public function new(x: T, y: T, z: T);

    /**
        Returns a new `Vector` (0, 0, 0).
    **/
    @:native("zero")
    public static function zero<T>(): Vector<T>;

    @:native("offset")
    public function offset(x: T, y: T, z: T): Vector<T>;

    @:native("add")
    public function add(other: EitherType<Vector<T>, T>): Vector<T>;

    @:native("distance")
    public function distance(other: Vector<T>): Float;
}
