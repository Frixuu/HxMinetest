// SPDX-License-Identifier: Zlib
package minetest.data;

#if hxminetest._serverside
import minetest.audio.SoundHandle;
import minetest.audio.SoundParams;
import minetest.audio.SoundSpec;

/**
    These extensions provide easy-to-use helpers for the player object.
**/
class PlayerTools {

    /**
        Plays a sound for that player only.
        @param params (Optional) Parameters of the sound (pitch, location etc.).
    **/
    public static function playSound(
        player: PlayerRef,
        spec: SoundSpec,
        ?params: SoundParams
    ): SoundHandle {
        params ??= {};
        params.audience = OnePlayer(player.getPlayerName());
        return cast Minetest.soundPlay(spec, params, false);
    }

    /**
        Plays a one-shot sound for that player only.
        @param params (Optional) Parameters of the sound (pitch, location etc.).
    **/
    public static function playSoundEphemeral(
        player: PlayerRef,
        spec: SoundSpec,
        ?params: SoundParams
    ): Void {
        params ??= {};
        params.audience = OnePlayer(player.getPlayerName());
        Minetest.soundPlay(spec, params, true);
    }

    /**
        Sends a chat message to that player.
    **/
    public static inline function sendChatMessage(player: PlayerRef, text: String) {
        final playerName = player.getPlayerName();
        if (playerName != "") {
            Minetest.chatSendPlayer(playerName, text);
        }
    }
}
#end
