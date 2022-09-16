import minetest.Settings;
import haxe.extern.EitherType;
import minetest.audio.SoundHandle;
import minetest.audio.SoundParams;
import minetest.colors.ColorString;
import minetest.data.PlayerRef;
import minetest.Events.ChatMessageCallback;
import minetest.Events.PlayerJoinCallback;
import minetest.insecure.InsecureEnvironment;
import minetest.LogLevel;
import minetest.metadata.StorageRef;

/**
    The main namespace of the Minetest game engine.
**/
@:native("minetest")
extern class Minetest {
    @:native("settings")
    static var settings: Settings;

    @:native("after")
    static function after(delay: Float, callback: () -> Void): Void;
    @:native("log")
    static function log(level: LogLevel, message: String): Void;
    @:native("register_on_joinplayer")
    static function registerOnPlayerJoin(callback: PlayerJoinCallback): Void;
    @:native("register_on_chat_message")
    static function registerOnChatMessage(callback: ChatMessageCallback): Void;
    @:native("get_player_by_name")
    static function getPlayerByName(name: String): Null<PlayerRef>;

    /**
        Sends a chat message to all online players.
    **/
    @:native("chat_send_all")
    static function chatSendAll(text: String): Void;

    /**
        Sends a chat message to a player with a specified name.
    **/
    @:native("chat_send_player")
    static function chatSendPlayer(name: String, text: String): Void;

    @:native("get_current_modname")
    static function getCurrentModName(): Null<String>;
    @:native("get_modpath")
    static function getModPath(modName: String): Null<String>;

    /**
        Gets the mod storage associated with this mod.

        NOTE: This method is safe to call only during load time (in main).
    **/
    @:native("get_mod_storage")
    static function getModStorage(): StorageRef;

    @:native("request_insecure_environment")
    static function requestInsecureEnvironment(): Null<InsecureEnvironment>;

    /**
        Prepares a string for client-side translation.
    **/
    @:native("translate")
    static function translate(domain: String, text: String, ...args: Any): String;

    @:native("sound_play")
    static function soundPlay(spec: Any,
        parameters: NativeSoundParams,
        ephemeral: Bool = false): EitherType<Void, SoundHandle>;

    @:native("sound_stop")
    static function soundStop(handle: SoundHandle): Void;

    @:native("sound_fade")
    static function soundFade(handle: SoundHandle, step: Float, gain: Float): Void;
    @:native("get_color_escape_sequence")
    static function getColorEscapeSequence(color: ColorString): String;
    @:native("get_background_escape_sequence")
    static function getBackgroundEscapeSequence(color: ColorString): String;
    @:native("colorize")
    static function colorize(color: ColorString, message: String): String;
    @:native("strip_foreground_colors")
    static function stripForegroundColors(message: String): String;
    @:native("strip_background_colors")
    static function stripBackgroundColors(message: String): String;
    @:native("strip_colors")
    static function stripColors(message: String): String;
}
