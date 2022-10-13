package minetest;

import haxe.Rest;
import haxe.extern.EitherType;
import lua.Table;
import minetest.LogLevel;
import minetest.Settings;
import minetest.async.Future;
import minetest.audio.SoundHandle;
import minetest.audio.SoundParams;
import minetest.auth.AuthHandler;
import minetest.colors.ColorString;
import minetest.craft.Recipe;
import minetest.data.ObjectRef;
import minetest.data.PlayerHealthChangeReason;
import minetest.data.PlayerRef;
import minetest.insecure.InsecureEnvironment;
import minetest.math.Vector;
import minetest.metadata.StorageRef;
import minetest.node.NodeDefinition;
import minetest.worldgen.BiomeHandle;
import minetest.worldgen.DecorationHandle;
import minetest.worldgen.SchematicHandle;
#if csm
import minetest.client.Camera;
import minetest.client.LocalPlayer;
import minetest.client.ServerInfo;
#end

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

    #if csm
    /**
        A reference to the local player object.
    **/
    @:native("localplayer")
    public static var localPlayer(default, null): LocalPlayer;

    /**
        A reference to the camera object.
    **/
    @:native("camera")
    public static var camera(default, null): Camera;
    #end

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

    /**
        Prints debug info.
    **/
    @:native("debug")
    public static function debug(...args: Dynamic): Void;

    @:native("log")
    public static function log(level: LogLevel, message: String): Void;

    /**
        Registers a node.
    **/
    @:native("register_node")
    public static function registerNode(name: String, definition: NodeDefinition): Void;

    /**
        Registers a craftitem.
    **/
    @:native("register_craftitem")
    public static function registerCraftitem(name: String, definition: Dynamic): Void;

    /**
        Registers a tool.
    **/
    @:native("register_tool")
    public static function registerTool(name: String, definition: Dynamic): Void;

    /**
        Overrides fields of an item definition.

        Note: Item must be already defined to use it.
        If the item comes from another mod, your mod should (soft-)depend on it.
    **/
    @:native("override_item")
    public static function overrideItem(name: String, redefinition: Dynamic): Void;

    /**
        Unregisters an item.
    **/
    @:native("unregister_item")
    public static function unregisterItem(name: String): Void;

    /**
        Registers an entity.
    **/
    @:native("register_entity")
    public static function registerEntity(name: String, definition: Dynamic): Void;

    @:native("register_abm")
    public static function registerAbm(name: String, definition: Dynamic): Void;

    @:native("register_lbm")
    public static function registerLbm(name: String, definition: Dynamic): Void;

    @:native("register_alias")
    public static function registerAlias(alias: String, original: String): Void;

    @:native("register_alias_force")
    public static function registerAliasForce(alias: String, original: String): Void;

    @:native("register_ore")
    public static function registerOre(definition: Dynamic): Void;

    @:native("register_biome")
    public static function registerBiome(definition: Dynamic): BiomeHandle;

    /**
        Unregisters a biome.

        Warning: This alters biome IDs.
        Any decorations or ores using the 'biomes' field
        must afterwards be cleared and re-registered.
    **/
    @:native("unregister_biome")
    public static function unregisterBiome(name: String): Void;

    @:native("register_decoration")
    public static function registerDecoration(definition: Dynamic): DecorationHandle;

    @:native("register_schematic")
    public static function registerSchematic(definition: Dynamic): SchematicHandle;

    /**
        Clears all currently registered biomes.

        Warning: This alters biome IDs.
        Any decorations or ores using the 'biomes' field
        must afterwards be cleared and re-registered.
    **/
    @:native("clear_registered_biomes")
    public static function clearRegisteredBiomes(): Void;

    @:native("clear_registered_decorations")
    public static function clearRegisteredDecorations(): Void;

    @:native("clear_registered_ores")
    public static function clearRegisteredOres(): Void;

    @:native("clear_registered_schematics")
    public static function clearRegisteredSchematics(): Void;

    @:native("register_craft")
    public static function registerCraft(recipe: Recipe): Void;

    @:native("clear_craft")
    public static function clearCraft(recipe: Dynamic): Void;

    @:native("register_chatcommand")
    public static function registerChatCommand(name: String, definition: Dynamic): Void;

    @:native("override_chatcommand")
    public static function overrideChatCommand(name: String, redefinition: Dynamic): Void;

    @:native("unregister_chatcommand")
    public static function unregisterChatCommand(name: String): Void;

    @:native("register_privilege")
    public static function registerPrivilege(name: String, definition: Dynamic): Void;

    /**
        Registers an auth handler that overrides the built-in one.

        This function can be called "by a single mod once only".
    **/
    @:native("register_authentication_handler")
    public static function registerAuthHandler(handler: AuthHandler): Void;

    /**
        Registers a function to be called on every server step.

        (By default 0.09s, but it is variable and configurable by the administrator.)
    **/
    @:native("register_globalstep")
    public static function registerOnGlobalstep(callback: (delta: Float) -> Void): Void;

    @:native("register_on_mods_loaded")
    public static function registerOnModsLoaded(callback: () -> Void): Void;

    /**
        Registers a function to be run on normal server shutdown.
        Will likely not be called if a server crashes.
    **/
    @:native("register_on_shutdown")
    public static function registerOnShutdown(callback: () -> Void): Void;

    /**
        Not recommended; use `on_construct` or `after_place_node` in node
        definition whenever possible.
    **/
    @:deprecated
    @:native("register_on_placenode")
    public static function registerOnPlaceNode(
        callback: (
            pos: Any,
            newnode: Any,
            placer: Any,
            oldnode: Any,
            itemstack: Any,
            pointedThing: Any
        ) -> Void
    ): Void;

    /**
        Not recommended; use `on_destruct` or `after_dig_node` in node
        definition whenever possible.
    **/
    @:deprecated
    @:native("register_on_dignode")
    public static function registerOnDigNode(
        callback: (
            pos: Any,
            oldnode: Any,
            digger: Any
        ) -> Void
    ): Void;

    @:native("register_on_punchnode")
    public static function registerOnNodePunched(
        callback: (
            pos: Any,
            node: Any,
            puncher: Any,
            pointedThing: Any
        ) -> Void
    ): Void;

    @:native("register_on_generated")
    public static function registerOnGenerated(
        callback: (
            minp: Any,
            maxp: Any,
            blockSeed: Any
        ) -> Void
    ): Void;

    @:native("register_on_newplayer")
    public static function registerOnNewPlayer(
        callback: (player: PlayerRef) -> Void
    ): Void;

    @:native("register_on_punchplayer")
    public static function registerOnPlayerPunched(
        callback: (
            player: PlayerRef,
            hitter: PlayerRef,
            timeFromLastPunch: Null<Any>,
            toolCapabilities: Null<AnyTable>,
            dir: Any,
            damage: Any
        ) -> Bool
    ): Void;

    @:native("register_on_rightclickplayer")
    public static function registerOnPlayerRightClicked(
        callback: (
            player: PlayerRef,
            clicker: ObjectRef
        ) -> Void
    ): Void;

    @:native("register_on_player_hpchange")
    public static function registerOnPlayerHealthChange(
        callback: (
            player: PlayerRef,
            hpChange: Float,
            reason: PlayerHealthChangeReason
        ) -> Void,
        modifier: Bool
    ): Void;

    @:native("register_on_dieplayer")
    public static function registerOnPlayerDeath(
        callback: (
            player: PlayerRef,
            reason: PlayerHealthChangeReason
        ) -> Void
    ): Void;

    @:native("register_on_respawnplayer")
    public static function registerOnPlayerRespawning(
        callback: (player: PlayerRef) -> Bool
    ): Void;

    @:native("register_on_prejoinplayer")
    @:overload(function(handler: (name: String, ip: String) -> Void): Void {})
    public static function registerOnPlayerPreJoin(
        handler: (name: String, ip: String) -> Null<String>
    ): Void;

    @:native("register_on_joinplayer")
    public static function registerOnPlayerJoin(
        callback: (player: PlayerRef, lastLogin: Null<Int>) -> Void
    ): Void;

    @:native("register_on_leaveplayer")
    public static function registerOnPlayerLeave(
        callback: (player: PlayerRef, timedOut: Bool) -> Void
    ): Void;

    @:native("register_on_authplayer")
    public static function registerOnPlayerAuth(
        callback: (name: String, ip: Any, isSuccess: Bool) -> Void
    ): Void;

    @:native("register_on_cheat")
    public static function registerOnCheatDetected(
        callback: (player: PlayerRef, cheat: AnyTable) -> Void
    ): Void;

    @:native("register_on_chat_message")
    public static function registerOnChatMessage(
        callback: (name: String, message: String) -> Bool
    ): Void;

    @:native("register_on_chatcommand")
    public static function registerOnChatCommand(
        callback: (name: String, command: Any, params: Any) -> Bool
    ): Void;

    @:native("register_on_player_receive_fields")
    public static function registerOnPlayerReceiveFields(
        callback: (player: Any, formName: Any, fields: Any) -> Bool
    ): Void;

    @:native("register_on_craft")
    public static function registerOnCraft(
        callback: (
            itemStack: Any,
            player: Any,
            oldCraftGrid: Any,
            craftInv: Any
        ) -> Null<Any>
    ): Void;

    @:native("register_craft_predict")
    public static function registerOnCraftPredict(
        callback: (
            itemStack: Any,
            player: Any,
            oldCraftGrid: Any,
            craftInv: Any
        ) -> Null<Any>
    ): Void;

    @:native("register_allow_player_inventory_action")
    public static function registerAllowPlayerInventoryAction(
        callback: (
            player: Any,
            action: Any,
            inventory: Any,
            inventoryInfo: Any
        ) -> Null<Int>
    ): Void;

    @:native("register_onw_player_inventory_action")
    public static function registerOnPlayerInventoryAction(
        callback: (
            player: Any,
            action: Any,
            inventory: Any,
            inventoryInfo: Any
        ) -> Void
    ): Void;

    @:native("register_on_protection_violation")
    public static function registerOnProtectionViolation(
        callback: (
            pos: Any,
            name: Any
        ) -> Void
    ): Void;

    @:native("register_on_item_eat")
    public static function registerOnItemEat(
        callback: (
            hpChange: Any,
            replaceWithItem: Any,
            itemStack: Any,
            user: Any,
            pointedThing: Any
        ) -> Null<Any>
    ): Void;

    @:native("register_on_item_pickup")
    public static function registerOnItemPickup(
        callback: (
            itemstack: Any,
            picker: Any,
            pointedThing: Any,
            timeFromLastPunch: Any,
            ...args: Any
        ) -> Null<Any>
    ): Void;

    @:native("register_on_priv_grant")
    public static function registerOnPrivGrant(
        callback: (
            name: Any,
            granter: Any,
            priv: Any
        ) -> Void
    ): Void;

    @:native("register_on_priv_revoke")
    public static function registerOnPrivRevoke(
        callback: (
            name: Any,
            revoker: Any,
            priv: Any
        ) -> Void
    ): Void;

    @:native("register_can_bypass_userlimit")
    public static function registerCanBypassUserLimit(
        callback: (
            name: Any,
            ip: Any
        ) -> Void
    ): Void;

    @:native("register_on_modchannel_message")
    public static function registerOnModChannelMessage(
        callback: (
            channelName: Any,
            sender: Null<Any>,
            message: Any
        ) -> Void
    ): Void;

    @:native("register_on_liquid_transformed")
    public static function registerOnLiquidTransformed(
        callback: (
            posList: Any,
            nodeList: Any
        ) -> Void
    ): Void;

    @:native("setting_get_pos")
    public static function settingGetPos(key: String): Null<Any>;

    @:native("string_to_privs")
    public static function stringToPrivs(
        str: String, ?delimiter: String = ","
    ): Table<String, Bool>;

    @:native("privs_to_string")
    public static function privsToString(
        privs: Table<String, Bool>, ?delimiter: String = ","
    ): String;

    @:native("get_player_privs")
    public static function getPlayerPrivs(name: String): Table<String, Bool>;

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

    @:native("check_password_entry")
    public static function checkPasswordEntry(name: String, entry: Any, password: Any): Bool;

    @:native("get_password_hash")
    public static function getPasswordHash(name: String, rawPassword: Any): Any;

    @:native("get_player_ip")
    public static function getPlayerIp(name: String): Null<String>;

    @:native("get_auth_handler")
    public static function getAuthHandler(): AuthHandler;

    @:native("notify_authentication_modified")
    public static function notifyAuthModified(?name: String): Void;

    @:native("set_player_password")
    public static function setPlayerPassword(name: String, hash: Any): Void;

    @:native("set_player_privs")
    public static function setPlayerPrivs(name: String, privs: Table<String, Bool>): Void;

    @:native("auth_reload")
    public static function authReload(): Void;

    /**
        Sends a chat message to all online players.
    **/
    @:native("chat_send_all")
    public static function chatSendAll(message: String): Void;

    /**
        Sends a chat message to a player with a specified name.
    **/
    @:native("chat_send_player")
    public static function chatSendPlayer(name: String, message: String): Void;

    @:native("format_chat_message")
    public static function formatChatMessage(name: String, message: String): String;

    @:native("set_node")
    public static function setNode(pos: Vector, node: AnyTable): Void;

    @:native("bulk_set_node")
    public static function bulkSetNode(pos: Table<Int, Vector>, node: AnyTable): Void;

    @:native("swap_node")
    public static function swapNode(pos: Vector, node: AnyTable): Void;

    @:native("remove_node")
    public static function removeNode(pos: Vector): Void;

    /**
        Returns the node at the given position.

        Can return null if the area is unloaded.
    **/
    @:native("get_node_or_nil")
    public static function getNode(pos: Vector): Null<Dynamic>;

    @:native("get_node_light")
    public static function getNodeLight(pos: Vector, ?timeOfDay: Float): Null<Int>;

    @:native("get_natural_light")
    public static function getNaturalLight(pos: Vector, ?timeOfDay: Float): Null<Int>;

    @:native("get_artificial_light")
    public static function getArtificialLight(param: Dynamic): Int;

    /*************************/
    /*     UNCATEGORIZED     */
    /*************************/
    @:native("get_player_by_name")
    public static function getPlayerByName(name: String): Null<PlayerRef>;

    /**
        Gets the mod storage associated with this mod.

        NOTE: This method is safe to call only during load time (in main).
    **/
    @:native("get_mod_storage")
    static function getModStorage(): StorageRef;
    @:native("request_insecure_environment")
    static function requestInsecureEnvironment(): Null<InsecureEnvironment>;

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
        Prepares a string for client-side translation.
    **/
    @:native("translate")
    public static function translate(domain: String, text: String, ...args: Any): String;

    @:native("get_translator")
    public static function getTranslator(domain: String): (text: String, ...args: Any) -> String;
    @:native("sound_play")
    public static function soundPlay(
        spec: Any,
        parameters: NativeSoundParams,
        ephemeral: Bool = false
    ): EitherType<Void, SoundHandle>;

    @:native("sound_stop")
    public static function soundStop(handle: SoundHandle): Void;

    @:native("sound_fade")
    public static function soundFade(handle: SoundHandle, step: Float, targetGain: Float): Void;
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

    @:native("after")
    static function after(delay: Float, callback: () -> Void): Void;

    #if csm
    /**
        Disconnects from the server and exists to the main menu.
    **/
    @:native("disconnect")
    public static function disconnect(): Bool;

    /**
        Requests a respawn from the server.
    **/
    @:native("send_respawn")
    public static function sendRespawnRequest(): Void;

    @:native("get_server_info")
    public static function getServerInfo(): ServerInfo;
    #end
}
