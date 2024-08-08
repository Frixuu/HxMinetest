// SPDX-License-Identifier: Zlib
package minetest.math;

import minetest.node.ContentId;
import minetest.util.NativeArray;

@:native("VoxelManip")
extern final class VoxelManip {
    @:selfCall
    public function new(p1: Any, p2: Any);

    @:native("read_from_map")
    public function readFromMap(p1: Any, p2: Any): Dynamic;

    @:native("write_to_map")
    public function writeToMap(recalculateLight: Bool = true): Dynamic;

    @:native("update_liquids")
    public function updateLiquids(): Void;

    @:native("get_data")
    @:overload(function(): NativeArray<ContentId> {})
    public function getData(intoBuffer: NativeArray<ContentId>): Void;

    @:native("set_data")
    public function setData(buffer: NativeArray<ContentId>): Void;

    @:native("calc_lighting")
    public function calcLighting(
        ?min: Vector,
        ?max: Vector,
        ?propagateShadow: Bool = true
    ): Void;
}
