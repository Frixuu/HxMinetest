package minetest.math;

@:native("VoxelManip")
extern final class VoxelManip {
    @:selfCall
    public function new(p1: Any, p2: Any);

    @:native("read_from_map")
    public function readFromMap(p1: Any, p2: Any): Dynamic;

    @:native("write_to_map")
    public function writeToMap(recalculateLight: Bool): Dynamic;

    @:native("update_liquids")
    public function updateLiquids(): Dynamic;
}
