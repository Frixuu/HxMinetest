package minetest;

import partials.Partial;

@:noCompletion
extern class Minetest_Content implements Partial {

    /**
        Content ID for the built-in "unknown" nodes.
    **/
    public static inline final CONTENT_UNKNOWN: ContentId = 125;

    /**
        Content ID for the built-in "air" nodes.
    **/
    public static inline final CONTENT_AIR: ContentId = 126;

    /**
        Content ID for the built-in "ignore" nodes.
    **/
    public static inline final CONTENT_IGNORE: ContentId = 127;

    /**
        Returns the internal content identifier of a node type with a given name.
    **/
    @:native("get_content_id")
    public static function getContentId(name: String): ContentId;

    /**
        Returns a string name of a node type with a given content ID.
    **/
    @:native("get_name_from_content_id")
    public static function getNameFromContentId(id: ContentId): String;

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
        Returns all names of the enabled mods, sorted alphabetically.
    **/
    @:native("get_modnames")
    public static function getModNames(): NativeArray<String>;

    /**
     * Returns information about the current game.
     *
     * Note: other meta information can be manually read from `game.conf` in the game's directory.
     * @since Minetest 5.7.0
     */
    @:native("get_game_info")
    public static function getGameInfo(): GameInfo;
}
