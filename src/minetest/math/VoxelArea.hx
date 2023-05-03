// SPDX-License-Identifier: Zlib
package minetest.math;

import lua.Table;
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

    @:native("new")
    private static function newRaw(classSelf: Class<VoxelArea>, o: AnyTable): VoxelArea;

    public static inline function create(minEdge: Vector, maxEdge: Vector): VoxelArea {
        return newRaw(VoxelArea, Table.create(null, {MinEdge: minEdge, MaxEdge: maxEdge}));
    }

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
    public function index(x: Int, y: Int, z: Int): Int;

    /**
        Similar to `index`, but takes a `Vector` as an argument.

        Note: As with `index`, the vector coordinates must be integers.
    **/
    @:native("indexp")
    public function indexp(p: Vector): Int;

    /**
        Returns an absolute posiiton vector corresponding to the provided `index`.
    **/
    @:native("position")
    public function position(index: Int): Vector;

    /**
        Checks if the provided coordinates are inside the area volume.
    **/
    @:native("contains")
    public function contains(x: Float, y: Float, z: Float): Bool;

    @:native("containsp")
    public function containsPosition(position: Vector): Bool;

    @:native("containsi")
    public function containsInt(index: Int): Bool;

    @:native("iter")
    public function iter(
        minX: Int, minY: Int, minZ: Int,
        maxX: Int, maxY: Int, maxZ: Int
    ): NativeIterator<Int>;

    @:native("iterp")
    public function iterp(minP: Vector, maxP: Vector): NativeIterator<Int>;
}
