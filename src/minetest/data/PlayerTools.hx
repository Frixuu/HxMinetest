// SPDX-License-Identifier: Zlib
package minetest.data;

#if !csm
import minetest.audio.SoundParams;
import minetest.audio.SoundHandle;

/**
    These extensions provide easy-to-use helpers for the player object.
**/
class PlayerTools {

    /**
        Plays a sound for that player only.
        @param soundName Name of the sound to be played (without the `.ogg` suffix).
        @param params (Optional) Parameters of the sound (pitch, location etc.).
    **/
    public static function playSound(player: PlayerRef, soundName: String, ?params: SoundParams): SoundHandle {
        params = params ?? new SoundParams();
        params = params.audience(OnePlayer(player.getPlayerName()));
        return cast Minetest.soundPlay(soundName, params, false);
    }

    /**
        Plays a one-shot sound for that player only.
        @param soundName Name of the sound to be played (without the `.ogg` suffix).
        @param params (Optional) Parameters of the sound (pitch, location etc.).
    **/
    public static function playSoundEphemeral(
        player: PlayerRef,
        soundName: String,
        ?params: SoundParams
    ): Void {
        params = params ?? new SoundParams();
        params = params.audience(OnePlayer(player.getPlayerName()));
        Minetest.soundPlay(soundName, params, true);
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
