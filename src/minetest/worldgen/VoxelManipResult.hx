package minetest.worldgen;

import minetest.math.Vector;
import minetest.math.VoxelManip;

@:multiReturn
extern class VoxelManipResult {
    var vm: VoxelManip;
    var emergedMin: Vector;
    var emergedMax: Vector;
}
