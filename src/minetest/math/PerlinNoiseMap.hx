package minetest.math;

import minetest.util.NativeArray;

@:native("PerlinNoiseMap")
extern final class PerlinNoiseMap {

    /**
        Creates a new PerlinNoiseMap.

        To have per-world noise maps, use `Minetest.getPerlinMap`.
    **/
    @:selfCall
    public function new(params: NoiseParams, size: Vector<Int>);

    @:native("get_3d_map_flat")
    @:overload(function(pos: Vector<Int>): NativeArray<Float> {})
    public function get3DMapFlat(pos: Vector<Int>, intoBuffer: NativeArray<Float>): Void;
}
