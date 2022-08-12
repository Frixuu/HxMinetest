package minetest.hud;

abstract class Control {
    private var _zIndex: Int = 0;

    public abstract function buildNativeDefinition(): HudDefinition;
}
