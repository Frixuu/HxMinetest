package minetest.data;

import minetest.audio.Sounds;
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
        var playerName = player.getPlayerName();
        playerName = playerName != null ? playerName : "singleplayer";
        params = params != null ? params : new SoundParams();
        return Sounds.play(soundName, params.audience(OnePlayer(playerName)));
    }

    /**
        Plays a sound for that player only.

        Equivalent to `Sounds.playEphemeral(....audience(OnePlayer(name)))`.
        @param soundName Name of the sound to be played (without the `.ogg` suffix).
        @param params (Optional) Parameters of the sound (pitch, location etc.).
    **/
    public static function playSoundEphemeral(player: PlayerRef, soundName: String, ?params: SoundParams): Void {
        var playerName = player.getPlayerName();
        playerName = playerName != null ? playerName : "singleplayer";
        params = params != null ? params : new SoundParams();
        Sounds.playEphemeral(soundName, params.audience(OnePlayer(playerName)));
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
