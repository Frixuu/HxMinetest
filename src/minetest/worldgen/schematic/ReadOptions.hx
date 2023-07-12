// SPDX-License-Identifier: Zlib
package minetest.worldgen.schematic;

@:structInit
final class ReadOptions {
    @:native("write_yslice_prob")
    public var writeYSliceProb: Null<WriteYSliceProb>;
}

enum abstract WriteYSliceProb(String) {
    public var All = "all";
    public var Low = "low";
    public var None = "none";
}
