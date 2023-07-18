package minetest.math;

import haxe.extern.EitherType;

/**
    A structure consisting of 3 numbers.
**/
@:forward(x, y, z)
abstract Vector<T = Float>(Impl<T>) from Impl<T> to Impl<T> {

    /**
        Creates a new `Vector`.
     */
    public inline function new(x: T, y: T, z: T) {
        this = new Impl(x, y, z);
    }

    @:to
    private static inline function intToFloat(v: Vector<Int>): Vector<Float> {
        return cast v;
    }

    /**
        Creates a new `Vector` (0, 0, 0).
     */
    public static inline function zero<T>(): Vector<T> {
        return Impl.zero();
    }

    /**
        Returns a copy of this `Vector`.
    **/
    public inline function copy(): Vector<T> {
        return this.copy();
    }

    public static inline function fromString<T>(s: String, ?startFrom: Int): FromStringResult<T> {
        return Impl.fromString(s, startFrom);
    }

    public inline function toString(): String {
        return this.toString();
    }

    public inline function direction(other: Vector<T>): Vector<T> {
        return this.direction(other);
    }

    public inline function distance(other: Vector<T>): Float {
        return this.distance(other);
    }

    public inline function length(): Float {
        return this.length();
    }

    public inline function normalize(): Vector<Float> {
        return this.normalize();
    }

    public inline function floor(): Vector<Int> {
        return this.floor();
    }

    public inline function round(): Vector<Int> {
        return this.round();
    }

    public inline function apply<R>(fn: (T) -> R): Vector<R> {
        return this.apply(fn);
    }

    public inline function combine<U, R>(other: Vector<U>, fn: (T, U) -> R): Vector<R> {
        return this.combine(other, fn);
    }

    public inline function equals(other: Vector<T>): Bool {
        return abstract == other;
    }

    @:dox(hide)
    @:op(A == B)
    public static inline function areEqual<T>(a: Vector<T>, b: Vector<T>): Bool {
        return Impl.equals(a, b);
    }

    public inline function angle(other: Vector<T>): Float {
        return this.angle(other);
    }

    public inline function dot(other: Vector<T>): Float {
        return this.dot(other);
    }

    public inline function cross(other: Vector<T>): Vector<T> {
        return this.cross(other);
    }

    @:dox(hide)
    @:op(-A)
    public static inline function negateInt(v: Vector<Int>): Vector<Int> {
        return new Vector(-v.x, -v.y, -v.z);
    }

    @:dox(hide)
    @:op(-A)
    public static inline function negateFloat(v: Vector<Float>): Vector<Float> {
        return new Vector(-v.x, -v.y, -v.z);
    }

    public inline function offset(x: T, y: T, z: T): Vector<T> {
        return this.offset(x, y, z);
    }

    public static inline function check(v: Any): Bool {
        return Impl.check(v);
    }

    public inline function inArea(min: Vector<T>, max: Vector<T>): Bool {
        return this.inArea(min, max);
    }

    public inline function add(other: EitherType<Vector<T>, T>): Vector<T> {
        return this.add(other);
    }

    @:dox(hide)
    @:op(A + B)
    public static inline function addIntInt(a: Vector<Int>, b: Vector<Int>): Vector<Int> {
        return a.add(b);
    }

    @:dox(hide)
    @:op(A + B)
    public static inline function addIntFloat(a: Vector<Int>, b: Vector<Float>): Vector<Float> {
        return cast a.add(untyped b);
    }

    @:dox(hide)
    @:op(A + B)
    public static inline function addFloatInt(a: Vector<Float>, b: Vector<Int>): Vector<Float> {
        return a.add(cast b);
    }

    @:dox(hide)
    @:op(A + B)
    public static inline function addFloatFloat(a: Vector<Float>, b: Vector<Float>): Vector<Float> {
        return a.add(b);
    }

    public inline function subtract(other: EitherType<Vector<T>, T>): Vector<T> {
        return this.subtract(other);
    }

    @:dox(hide)
    @:op(A - B)
    public static inline function subIntInt(a: Vector<Int>, b: Vector<Int>): Vector<Int> {
        return a.subtract(b);
    }

    @:dox(hide)
    @:op(A - B)
    public static inline function subIntFloat(a: Vector<Int>, b: Vector<Float>): Vector<Float> {
        return cast a.subtract(untyped b);
    }

    @:dox(hide)
    @:op(A - B)
    public static inline function subFloatInt(a: Vector<Float>, b: Vector<Int>): Vector<Float> {
        return a.subtract(cast b);
    }

    @:dox(hide)
    @:op(A - B)
    public static inline function subFloatFloat(a: Vector<Float>, b: Vector<Float>): Vector<Float> {
        return a.subtract(b);
    }

    public inline function multiply(a: T): Vector<T> {
        return this.multiply(a);
    }

    @:dox(hide)
    @:op(A * B)
    @:commutative
    public static inline function mulIntInt(a: Vector<Int>, b: Int): Vector<Int> {
        return a.multiply(b);
    }

    @:dox(hide)
    @:op(A * B)
    @:commutative
    public static inline function mulIntFloat(a: Vector<Int>, b: Float): Vector<Float> {
        return cast a.multiply(untyped b);
    }

    @:dox(hide)
    @:op(A * B)
    @:commutative
    public static inline function mulFloatInt(a: Vector<Float>, b: Int): Vector<Float> {
        return a.multiply(b);
    }

    @:dox(hide)
    @:op(A * B)
    @:commutative
    public static inline function mulFloatFloat(a: Vector<Float>, b: Float): Vector<Float> {
        return a.multiply(b);
    }

    public inline function divide(a: Float): Vector<Float> {
        return this.divide(a);
    }

    @:dox(hide)
    @:op(A / B)
    public static inline function divIntInt(a: Vector<Int>, b: Int): Vector<Float> {
        return a.divide(b);
    }

    @:dox(hide)
    @:op(A / B)
    public static inline function divIntFloat(a: Vector<Int>, b: Float): Vector<Float> {
        return a.divide(b);
    }

    @:dox(hide)
    @:op(A / B)
    public static inline function divFloatInt(a: Vector<Float>, b: Int): Vector<Float> {
        return a.divide(b);
    }

    @:dox(hide)
    @:op(A / B)
    public static inline function divFloatFloat(a: Vector<Float>, b: Float): Vector<Float> {
        return a.divide(b);
    }
}

