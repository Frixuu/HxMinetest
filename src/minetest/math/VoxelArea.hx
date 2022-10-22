package minetest.math;

import lua.NativeIterator;

@:native("VoxelArea")
extern class VoxelArea {
    @:native("MinEdge")
    public var minEdge: Vector;

    @:native("MaxEdge")
    public var maxEdge: Vector;

    @:native("ystride")
    public var yStride: Int;

    @:native("zstride")
    public var zStride: Int;

    /**
        @since Minetest 5.7.0
    **/
    @:selfCall
    public function new(minEdge: Vector, maxEdge: Vector);

    /**
        Returns "a 3D vector containing the size of the area
        formed by `minEdge` and `maxEdge`".
    **/
    @:native("getExtent")
    public function getExtent(): Vector;

    /**
        Returns "the volume of the area formed by `minEdge` and `maxEdge`".
    **/
    @:native("getVolume")
    public function getVolume(): Float;

    /**
        Returns "the index of an absolute position in a flat array starting at 1".

        The position (x, y, z) is assumed to be inside the area volume,
        but is not checked for that.
    **/
    @:native("index")
    public function index(x: Int, y: Int, z: Int): Index;

    /**
        Similar to `index`, but takes a `Vector` as an argument.

        Note: As with `index`, the vector coordinates must be integers.
    **/
    @:native("indexp")
    public function indexp(p: Vector): Index;

    /**
        Returns an absolute posiiton vector corresponding to the provided `index`.
    **/
    @:native("position")
    public function position(index: Index): Vector;

    /**
        Checks if the provided coordinates are inside the area volume.
    **/
    @:native("contains")
    public function contains(x: Float, y: Float, z: Float): Bool;

    @:native("containsp")
    public function containsPosition(position: Vector): Bool;

    @:native("containsi")
    public function containsIndex(index: Index): Bool;

    @:native("iter")
    public function iter(
        minX: Int, minY: Int, minZ: Int,
        maxX: Int, maxY: Int, maxZ: Int
    ): NativeIterator<Index>;

    @:native("iterp")
    public function iterp(minP: Vector, maxP: Vector): NativeIterator<Index>;
}

abstract Index(Int) from Int to Int {}
