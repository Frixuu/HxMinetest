// SPDX-License-Identifier: Zlib
package minetest.data;

import haxe.extern.EitherType;
import lua.UserData;
import minetest.hud.HudDefinition;
import minetest.hud.HudHandle;
import minetest.item.ToolCapabilities;
import minetest.math.Vector;
import minetest.object.ObjectProperties;

/**
    A reference to some ServerActiveObject.

    The reference can become invalid when an object it is refering to
    gets unloaded or removed.

    API NOTE: For clarity, the return type on signatures below assume the object is still valid.
    If that is not the case, the return value will almost always be `null`.
**/
abstract ObjectRef(UserData) {

    /**
        If the referenced object is a "Lua entity",
        queues it for removal and instantly invalidates this reference.
    **/
    public inline function remove(): Void {
        untyped this.remove();
    }

    /**
        Checks if this reference is still valid.
    **/
    public inline function isValid(): Bool {
        return untyped this.is_valid();
    }

    /**
        Returns the base position of the referenced object.
    **/
    public inline function getPosition(): Vector<Float> {
        return untyped this.get_pos();
    }

    /**
        Sets the position of the referenced object, if it is not in an attached state.
    **/
    public inline function setPosition(pos: Vector<Float>): Void {
        untyped this.set_pos(pos);
    }

    /**
        Offsets the position of the referenced object by a given vector.
    **/
    public inline function addPosition(pos: Vector<Float>): Void {
        untyped this.add_pos(pos);
    }

    /**
        Simulates a punch, triggering real consequences.
        @return Added tool wear.
    **/
    public inline function punch(
        puncher: Null<ObjectRef>,
        ?timeFromLastPunch: Float,
        ?toolCapabilities: ToolCapabilities,
        ?direction: Vector<Float>
    ): UInt {
        return untyped this.punch(puncher, timeFromLastPunch, toolCapabilities, direction);
    }

    /**
        If a "Lua entity" is referenced, does an interpolated move.
        @param pos Target position.
        @param continuous When true, "the Lua entity will not be moved to the current position
        before starting the interpolated move."
    **/
    public inline function moveTo(pos: Vector<Float>, continuous: Bool = false): Void {
        untyped this.move_to(pos, continuous);
    }

    /**
        If the object is a player, returns that player's name;
        otherwise returns an empty string.
    **/
    public inline function getPlayerName(): String {
        return untyped this.get_player_name();
    }

    public inline function getBreath(): UInt {
        return untyped this.get_breath();
    }

    public inline function setBreath(value: UInt): Void {
        untyped this.set_breath(value);
    }

    public inline function getProperties(): ObjectProperties {
        return untyped this.get_properties();
    }

    public inline function setProperties(props: EitherType<ObjectProperties, Dynamic>): Void {
        untyped this.set_properties(props);
    }

    /**
        Adds a defined HUD element.
    **/
    public inline function hudAdd(definition: HudDefinition): HudHandle {
        return untyped this.hud_add(definition);
    }

    /**
        Removes a single HUD element.
    **/
    public inline function hudRemove(handle: HudHandle): Void {
        untyped this.hud_remove(handle);
    }

    public inline function setHealth(hp: UInt, reason: PlayerHealthChangeReason): Void {
        untyped this.set_hp(hp, reason);
    }
}
