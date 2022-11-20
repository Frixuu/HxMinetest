package minetest.player;

import haxe.exceptions.ArgumentException;
import lua.Lua;
import minetest.data.PlayerRef;

class PlayerLikeTools {
    public static function getName(player: PlayerLike): String {
        return if (Lua.type(player) == "string") {
            cast player;
        } else if (Minetest.isPlayer(player)) {
            final playerRef: PlayerRef = cast player;
            playerRef.getPlayerName();
        } else {
            throw new ArgumentException("`player` must be a string or an ObjectRef");
        };
    }
}
