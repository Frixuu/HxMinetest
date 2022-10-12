package minetest.data;

import minetest.hud.HudDefinition;
import minetest.hud.HudHandle;

/**
    A reference to some ServerActiveObject.

    The reference can become invalid when an object it is refering to
    gets unloaded or removed.
**/
extern interface ObjectRef {

    /**
        If the object is a player, returns that player's name.
        Otherwise returns an empty string.
    **/
    @:native("get_player_name")
    public function getPlayerName(): String;
    @:native("get_breath")
    public function getBreath(): UInt;

    @:native("set_breath")
    public function setBreath(value: UInt): Void;

    @:native("hud_add")
    public function hudAdd(definition: HudDefinition): Null<HudHandle>;

    @:native("hud_remove")
    public function hudRemove(handle: HudHandle): Void;
}
