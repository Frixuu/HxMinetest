package minetest.client;

#if csm
import lua.Table;
import minetest.math.Vector;

interface Camera {
    @:native("set_camera_mode")
    function setCameraMode(mode: CameraMode): Void;

    @:native("get_camera_mode")
    function getCameraMode(): CameraMode;

    @:native("get_fov")
    function getFov(): Table<String, Float>;

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
