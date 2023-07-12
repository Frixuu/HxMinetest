// SPDX-License-Identifier: Zlib
package minetest.worldgen.schematic;

@:build(minetest.macro.Flags.addOperators())
enum abstract DecorationPlacement(String) {
    public var PlaceCenterX = "place_center_x";
    public var PlaceCenterY = "place_center_y";
    public var PlaceCenterZ = "place_center_z";
}
