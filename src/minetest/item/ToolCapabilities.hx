// SPDX-License-Identifier: Zlib
package minetest.item;

import minetest.util.NativeMap;

@:structInit
class ToolCapabilities {

    /**
        The minimum amount of time between weapon uses to deal full damage.
    **/
    @:native("full_punch_interval")
    public var fullPunchInterval: Float;

    /**
        Suggests the maximum level of node that will have a useful drop when dug with this item.
        This value is not used by the engine.
    **/
    @:native("max_drop_level")
    public var maxDropLevel: Int;

    @:native("punch_attack_uses")
    public var punchAttackUses: Int;

    /**
        Supported dig types for digging nodes.
    **/
    @:native("groupcaps")
    public var groupCapabilities: NativeMap<String, GroupCapabilities>;

    /**
        Specifies how much and what type ("fleshy" etc.) of damage will it deal to objects.
    **/
    @:native("damage_groups")
    public var damageGroups: NativeMap<String, Int>;
}

/**
    Capabilities specific to a certain node group.
**/
@:structInit
class GroupCapabilities {

    /**
        The maximum level of a node of this group
        that the item will be able to dig.
    **/
    @:native("maxlevel")
    public var maxLevel: Int;

    /**
        Determines how many uses the tool has
        when used for digging a maximum level node of this group.
        For lower leveled nodes, this value is scaled by the level difference.

        Value of 0 allows for infinite uses.
    **/
    @:native("uses")
    public var uses: Int;

    /**
        Digging times per rating.
    **/
    @:native("times")
    public var times: NativeMap<Int, Float>;
}
