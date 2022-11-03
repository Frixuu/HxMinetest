package minetest.math;

@:native("PerlinNoiseMap")
extern final class PerlinNoiseMap {
    @:selfCall
    public function new(params: NoiseParams, size: Any);

    @:native("get_3d_map_flat")
    public function get3DMapFlat(pos: Any, ?buffer: Any): Null<Dynamic>;
}
