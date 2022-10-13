package minetest.client;

#if csm
interface Camera {
    @:native("get_fov")
    function getFov(): Table<String, Float>;
}
#end
