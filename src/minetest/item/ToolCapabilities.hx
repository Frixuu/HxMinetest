// SPDX-License-Identifier: Zlib
package minetest.item;

import lua.Table;
import minetest.util.NativeMap;

@:structInit
@:build(minetest.macro.Abstracts.forwardProperties())
abstract ToolCapabilities(Table<String, Any>) {

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

    private inline function new(
        fullPunchInterval: Float,
        maxDropLevel: Int,
        punchAttackUses: Int,
        groupCapabilities: NativeMap<String, GroupCapabilities>,
        damageGroups: NativeMap<String, Int>
    ) {
        this = Table.create(null, {
            full_punch_interval: fullPunchInterval,
            max_drop_level: maxDropLevel,
            punch_attack_uses: punchAttackUses,
            groupcaps: groupCapabilities,
            damage_groups: damageGroups
        });
    }
}

/**
    Capabilities specific to a certain node group.
**/
@:structInit
@:build(minetest.macro.Abstracts.forwardProperties())
abstract GroupCapabilities(Table<String, Any>) {

    /**
        The maximum level of a node of this group
        that the item will be able to dig.
    **/
    @:native("max_level")
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

    private inline function new(
        maxLevel: Int,
        uses: Int,
        times: NativeMap<Int, Float>
    ) {
        this = Table.create(null, {
            maxlevel: maxLevel,
            uses: uses,
            times: times
        });
    }
}
