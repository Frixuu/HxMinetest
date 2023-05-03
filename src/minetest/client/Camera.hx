package minetest.client;

#if csm
import lua.Table;
import minetest.math.Vector;

interface Camera {
    @:native("get_camera_mode")
    private function getMode(): CameraMode;

    @:native("set_camera_mode")
    private function setMode(mode: CameraMode): Void;

    @:native("get_fov")
    function getFov(): FovTable;

    @:native("get_pos")
    function getPos(): Vector;

    @:native("get_offset")
    function getOffset(): Vector;

    @:native("get_look_dir")
    function getLookDir(): Vector;

    @:native("get_look_vertical")
    function getLookVertical(): Float;

    @:native("get_look_horizontal")
    function getLookHorizontal(): Float;

    @:native("get_aspect_ratio")
    function getAspectRatio(): Float;
}
#end
