// SPDX-License-Identifier: Zlib
package minetest.worldgen.schematic;

@:build(minetest.macro.Flags.addOperators())
enum abstract DecorationStrategy(String) {

    /**
        If set, nodes other that "air" and "ignore"
        will also be replaced by the decoration.
    **/
    public var ForcePlacement = "force_placement";

    /**
        Instead of placement on the highest solid surface,
        places the decoration on the highest liquid surface.
    **/
    public var LiquidSurface = "liquid_surface";

    /**
        Instead of placement on the highest surface,
        the decoration is placed on all floor surfaces (eg. in caves or dungeons).
    **/
    public var AllFloors = "all_floors";

    /**
        Instead of placement on the highest surface,
        the decoration is placed on all ceiling surfaces (eg. in caves or dungeons).
    **/
    public var AllCeilings = "all_ceilings";
}
