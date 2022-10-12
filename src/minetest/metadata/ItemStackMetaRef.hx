package minetest.metadata;

/**
    References functionality stored in an item stack.
**/
extern interface ItemStackMetaRef extends MetaDataRef {

    /**
        Overrides the item's tool capabilities.
        If called with null (no override), restores the original behavior.
    **/
    @:native("set_tool_capabilities")
    public function setToolCapabilities(?capabilities: Any): Void;
}
