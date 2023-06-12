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
}
