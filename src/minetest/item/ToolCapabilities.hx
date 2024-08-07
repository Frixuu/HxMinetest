// SPDX-License-Identifier: Zlib
package minetest.item;

import lua.Table;
import minetest.util.NativeMap;

@:structInit
abstract ToolCapabilities(Table<String, Any>) {

    /**
        The minimum amount of time between weapon uses to deal full damage.
    **/
    public var fullPunchInterval(get, set): Float;

    private inline function get_fullPunchInterval(): Float {
        return untyped this.full_punch_interval;
    }

    private inline function set_fullPunchInterval(value: Float): Float {
        return untyped this.full_punch_interval = value;
    }

    /**
        Suggests the maximum level of node that will have a useful drop when dug with this item.
        This value is not used by the engine.
    **/
    public var maxDropLevel(get, set): Int;

    private inline function get_maxDropLevel(): Int {
        return untyped this.max_drop_level;
    }

    private inline function set_maxDropLevel(value: Int): Int {
        return untyped this.max_drop_level = value;
    }

    public var punchAttackUses(get, set): Int;

    private inline function get_punchAttackUses(): Int {
        return untyped this.punch_attack_uses;
    }

    private inline function set_punchAttackUses(value: Int): Int {
        return untyped this.punch_attack_uses = value;
    }

    /**
        Supported dig types for digging nodes.
    **/
    public var groupCapabilities(get, set): NativeMap<String, GroupCapabilities>;

    private inline function get_groupCapabilities(): NativeMap<String, GroupCapabilities> {
        return untyped this.groupcaps;
    }

    private inline function set_groupCapabilities(
        value: NativeMap<String, GroupCapabilities>
    ): NativeMap<String, GroupCapabilities> {
        return untyped this.groupcaps = value;
    }

    /**
        Specifies how much and what type ("fleshy" etc.) of damage will it deal to objects.
    **/
    public var damageGroups(get, set): NativeMap<String, Int>;

    private inline function get_damageGroups(): NativeMap<String, Int> {
        return untyped this.damage_groups;
    }

    private inline function set_damageGroups(
        value: NativeMap<String, Int>
    ): NativeMap<String, Int> {
        return untyped this.damage_groups = value;
    }

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
abstract GroupCapabilities(Table<String, Any>) {

    /**
        The maximum level of a node of this group
        that the item will be able to dig.
    **/
    public var maxLevel(get, set): Int;

    private inline function get_maxLevel(): Int {
        return untyped this.maxlevel;
    }

    private inline function set_maxLevel(value: Int): Int {
        return untyped this.maxlevel = value;
    }

    /**
        Determines how many uses the tool has
        when used for digging a maximum level node of this group.
        For lower leveled nodes, this value is scaled by the level difference.

        Value of 0 allows for infinite uses.
    **/
    public var uses(get, set): Int;

    private inline function get_uses(): Int {
        return untyped this.uses;
    }

    private inline function set_uses(value: Int): Int {
        return untyped this.uses = value;
    }

    /**
        Digging times per rating.
    **/
    public var times(get, set): NativeMap<Int, Float>;

    private inline function get_times(): NativeMap<Int, Float> {
        return untyped this.times;
    }

    private inline function set_times(value: NativeMap<Int, Float>): NativeMap<Int, Float> {
        return untyped this.times = value;
    }

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