@:dox(hide)
@:native("vector")
private extern final class Impl<T> {
    public var x: T;
    public var y: T;
    public var z: T;

    @:native("new")
    public function new(x: T, y: T, z: T);

    @:native("zero")
    public static function zero<T>(): Impl<T>;

    @:native("copy")
    public function copy(): Impl<T>;

    @:native("from_string")
    public static function fromString<T>(s: String, startFrom: Null<Int>): FromStringResult<T>;

    @:native("to_string")
    public function toString(): String;

    @:native("direction")
    public function direction(other: Impl<T>): Impl<T>;

    @:native("distance")
    public function distance(other: Impl<T>): Float;

    @:native("length")
    public function length(): Float;

    @:native("normalize")
    public function normalize(): Impl<Float>;

    @:native("floor")
    public function floor(): Impl<Int>;

    @:native("round")
    public function round(): Impl<Int>;

    @:native("apply")
    public function apply<R>(fn: (T) -> R): Impl<R>;

    @:native("combine")
    public function combine<U, R>(other: Impl<U>, fn: (T, U) -> R): Impl<R>;

    @:native("equals")
    public static function equals<T>(a: Impl<T>, b: Impl<T>): Bool;

    @:native("sort")
    public function sort(other: Impl<T>): SortResult<T>;

    @:native("angle")
    public function angle(other: Impl<T>): Float;

    @:native("dot")
    public function dot(other: Impl<T>): Float;

    @:native("cross")
    public function cross(other: Impl<T>): Impl<T>;

    @:native("offset")
    public function offset(x: T, y: T, z: T): Impl<T>;

    @:native("check")
    public static function check<T>(v: Any): Bool;

    @:native("in_area")
    public function inArea(min: Impl<T>, max: Impl<T>): Bool;

    @:native("add")
    public function add(other: EitherType<Impl<T>, T>): Impl<T>;

    @:native("subtract")
    public function subtract(other: EitherType<Impl<T>, T>): Impl<T>;

    @:native("multiply")
    public function multiply(other: T): Impl<T>;

    @:native("divide")
    public function divide(other: Float): Impl<Float>;
}

@:multiReturn
class FromStringResult<T> {
    public var vector: Null<Vector<T>>;
    public var nextPos: Null<Int>;
}

@:multiReturn
class SortResult<T> {
    public var minp: Vector<T>;
    public var maxp: Vector<T>;
}
