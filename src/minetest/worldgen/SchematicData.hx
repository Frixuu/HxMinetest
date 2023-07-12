// SPDX-License-Identifier: Zlib
package minetest.worldgen;

import minetest.math.Vector;

@:remove
interface SchematicData {
    @:native("size")
    public var size: Vector<Int>;
    @:native("yslice_prob")
    public var ysliceProb: Null<Any>;
    @:native("data")
    public var data: Any;
}
