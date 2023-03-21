package minetest;

import minetest.hud.HudDefinition;
import minetest.worldgen.SchematicData;
import minetest.worldgen.SchematicSerializationFormat;
import minetest.worldgen.Schematic;
import haxe.Constraints.Function;
import haxe.Rest;
import haxe.extern.EitherType;
import lua.Table;
import minetest.LogLevel;
import minetest.Settings;
import minetest.async.Future;
import minetest.audio.SoundHandle;
import minetest.audio.SoundParams;
import minetest.auth.AuthHandler;
import minetest.chat.ChatCommandDefinition;
import minetest.colors.ColorString;
import minetest.craft.CraftResult;
import minetest.craft.Recipe;
import minetest.data.CompressionMethod;
import minetest.data.ObjectRef;
import minetest.data.PlayerHealthChangeReason;
import minetest.data.PlayerRef;
import minetest.insecure.InsecureEnvironment;
import minetest.insecure.http.HttpApi;
import minetest.item.InventoryRef;
import minetest.item.ItemStack;
import minetest.macro.Snippets;
import minetest.math.NoiseParams;
import minetest.math.PerlinNoise;
import minetest.math.Raycast;
import minetest.math.Vector;
import minetest.math.VoxelManip;
import minetest.metadata.NodeMetaRef;
import minetest.metadata.StorageRef;
import minetest.node.NodeDefinition;
import minetest.node.PlaceResult;
import minetest.node.RevertActionsResult;
import minetest.pathfinding.PathAlgorithm;
import minetest.player.PlayerLike;
import minetest.player.WindowInfo;
import minetest.privilege.PrivilegeDefinition;
import minetest.util.LuaArray;
import minetest.worldgen.BiomeDefinition;
import minetest.worldgen.BiomeHandle;
import minetest.worldgen.DecorationHandle;
import minetest.worldgen.EmergeType;
import minetest.worldgen.SchematicHandle;
import minetest.worldgen.SchematicRotation;

