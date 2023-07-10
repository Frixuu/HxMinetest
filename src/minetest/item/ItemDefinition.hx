package minetest.item;

import minetest.data.ObjectRef;
import minetest.colors.ColorString;
import minetest.math.Vector;
import minetest.util.NativeMap;

class ItemDefinition {

    /**
        Creates a new item definition.
    **/
    public function new() {}

    /**
        Description of the item. Can contain new lines.
    **/
    @:native("description")
    public var description: Null<String>;

    /**
        Short description of the item. Must not contain new lines.
    **/
    @:native("short_description")
    public var shortDescription: Null<String>;

    /**
        Maps names of groups to their numeric ratings.
        If rating is not applicable, use 1.
    **/
    @:native("groups")
    public var groups: Null<NativeMap<String, Int>>;

    @:native("inventory_image")
    public var inventoryImage: Null<String>;

    @:native("inventory_overlay")
    public var inventoryOverlay: Null<String>;

    @:native("wield_image")
    public var wieldImage: Null<String>;

    @:native("wield_overlay")
    public var wieldOverlay: Null<String>;

    @:native("wield_scale")
    public var wieldScale: Null<Vector<Int>>;

    @:native("palette")
    public var palette: Null<String>;

    @:native("color")
    public var color: Null<ColorString>;

    @:native("stack_max")
    public var stackMaxSize: Null<UInt>;

    @:native("range")
    public var range: Null<Float>;

    @:native("liquids_pointable")
    public var liquidsPointable: Null<Bool>;

    @:native("lightSource")
    public var lightSource: Null<Int>;

    @:native("tool_capabilities")
    public var toolCapabilities: Null<ToolCapabilities>;

    @:native("node_placement_prediction")
    public var nodePlacementPrediction: Null<String>;

    @:native("node_dig_prediction")
    public var nodeDigPrediction: Null<String>;

    @:native("sound")
    public var sounds: Null<Any>;

    @:native("on_place")
    public var onPlace: Null<(itemstack: Dynamic, placer: Null<ObjectRef>, pointedThing: Dynamic) ->
        Dynamic>;
}
