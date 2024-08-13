package minetest.client;

import minetest.SimpleResult;
import minetest.hud.HudDefinition;
import minetest.hud.HudHandle;
import minetest.math.Vector;

#if hxminetest._clientside
interface LocalPlayer {
    @:native("get_name")
    public function getName(): String;

    @:native("get_hp")
    public function getHp(): Int;

    @:native("get_pos")
    public function getPos(): Vector<Float>;

    @:native("is_touching_ground")
    public function isTouchingGround(): Bool;

    @:native("is_in_liquid")
    public function isInLiquid(): Bool;

    @:native("is_in_liquid_stable")
    public function isInLiquidStable(): Bool;

    @:native("hud_add")
    public function addHud(element: HudDefinition): HudHandle;

    @:native("hud_get")
    public function getHud(handle: HudHandle): HudDefinition;

    @:native("hud_change")
    public function changeHud(handle: HudHandle, propertyName: String, value: Any): SimpleResult;

    @:native("hud_remove")
    public function removeHud(handle: HudHandle): SimpleResult;
}
#end
