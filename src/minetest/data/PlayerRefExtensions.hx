package minetest.data;

import minetest.audio.SoundParams;
import minetest.audio.SoundHandle;

/**
    These extensions provide idiomatic functions for the player object
    that should be easier to use than their plain Lua counterparts.
**/
class PlayerRefExtensions {
    /**
        Plays a sound for that player only.

        Equivalent to `Sounds.play(....audience(OnePlayer(name)))`.
        @param soundName Name of the sound to be played (without the `.ogg` suffix).
        @param params (Optional) Parameters of the sound (pitch, location etc.).
    **/
    public static function playSound(player: PlayerRef, soundName: String, ?params: SoundParams): SoundHandle {
        params = params != null ? params : new SoundParams();
        params = params.audience(OnePlayer(player.getPlayerName()));
        return cast Minetest.soundPlay(soundName, params.toNative(), false);
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
        params = params != null ? params : new SoundParams();
        params = params.audience(OnePlayer(player.getPlayerName()));
        Minetest.soundPlay(soundName, params.toNative(), true);
    }

    /**
        Sends a chat message to that player.
    **/
    public static function sendChatMessage(player: PlayerRef, text: String) {
        final playerName = player.getPlayerName();
        if (playerName != "") {
            Minetest.chatSendPlayer(playerName, text);
        }
    }
}
