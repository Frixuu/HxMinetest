package minetest.hud;

import minetest.data.PlayerRef;

inline function addHud(player: PlayerRef, control: Control): HudHandle {
    return cast player.hudAddRaw(control.buildNativeDefinition());
}

inline function removeHud(player: PlayerRef, handle: HudHandle) {
    player.hudRemoveRaw(handle);
}
