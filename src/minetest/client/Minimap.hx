package minetest.client;

#if csm
interface Minimap {
    @:native("show")
    function show(): Void;
}
#end
