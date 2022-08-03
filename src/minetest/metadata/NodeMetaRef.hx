package minetest.metadata;

import minetest.item.InventoryRef;

extern abstract class NodeMetaRef extends MetaDataRef {
	@:native("get_inventory")
	function get_inventory():InventoryRef;
	@:native("mark_as_private")
	@:overload(function(name:String):Void {})
	function markAsPrivate(names:Array<String>):Void;
}
