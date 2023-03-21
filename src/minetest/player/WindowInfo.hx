package minetest.player;

import minetest.math.Vector;

/**
    @since Minetest 5.7.0
**/
interface WindowInfo {
    @:native("size")
    var size: Vector;
    @:native("max_formspec_size")
    var maxFormspecSize: Vector;
    @:native("real_gui_scaling")
    var realGuiScaling: Float;
    @:native("real_hud_scaling")
    var realHudScaling: Float;
}
