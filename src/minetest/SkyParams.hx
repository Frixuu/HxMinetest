package minetest;

import minetest.colors.ColorSpec;

class SkyParams {
    @:native("base_color")
    var baseColor: ColorSpec;

    /**
        @since Minetest 5.7.0
    **/
    @:native("body_orbit_tilt")
    var bodyOrbitTilt: Float;

    @:native("type")
    var type: Null<Dynamic>;
}
