package minetest.worldgen;

import lua.Table;
import minetest.math.Vector;
import minetest.math.VoxelManip;

abstract VoxelManipResult(AnyTable) {
    public var vm(get, never): VoxelManip;

    public inline function get_vm(): VoxelManip {
        return this[1];
    }

    public var emergedMin(get, never): Vector;

    public inline function get_emergedMin(): Vector {
        return this[2];
    }

    public var emergedMax(get, never): Vector;

    public inline function get_emergedMax(): Vector {
        return this[3];
    }
}