using minetest.item.InventoryLocation;

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

    @:native("registered_items")
    public static var registeredItems(default, null): Table<String, Dynamic>;

    @:native("registered_nodes")
    public static var registeredNodes(default, null): Table<String, Dynamic>;

    @:native("registered_craftitems")
    public static var registeredCraftitems(default, null): Table<String, Dynamic>;

    @:native("registered_tools")
    public static var registeredTools(default, null): Table<String, Dynamic>;

    @:native("registered_entities")
    public static var registeredEntities(default, null): Table<String, Dynamic>;

    @:native("object_refs")
    public static var objectRefs(default, null): Table<Dynamic, Dynamic>;

    @:native("luaentities")
    public static var luaEntities(default, null): Table<Dynamic, Dynamic>;

    @:native("registered_abms")
    public static var registeredAbms(default, null): Dynamic;

    @:native("registered_lbms")
    public static var registeredLbms(default, null): Dynamic;

    @:native("registered_aliases")
    public static var registeredAliases(default, null): Table<String, Dynamic>;

    @:native("registered_ores")
    public static var registeredOres(default, null): Table<String, Dynamic>;

    @:native("registered_biomes")
    public static var registeredBiomes(default, null): Table<String, Dynamic>;

    @:native("registered_decorations")
    public static var registeredDecorations(default, null): Table<String, Dynamic>;

    @:native("registered_schematics")
    public static var registeredSchematics(default, null): Table<String, Dynamic>;

    @:native("registered_chatcommands")
    public static var registeredChatCommands(default, null): Table<String, Dynamic>;

    @:native("registered_privileges")
    public static var registeredPrivileges(default, null): Table<String, PrivilegeDefinition>;

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
        @return The mod directory if the mod exists and is enabled, null otherwise.
    **/
    @:native("get_modpath")
    public static function getModPath(modName: String): Null<String>;

    /**
        Returns a list of enabled mods, sorted alphabetically.
    **/
    @:native("get_modnames")
    public static function getModNames(): LuaArray<String>;

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
        @since Minetest 5.7.0
    **/
    @:native("get_player_window_information")
    public static function getPlayerWindowInformation(name: String): WindowInfo;

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
    public static function registerBiome(definition: BiomeDefinition): BiomeHandle;

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
    public static function registerChatCommand(
        name: String,
        definition: ChatCommandDefinition
    ): Void;

    @:native("override_chatcommand")
    public static function overrideChatCommand(
        name: String,
        redefinition: ChatCommandDefinition
    ): Void;

    @:native("unregister_chatcommand")
    public static function unregisterChatCommand(name: String): Void;

    @:native("register_privilege")
    public static function registerPrivilege(name: String, definition: PrivilegeDefinition): Void;

    /**
        Registers an auth handler that overrides the built-in one.

        This function can be called "by a single mod once only".
    **/
    @:native("register_authentication_handler")
    public static function registerAuthHandler(handler: AuthHandler): Void;

    /*********

        EVENTS

    *********/
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
            minp: Vector,
            maxp: Vector,
            blockSeed: Dynamic
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

    @:native("register_on_player_inventory_action")
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

    #if csm
    /**
        Registers an event handler to be called when server modifies the player's health.
        @param callback The event handler. Return true to short circuit event handling.
    **/
    @:native("register_on_hp_modification")
    @:overload(function(callback: (newHp: Int) -> Void): Void {})
    public static function registerOnHpModification(callback: (newHp: Int) -> Bool): Void;

    @:native("register_on_death")
    public static function registerOnDeath(callback: () -> Void): Void;

    @:native("register_on_damage_taken")
    public static function registerOnDamageTaken(callback: (amount: Int) -> Void): Void;
    #else
    #end

    /*************

        OTHER

    *************/
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
        player: PlayerLike,
        privs: EitherType<Rest<String>, Table<String, Bool>>
    ): CheckPlayerPrivsResult;

    @:native("check_password_entry")
    public static function checkPasswordEntry(name: String, entry: Any, password: Any): Bool;

    @:native("get_password_hash")
    public static function getPasswordHash(name: String, rawPassword: Any): Any;

    @:native("get_player_ip")
    public static function getPlayerIp(name: String): Null<String>;

    /**
        Returns the currently active auth handler.
    **/
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

    #if csm
    @:native("display_chat_message")
    public static function displayChatMessage(message: String): Bool;
    #end

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
    public static function getArtificialLight(param1: Dynamic): Int;

    @:native("place_node")
    public static function placeNode(pos: Vector, node: Any): Void;

    /**
        Digs a node with the same effects that a player would cause.
        @return True if successful, false on failure (e.g. protected location).
    **/
    @:native("dig_node")
    public static function digNode(pos: Vector): Bool;

    @:native("punch_node")
    public static function punchNode(pos: Vector): Void;

    @:native("spawn_falling_node")
    public static function spawnFallingNode(pos: Vector): SpawnFallingNodeResult;

    @:native("find_nodes_with_meta")
    public static function findNodesWithMeta(pos1: Vector, pos2: Vector): AnyTable;

    @:native("get_meta")
    public static function getMeta(pos: Vector): NodeMetaRef;

    @:native("get_node_timer")
    public static function getNodeTimer(pos: Vector): NodeTimerRef;

    @:native("add_entity")
    public static function addEntity(pos: Vector, name: String, ?staticData: Any): Null<ObjectRef>;

    @:native("add_item")
    public static function addItem(pos: Vector, item: Any): Null<ObjectRef>;

    @:native("get_player_by_name")
    public static function getPlayerByName(name: String): Null<PlayerRef>;

    @:native("get_objects_inside_radius")
    public static function getObjectsInsideRadius(pos: Vector, radius: Any): AnyTable;

    @:native("get_objects_in_area")
    public static function getObjectsInArea(pos1: Vector, pos2: Vector): AnyTable;

    @:native("set_timeofday")
    public static function setTimeOfDay(val: Float): Void;

    @:native("get_timeofday")
    public static function getTimeOfDay(): Float;

    @:native("get_gametime")
    public static function getGameTime(): Float;

    @:native("get_day_count")
    public static function getDayCount(): Int;

    @:native("find_node_near")
    public static function findNodeNear(
        pos: Any,
        radius: Any,
        nodeNames: Any,
        ?searchCenter: Bool = false
    ): Null<Vector>;

    @:native("find_nodes_in_area")
    public static function findNodesInArea(
        pos1: Vector,
        pos2: Vector,
        nodeNames: Any,
        grouped: Bool = false
    ): Dynamic;

    @:native("find_nodes_in_area_under_air")
    public static function findNodesInAreaUnderAir(
        pos1: Vector,
        pos2: Vector,
        nodeNames: Any
    ): Dynamic;

    @:native("get_perlin")
    public static function getPerlin(noiseParams: Any): PerlinNoise;

    @:native("get_voxel_manip")
    public static function getVoxelManip(pos1: Any, pos2: Any): VoxelManip;

    @:native("set_gen_notify")
    public static function setGenNotify(flags: Any, decorationIds: Any): Void;

    @:native("get_gen_notify")
    public static function getGenNotify(): Dynamic;

    @:native("get_decoration_id")
    public static function getDecorationId(name: String): Null<Dynamic>;

    @:native("get_mapgen_object")
    public static function getMapgenObject(name: String): Null<Dynamic>;

    public static inline function getMapgenVoxelManipObject(): Dynamic {
        return untyped __lua__("{minetest.get_mapgen_object(\"VoxelManip\")}");
    }

    @:native("get_heat")
    public static function getHeat(pos: Vector): Null<Dynamic>;

    @:native("get_humidity")
    public static function getHumidity(pos: Vector): Null<Dynamic>;

    @:native("get_biome_data")
    public static function getBiomeData(pos: Vector): Null<AnyTable>;

    @:native("get_biome_id")
    public static function getBiomeId(name: String): Null<Dynamic>;

    @:native("get_biome_name")
    public static function getBiomeName(id: Any): Null<String>;

    @:native("get_mapgen_setting")
    public static function getMapgenSetting(name: String): Null<String>;

    @:native("get_mapgen_setting_noiseparams")
    public static function getMapgenSettingNoiseParams(name: String): Null<NoiseParams>;

    @:native("set_mapgen_setting")
    public static function setMapgenSetting(
        name: String,
        value: Any,
        overrideMeta: Bool = false
    ): Void;

    @:native("set_mapgen_setting_noiseparams")
    public static function setMapgenSettingNoiseParams(
        name: String,
        value: Any,
        overrideMeta: Bool = false
    ): Void;

    @:native("set_noiseparams")
    public static function setNoiseParams(
        name: String,
        noiseParams: NoiseParams,
        setDefault: Bool = false
    ): Void;

    @:native("get_noiseparams")
    public static function getNoiseParams(name: String): NoiseParams;

    @:native("generate_ores")
    public static function generateOres(
        vm: VoxelManip,
        ?pos1: Vector,
        ?pos2: Vector
    ): Void;

    @:native("generate_decorations")
    public static function generateDecorations(
        vm: VoxelManip,
        ?pos1: Vector,
        ?pos2: Vector
    ): Void;

    /**
        Clears all objects in the environment.
    **/
    @:native("clear_objects")
    public static function clearObjects(?options: {
        mode: String,
    }): Void;

    /**
        Loads mapblocks containing the area from `pos1` to `pos2`
        without triggering map generation.
    **/
    @:native("load_area")
    public static function loadArea(
        pos1: Vector,
        ?pos2: Vector
    ): Void;

    /**
        Queues all block in the area from `pos1` to `pos2`, inclusive,
        to be asynchronously fetched from memory, loaded from disk, or generated.
    **/
    @:native("emerge_area")
    public static function emergeArea<T>(
        pos1: Vector,
        pos2: Vector,
        ?callback: (blockPos: Vector, type: EmergeType, remaining: Int, param: Null<T>) -> Void,
        ?param: T
    ): Void;

    /**
        Deletes all mapblocks in the area from `pos1` to `pos2`, inclusive.
    **/
    @:native("delete_area")
    public static function deleteArea(
        pos1: Vector,
        pos2: Vector
    ): Void;

    /**
        Checks if there is something other than air between `pos1` and `pos2`.
    **/
    @:native("line_of_sight")
    public static function checkLineOfSight(
        pos1: Vector,
        pos2: Vector
    ): LosCheckResult;

    @:native("raycast")
    public static function raycast(
        pos1: Vector,
        pos2: Vector,
        includeObjects: Bool = true,
        includeLiquids: Bool = false
    ): Raycast;

    @:native("find_path")
    public static function findPath(
        pos1: Vector,
        pos2: Vector,
        maxDistance: Float,
        maxJump: Float,
        maxDrop: Float,
        algorithm: PathAlgorithm
    ): Null<AnyTable>;

    /**
        Spawns an L-system tree at given location.
    **/
    @:native("spawn_tree")
    public static function spawnTree(
        pos: Vector,
        definition: AnyTable
    ): Void;

    @:native("transforming_liquid_add")
    public static function transformingLiquidAdd(
        pos: Vector
    ): Void;

    @:native("get_node_max_level")
    public static function getNodeMaxLevel(
        pos: Vector
    ): Dynamic;

    /**
        Gets level of a leveled node (water, snow etc.)
    **/
    @:native("get_node_level")
    public static function getNodeLevel(
        pos: Vector
    ): Dynamic;

    @:native("set_node_level")
    public static function setNodeLevel(
        pos: Vector,
        level: Int
    ): Dynamic;

    @:native("add_node_level")
    public static function addNodeLevel(
        pos: Vector,
        increment: Int
    ): Dynamic;

    /**
        Resets the light in a cuboid-shaped part of the map,
        hopefully resolving lighting bugs.

        If the area is not loaded yet, loads it.

        @return True if the area is fully generated.
    **/
    @:native("fix_light")
    public static function fixLight(pos1: Vector, pos2: Vector): Bool;

    /**
        Causes an unsupported "falling node" or an unattached "attached node" to fall.

        Does not update the node's neighbors.
    **/
    @:native("check_single_for_falling")
    public static function checkSingleForFalling(
        pos: Vector
    ): Dynamic;

    /**
        Causes an unsupported "falling node" or an unattached "attached node" to fall.

        Spreads node updates to neighbors, can cause a cascade.
    **/
    @:native("check_for_falling")
    public static function checkForFalling(
        pos: Vector
    ): Dynamic;

    /**
        Given a pair of (X, Z) coordinates, returns a player spawn Y coordinate.

        Can return null if a place is deemed unsuitable to spawn by the map generator.
    **/
    @:native("get_spawn_level")
    public static function getSpawnLevel(
        x: Float,
        z: Float
    ): Null<Float>;

    /**
        The server joins channel named `name`, creating it if necessary.
    **/
    @:native("mod_channel_join")
    public static function modChannelJoin(
        name: String
    ): Void;

    @:native("get_inventory")
    private static function getInventoryRaw(location: Table<String, Any>): InventoryRef;

    public static inline function getInventory(location: InventoryLocation): InventoryRef {
        return getInventoryRaw(location.toNative());
    }

    /**
        Creates a detached inventory.

        If an inventory of that name already exists, clears it.
    **/
    @:native("create_detached_inventory")
    public static function createDetachedInventory(
        name: String,
        callbacks: Any,
        ?visibleOnlyTo: String
    ): InventoryRef;

    /**
        Removes a detached inventory.

        @return True if the removal succeeded.
    **/
    @:native("remove_detached_inventory")
    public static function removeDetachedInventory(
        name: String
    ): Bool;

    /**
        @return Leftover `ItemStack` or null, if the inventory has not changed.
    **/
    @:native("do_item_eat")
    public static function doItemEat(
        hpChange: Float,
        replaceWithItem: Any,
        itemStack: Any,
        user: Any,
        pointedThing: Any
    ): Null<ItemStack>;

    @:native("show_formspec")
    public static function showFormspec(
        playerName: String,
        formName: String,
        formSpec: String
    ): Void;

    @:native("close_formspec")
    public static function closeFormspec(
        playerName: String,
        whenFormNameIs: String
    ): Void;

    /**
        Escapes characters that cannot be used in formspecs,
        e.g. brackets, commas, semicolons.
    **/
    @:native("formspec_escape")
    public static function formspecEscape(text: String): String;

    @:native("explode_table_event")
    public static function explodeTableEvent(
        text: String
    ): AnyTable;

    @:native("explode_textlist_event")
    public static function explodeTextListEvent(
        text: String
    ): AnyTable;

    @:native("explode_scrollbar_event")
    public static function explodeScrollbarEvent(
        text: String
    ): AnyTable;

    @:native("inventorycube")
    public static function makeInventoryCubeImage(
        img1: Any,
        img2: Any,
        img3: Any
    ): String;

    @:native("get_pointed_thing_position")
    public static function getPointedThingPosition(
        pointedThing: Any,
        above: Bool
    ): Null<Vector>;

    @:native("dir_to_facedir")
    public static function dirToFacedir(
        dir: Vector,
        ?is6d: Any
    ): Dynamic;

    @:native("facedir_to_dir")
    public static function facedirToDir(
        facedir: Any
    ): Vector;

    @:native("dir_to_fourdir")
    public static function dirToFourdir(
        dir: Vector
    ): Dynamic;

    @:native("fourdir_to_dir")
    public static function fourdirToDir(
        fourdir: Any
    ): Vector;

    @:native("dir_to_wallmounted")
    public static function dirToWallmounted(
        dir: Vector
    ): Dynamic;

    @:native("wallmounted_to_dir")
    public static function wallmountedToDir(
        wallmounted: Any
    ): Vector;

    @:native("dir_to_yaw")
    public static function dirToYaw(
        dir: Vector
    ): Float;

    @:native("yaw_to_dir")
    public static function yawToDir(
        yaw: Float
    ): Vector;

    @:native("is_colored_paramtype")
    public static function isColoredParamType(
        ptype: Any
    ): Bool;

    @:native("strip_param2_color")
    public static function stripParam2Color(
        param2: Any,
        paramType2: Any
    ): Dynamic;

    @:native("get_node_drops")
    public static function getNodeDrops(
        node: Any,
        toolName: Null<String>
    ): Dynamic;

    @:native("get_craft_result")
    public static function getCraftResult(
        input: Any
    ): CraftResult;

    @:native("get_craft_recipe")
    public static function getCraftRecipe(
        output: Any
    ): AnyTable;

    @:native("get_all_craft_recipes")
    public static function getAllCraftRecipes(
        queryItem: Any
    ): Null<AnyTable>;

    @:native("handle_node_drops")
    public static dynamic function handleNodeDrops(
        pos: Vector,
        drops: Any,
        digger: Any
    ): Dynamic;

    /**
        Creates "an item string which contains
        information for hardware colorization".
        @param item The item stack which becomes colored.
        @param paletteIndex Index to be added to the stack.
    **/
    @:native("itemstring_with_palette")
    public static function itemStringWithPalette(
        item: Any,
        paletteIndex: Any
    ): String;

    @:native("itemstring_with_color")
    public static function itemStringWithColor(
        item: Any,
        colorString: Any
    ): String;

    @:native("rollback_get_node_actions")
    public static function rollbackGetNodeActions(
        pos: Any,
        range: Any,
        seconds: Any,
        limit: Any
    ): Table<Int, Dynamic>;

    @:native("rollback_revert_actions_by")
    public static function rollbackRevertActionsBy(
        actor: Any,
        seconds: Any
    ): RevertActionsResult;

    /**
        Places an item as a node.
    **/
    @:native("item_place_node")
    public static function itemPlaceNode(
        itemstack: Any,
        placer: Any,
        pointedThing: Any,
        ?param2: Any,
        ?preventAfterPlace: Bool
    ): PlaceResult;

    @:native("item_place")
    public static function itemPlace(
        itemstack: Any,
        placer: Any,
        pointedThing: Any,
        ?param2: Any
    ): PlaceResult;

    @:native("item_pickup")
    public static function itemPickup(
        itemstack: Any,
        picker: Any,
        pointedThing: Any,
        timeFromLastPunch: Any,
        ...args: Any
    ): Dynamic;

    @:native("item_drop")
    public static function itemDrop(
        itemstack: Any,
        dropper: Any,
        pos: Vector
    ): Dynamic;

    @:native("item_eat")
    public static function itemEat(
        hpChange: Any,
        ?replaceWithItem: Any
    ): ((itemStack: Dynamic, user: Dynamic, pointedThing: Dynamic) -> Void);

    @:native("node_punch")
    public static function nodePunch(
        pos: Vector,
        node: Any,
        puncher: Any,
        pointedThing: Any
    ): Dynamic;

    @:native("node_dig")
    public static function nodeDig(
        pos: Vector,
        node: Any,
        digger: Any
    ): Dynamic;

    @:native("sound_play")
    private static function soundPlayRaw(
        spec: Any,
        parameters: NativeSoundParams,
        ?ephemeral: Bool = false
    ): Null<SoundHandle>;

    public static inline function soundPlay(
        spec: Any,
        parameters: SoundParams,
        ephemeral: Bool = false
    ): Null<SoundHandle> {
        return soundPlayRaw(spec, parameters.toNative(), ephemeral);
    }

    @:native("sound_stop")
    public static function soundStop(handle: SoundHandle): Void;

    @:native("sound_fade")
    public static function soundFade(handle: SoundHandle, step: Float, targetGain: Float): Void;

    /**
        Runs a callback not earlier than after the specified amount of time has passed.
        @param delay The minimum amount of time the callback should wait, expressed in seconds.
        @param callback The function that should be called shortly after the delay ends.
        @return A handle to a cancellable job.
    **/
    @:native("after")
    @:overload(function(delay: Float, callback: Function, ...args: Any): ScheduledJobHandle {})
    public static function after(delay: Float, callback: () -> Void): ScheduledJobHandle;

    /**
        Runs a piece of code in the async environment.

        @param func The function to be run in the async environment.
        @param callback A function to be run in "server" thread, accepting the result of `func`.
        @param args Arguments passed to `func`.
        NOTE: they will be re-serialized at the async barrier.
        @since Minetest 5.6.0
    **/
    @:native("handle_async")
    private static function handleAsyncRaw(func: Function, callback: Function, ...args: Dynamic): Bool;

    /**
        Runs a piece of code in the async environment.
        @param state The object to be re-serialized and passed to the provided function.
        @param func The function to be run in the async environment.
        @since Minetest 5.6.0
    **/
    public static inline function handleAsync<S, R>(state: S, func: (S) -> R): Future<R> {
        final future: Future<R> = new Future();
        Minetest.handleAsyncRaw(func, data -> future.complete(data), state);
        return future;
    }

    /**
        Registers a path to a Lua file.

        When the async environment is initialized, this file will be imported.
    **/
    @:native("register_async_dofile")
    public static function registerAsyncDofile(path: String): Void;

    /**
        Requests a server shutdown.

        @param clientMessage Message sent to clients.
        @param suggestReconnect If true, clients will display a reconnect button.
        @param delay Optional delay, in seconds, before shutdown.
        Subsequent calls with a negative delay will cancel the currently scheduled shutdown.
    **/
    @:native("request_shutdown")
    public static function requestShutdown(
        ?clientMessage: String,
        ?suggestReconnect: Bool,
        ?delay: Float
    ): Void;

    @:native("cancel_shutdown_requests")
    public static function cancelShutdownRequests(): Void;

    @:native("get_server_status")
    public static dynamic function getServerStatus(name: String, joined: Bool): Null<String>;

    @:native("get_server_uptime")
    public static function getServerUptime(): Float;

    @:native("get_server_max_lag")
    public static function getServerMaxLag(): Null<Float>;

    @:native("remove_player")
    public static function removePlayer(name: String): RemovePlayerResult;

    @:native("remove_player_auth")
    public static function removePlayerAuth(name: String): Bool;

    @:native("dynamic_add_media")
    public static function dynamicAddMedia(options: Any, callback: (String) -> Void): Bool;

    @:native("get_ban_list")
    public static function getBanList(): Dynamic;

    @:native("get_ban_description")
    public static function getBanDescription(ipOrName: String): String;

    @:native("ban_player")
    public static function banPlayer(name: String): Bool;

    @:native("unban_player_or_ip")
    public static function unbanPlayerOrIp(ipOrName: String): Void;

    @:native("kick_player")
    public static function kickPlayer(name: String, ?reason: String): Bool;

    @:native("disconnect_player")
    public static function disconnectPlayer(name: String, ?reason: String): Bool;

    @:native("add_particle")
    public static function addParticle(definition: Any): Void;

    @:native("add_particlespawner")
    public static function addParticleSpawner(definition: Any): Int;

    @:native("delete_particlespawner")
    public static function deleteParticleSpawner(id: Int, ?playerName: String): Void;

    @:native("create_schematic")
    public static function createSchematic(
        p1: Vector,
        p2: Vector,
        probabilityList: Null<Table<Int, {
            pos: Any,
            prob: Int
        }>>,
        fileName: String,
        sliceProbList: Null<Table<Int, {
            ypos: Int,
            prob: Int
        }>>
    ): Dynamic;

    @:native("place_schematic")
    public static function placeSchematic(
        pos: Vector,
        schematic: Schematic,
        rotation: Null<SchematicRotation>,
        replacements: Any,
        forceReplacement: Bool,
        flags: Any
    ): Dynamic;

    @:native("place_schematic_on_vmanip")
    public static function placeSchematicOnVManip(
        vmanip: VoxelManip,
        pos: Vector,
        schematic: Schematic,
        rotation: Null<SchematicRotation>,
        replacements: Any,
        forceReplacement: Bool,
        flags: Any
    ): Dynamic;

    @:native("serialize_schematic")
    public static function serializeSchematic(
        schematic: Schematic,
        format: SchematicSerializationFormat,
        options: Any
    ): String;

    @:native("read_schematic")
    public static function readSchematic(
        schematicName: String,
        options: Any
    ): SchematicData;

    /**
        If the calling mod is trusted or otherwise has access to it,
        returns an object containing HTTP functions.
    **/
    public static inline function requestHttpApi(): Null<HttpApi> {
        Snippets.includeFile("insecure/http/_request_http_api.lua");
        return untyped __lua__("__hxminetest_http_api");
    }

    /**
        Gets the mod storage associated with this mod.

        NOTE: This method is safe to call only during load time (in main).
    **/
    @:native("get_mod_storage")
    public static function getModStorage(): StorageRef;

    @:native("get_connected_players")
    public static function getConnectedPlayers(): LuaArray<PlayerRef>;

    /**
        Checks whether an object represents a player.
    **/
    @:native("is_player")
    public static function isPlayer(obj: Any): Bool;

    @:native("player_exists")
    public static function playerExists(name: String): Bool;

    @:native("hud_replace_builtin")
    public static function hudReplaceBuiltin(
        name: String,
        definition: HudDefinition
    ): Void;

    @:native("parse_relative_number")
    public static function parseRelativeNumber(arg: String, relativeTo: Float): Null<Float>;

    @:native("send_join_message")
    public static dynamic function sendJoinMessage(playerName: String): Void;

    @:native("send_leave_message")
    public static dynamic function sendLeaveMessage(playerName: String, timedOut: Bool): Void;

    @:native("hash_node_position")
    public static function hashNodePosition(pos: Vector): Int;

    @:native("get_position_from_hash")
    public static function getPositionFromHash(hash: Int): Vector;

    @:native("get_item_group")
    public static function getItemGroup(name: String, group: Any): Dynamic;

    @:native("raillike_group")
    public static function raillikeGroup(name: String): Dynamic;

    @:native("get_content_id")
    public static function getContentId(name: String): Int;

    @:native("get_name_from_content_id")
    public static function getNameFromContentId(id: Int): String;

    @:native("parse_json")
    public static function parseJson(
        text: String,
        ?nullReplacement: Any
    ): Null<Any>;

    @:native("write_json")
    public static function writeJson(
        data: Any,
        fancy: Bool = false
    ): WriteJsonResult;

    @:native("serialize")
    public static function serialize(table: AnyTable): String;

    @:native("deserialize")
    public static function deserialize(str: String, ?safe: Bool): AnyTable;

    @:native("compress")
    @:overload(function(data: String, method: CompressionMethod, ...args: Any): Dynamic {})
    public static function compress(data: String, method: CompressionMethod, ?level: Int): Dynamic;

    @:native("decompress")
    @:overload(function(data: Any, method: CompressionMethod): Dynamic {})
    public static function decompress(data: Any, method: CompressionMethod, ...args: Any): Dynamic;

    @:native("rgba")
    public static function rgba(red: Int, green: Int, blue: Int, ?alpha: Int): ColorString;

    @:native("encode_base64")
    public static function encodeBase64(str: String): String;

    @:native("decode_base64")
    public static function decodeBase64(str: String): Null<String>;

    @:native("is_protected")
    public static function isProtected(pos: Vector, name: String): Bool;

    @:native("record_protection_violation")
    public static function recordProtectionViolation(pos: Vector, name: String): Void;

    @:native("is_creative_enabled")
    public static function isCreativeEnabled(name: String): Bool;

    @:native("is_area_protected")
    public static function isAreaProtected(
        pos1: Vector,
        pos2: Vector,
        name: String,
        interval: Int
    ): Bool;

    @:native("rotate_and_place")
    public static function rotateAndPlace(
        itemstack: ItemStack,
        placer: Any,
        pointedThing: Any,
        ?infinitestacks: Bool,
        ?orientFlags: Table<String, Bool>,
        ?preventAfterPlace: Any
    ): ItemStack;

    @:native("rotate_node")
    public static function rotateNode(
        itemstack: ItemStack,
        placer: Any,
        pointedThing: Any
    ): Dynamic;

    @:native("calculate_knockback")
    public static dynamic function calculateKnockback(
        player: Any,
        hitter: Any,
        timeFromLastPunch: Any,
        toolCap: Any,
        dir: Any,
        distance: Any,
        damage: Any
    ): Dynamic;

    @:native("forceload_block")
    public static dynamic function forceLoadBlock(
        pos: Vector,
        ?transient: Bool,
        ?limit: Int
    ): Dynamic;

    @:native("forceload_free_block")
    public static dynamic function forceLoadFreeBlock(
        pos: Vector,
        ?transient: Bool
    ): Dynamic;

    @:native("compare_block_status")
    public static dynamic function compareBlockStatus(
        pos: Vector,
        condition: CompareBlockStatusCondition
    ): Null<Bool>;

    /**
        If the calling mod is listed as trusted or security is disabled,
        returns an environment containing unsafe functions.

        Note: Works only at init time.

        WARNING: Do not expose this environment to anyone.
        Rogue mods may use it to escape sandbox. You have been warned.
    **/
    @:native("request_insecure_environment")
    public static function requestInsecureEnvironment(): Null<InsecureEnvironment>;

    /**
        Checks if a global Lua variable has been set.
    **/
    @:native("global_exists")
    public static function globalExists(name: String): Bool;

    /*************************/
    /*     UNCATEGORIZED     */
    /*************************/
    /**
        Prepares a string for client-side translation.
    **/
    @:native("translate")
    public static function translate(
        domain: String,
        text: String,
        ...args: Any
    ): String;

    @:native("get_translator")
    public static function getTranslator(
        domain: String
    ): (text: String, ...args: Any) -> String;

    @:native("get_color_escape_sequence")
    public static function getColorEscapeSequence(color: ColorString): String;

    @:native("get_background_escape_sequence")
    public static function getBackgroundEscapeSequence(color: ColorString): String;

    @:native("colorize")
    public static function colorize(color: ColorString, message: String): String;

    @:native("strip_foreground_colors")
    public static function stripForegroundColors(message: String): String;

    @:native("strip_background_colors")
    public static function stripBackgroundColors(message: String): String;

    @:native("strip_colors")
    public static function stripColors(message: String): String;

    #if csm
    /**
        Disconnects from the server and exists to the main menu.
        @return False if the client is already disconnecting.
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
