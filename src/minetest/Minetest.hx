package minetest;

import minetest.node.NodeDefinition;
import minetest.craft.Recipe;
import minetest.async.Future;
import lua.Table;
import haxe.Rest;
import minetest.auth.AuthHandler;
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

    /**
        Settings object containing configuration from `minetest.conf`, the main config file.
    **/
    @:native("settings")
    public static var settings(default, null): Settings;

    /**
        Feature flags available for scripting.
    **/
    @:native("features")
    public static var features(default, null): Table<String, Bool>;

    /*******************/
    /*    UTILITIES    */
    /*******************/
    // line 4854

    /**
        If loading a mod, returns the currently loading mod's name.
    **/
    @:native("get_current_modname")
    public static function getCurrentModName(): Null<String>;

    /**
        Returns the directory path for a mod.

        Returns null if the mod does not esist or is disabled,
        but does not require the mod to be loaded yet.
    **/
    @:native("get_modpath")
    public static function getModPath(modName: String): Null<String>;

    /**
        Returns "a list of enabled mods, sorted alphabetically."
    **/
    @:native("get_modnames")
    public static function getModNames(): Dynamic;

    /**
        Returns a path of the currently loaded world.
    **/
    @:native("get_worldpath")
    public static function getWorldPath(): Null<String>;

    @:native("is_singleplayer")
    public static function isSingleplayer(): Bool;

    @:native("has_feature")
    public static function hasFeature(
        feature: EitherType<String, Table<String, Bool>>
    ): HasFeatureResult;

    /**
        Returns information about the player's connection.
    **/
    @:native("get_player_information")
    public static function getPlayerInformation(name: String): Table<String, Any>;

    /**
        Recursively creates a directory specified by `path`.
    **/
    @:native("mkdir")
    public static function directoryCreate(path: String): Bool;

    /**
        Removes a directory specified by `path`.
    **/
    @:native("rmdir")
    public static function directoryRemove(path: String, recursive: Bool): Bool;

    /**
        Copies a directory specified by `source` to `destination`.

        Any existing files will be overwritten.
    **/
    @:native("cpdir")
    public static function directoryCopy(source: String, destination: String): Bool;

    /**
        Moves a directory specified by `source` to `destination`.

        The move will fail if the `destination` is not empty.
    **/
    @:native("mvdir")
    public static function directoryMove(source: String, destination: String): Bool;

    /**
        Returns a "list of entry names".
    **/
    @:native("get_dir_list")
    public static function directoryList(path: String, option: ListEntries = All): Dynamic;

    /**
        Atomically replaces contents of a file.
    **/
    @:native("safe_file_write")
    public static function safeFileWrite(path: String, content: Any): Bool;

    /**
        Returns "a table containing components of the engine version".
    **/
    @:native("get_version")
    public static function getVersion(): VersionInfo;

    /**
        Returns "the SHA1 hash of the data".
    **/
    @:native("sha1")
    public static function sha1(data: String, rawBytes: Bool = false): Dynamic;

    @:native("colorspec_to_colorstring")
    public static function colorspecToColorstring(colorspec: Dynamic): Null<Dynamic>;

    @:native("colorspec_to_bytes")
    public static function colorspecToBytes(colorspec: Dynamic): Null<Dynamic>;

    @:native("encode_png")
    public static function encodePng(
        width: Int,
        height: Int,
        data: EitherType<Table<Dynamic, Dynamic>, String>,
        ?compression: Int
    ): Null<Dynamic>;

    /*******************/
    /*     LOGGING     */
    /*******************/
    // line 5030

    /**
        Prints debug info.
    **/
    @:native("debug")
    public static function debug(...args: Dynamic): Void;

    @:native("log")
    public static function log(level: LogLevel, message: String): Void;

    /************************/
    /*     REGISTRATION     */
    /************************/
    // line 5039

    /**
        Registers a node.
    **/
    @:native("register_node")
    public static function registerNode(name: String, definition: NodeDefinition): Void;

    /*************************/
    /*     UNCATEGORIZED     */
    /*************************/
    @:native("register_on_joinplayer")
    static function registerOnPlayerJoin(callback: PlayerJoinCallback): Void;
    @:native("register_on_chat_message")
    static function registerOnChatMessage(callback: ChatMessageCallback): Void;
    @:native("unregister_chatcommand")
    static function unregisterChatCommand(name: String): Void;
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

    /**
        Gets the mod storage associated with this mod.

        NOTE: This method is safe to call only during load time (in main).
    **/
    @:native("get_mod_storage")
    static function getModStorage(): StorageRef;
    @:native("request_insecure_environment")
    static function requestInsecureEnvironment(): Null<InsecureEnvironment>;

    @:native("get_auth_handler")
    static function getAuthHandler(): AuthHandler;
    @:native("register_authentication_handler")
    static function registerAuthHandler(handler: AuthHandler): Void;

    @:native("register_on_prejoinplayer")
    public static function registerOnPreJoinPlayer(
        handler: (name: String, ip: String) -> Null<String>
    ): Void;

    @:native("notify_authentication_modified")
    public static function notifyAuthModified(?name: String): Void;

    /**
        Runs a piece of code in the async environment.

        If this function looks ugly to you, you can use the `Minetest.runAsync` wrapper.
        @param func The function to be run in the async environment.
        @param callback A function to be run in "server" thread, accepting the result of `func`.
        @param args Arguments passed to `func`.
        NOTE: they will be re-serialized at the async barrier.
        @since Minetest 5.6.0
    **/
    @:native("handle_async")
    public static function handleAsync(func: Any, callback: Any, ...args: Dynamic): Bool;

    /**
        Runs `handleAsync`, but wraps the result in a `Future`.
        @param state The object to be re-serialized and passed to the provided function.
        @param func The function to be run in the async environment.
        @since Minetest 5.6.0
    **/
    public static inline function runAsync<S, R>(state: S, func: (S) -> R): Future<R> {
        final future: Future<R> = new Future();
        Minetest.handleAsync(func, data -> future.complete(data), state);
        return future;
    }

    /**
        Checks whether an object represents a player.
    **/
    @:native("is_player")
    public static function isPlayer(obj: Any): Bool;

    /**
        Tests whether a player has certain privileges (ie. can perform some operation).
        @param player Either a player object or a player username.
        @param privs List (or a table) of the privileges to check.
    **/
    @:native("check_player_privs")
    public static function checkPlayerPrivs(
        player: EitherType<String, PlayerRef>,
        privs: EitherType<Rest<String>, Table<String, Bool>>
    ): CheckPlayerPrivsResult;

    /**
        Prepares a string for client-side translation.
    **/
    @:native("translate")
    static function translate(domain: String, text: String, ...args: Any): String;
    @:native("sound_play")
    static function soundPlay(
        spec: Any,
        parameters: NativeSoundParams,
        ephemeral: Bool = false
    ): EitherType<Void, SoundHandle>;

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

    @:native("register_craft")
    public static function registerCraft(recipe: Recipe): Void;

    /**
        Registers a function to be called on every server step.

        (By default 0.09s, but it is variable and configurable by the administrator.)
    **/
    @:native("register_globalstep")
    public static function registerOnGlobalstep(callback: (delta: Float) -> Void): Void;

    /**
        Registers a function to be run on normal server shutdown.
        Will likely not be called if a server crashes.
    **/
    @:native("register_on_shutdown")
    public static function registerOnShutdown(callback: () -> Void): Void;

    @:native("after")
    static function after(delay: Float, callback: () -> Void): Void;
}
