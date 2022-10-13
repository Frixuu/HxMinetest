package minetest.client;

#if csm
interface LocalPlayer {
    @:native("get_name")
    function getName(): String;
}
#end
