package minetest.math;

import lua.Table.AnyTable;

@:native("PerlinNoiseMap")
extern final class PerlinNoiseMap {
    @:selfCall
    public function new(params: NoiseParams, size: Vector);

    @:native("get_3d_map_flat")
    @:overload(function(pos: Any): AnyTable {})
    @:overload(function(pos: Any, intoBuffer: AnyTable): Void {})
    public function get3DMapFlat(pos: Any, ?buffer: Any): Null<Dynamic>;
}
