package minetest.client;

#if hxminetest._clientside
interface Minimap {
    @:native("show")
    function show(): Void;
}
#end
