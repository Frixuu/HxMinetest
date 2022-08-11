package minetest.metadata;

import haxe.extern.EitherType;
import minetest.item.InventoryRef;

/**
    Metadata available on a singular node.
**/
extern interface NodeMetaRef extends MetaDataRef {
    /**
        Gets a reference to a single inventory associated with the node.
    **/
    @:native("get_inventory")
    function getInventory(): InventoryRef;

    /**
        Marks specific keys as private, preventing them from being sent to the client.

        Note: the private status will only be remembered if a key-value pair exists.
    **/
    @:native("mark_as_private")
    function markAsPrivate(keys: EitherType<String, Array<String>>): Void;
}
