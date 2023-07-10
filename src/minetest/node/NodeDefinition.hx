package minetest.node;

import minetest.data.ObjectRef;
import minetest.item.ItemDefinition;
import lua.Table.AnyTable;
import haxe.extern.EitherType;
import minetest.util.NativeArray;
import minetest.util.NativeMap;

class NodeDefinition extends ItemDefinition {
    public function new() {
        super();
    }

    @:native("paramtype")
    public var paramtype: Null<ParamType>;

    @:native("paramtype2")
    public var paramtype2: Null<ParamType2>;

    @:native("drawtype")
    public var drawtype: Null<DrawType>;

    @:native("sunlight_propagates")
    public var sunlightPropagates: Null<Bool>;

    /**
        If true, objects will be able to collide with this node.
    **/
    @:native("walkable")
    public var walkable: Null<Bool>;

    @:native("pointable")
    public var pointable: Null<Bool>;

    /**
        If false, will not be able to be dug.
    **/
    @:native("diggable")
    public var diggable: Null<Bool>;

    /**
        If true, can be climbed on (eg. like a ladder).
    **/
    @:native("climbable")
    public var climbable: Null<Bool>;

    @:native("buildable_to")
    public var buildableTo: Null<Bool>;

    @:native("air_equivalent")
    public var airEquivalent: Null<Bool>;

    @:native("node_box")
    public var nodeBox: Null<Dynamic>;

    @:native("tiles")
    public var tiles: Null<NativeArray<EitherType<String, AnyTable>>>;

    @:native("special_tiles")
    public var specialTiles: Null<NativeArray<EitherType<String, AnyTable>>>;

    @:native("overlay_tiles")
    public var overlayTiles: Null<NativeArray<EitherType<String, AnyTable>>>;

    @:native("use_texture_alpha")
    public var useTextureAlpha: Null<AlphaMode>;

    @:native("is_ground_content")
    public var isGroundContent: Null<Bool>;

    @:native("drop")
    public var drop: Null<EitherType<String, Dynamic>>;

    @:native("on_destruct")
    public var onDestruct: Null<Dynamic>;

    @:native("waving")
    public var waving: Null<WavingType>;
}

enum abstract ParamType(String) {
    public var Light = "light";
    public var None = "none";
}

enum abstract ParamType2(String) {
    public var FlowingLiquid = "flowingliquid";
    public var WallMounted = "wallmounted";
    public var FaceDir = "facedir";
    public var FourDir = "4dir";
    public var Leveled = "leveled";
    public var Degrogate = "degrogate";
    public var MeshOptions = "meshoptions";
    public var Color = "color";
    public var ColorFaceDir = "colorfacedir";
    public var ColorFourDir = "color4dir";
    public var ColorWallMounted = "colorwallmounted";
    public var GlasslikeLiquidLevel = "glasslikeliquidlevel";
    public var ColorDegrogate = "colordegrogate";
    public var None = "none";
}
