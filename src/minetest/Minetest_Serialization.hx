// SPDX-License-Identifier: Zlib
package minetest;

import partials.Partial;

@:noCompletion
extern class Minetest_Serialization implements Partial {

    /**
        Converts a JSON string into the Lua equivalent.
        @param text The JSON string to be deserialized.
        @param jsonNull (Optional) The replacement for the JSON null value.
    **/
    @:native("parse_json")
    public static function parseJson(text: String, ?jsonNull: Any): Null<Any>;

    /**
        Converts a Lua table into a JSON string.
        Will error on unserializable data, like functions and userdata.
        @param data The data to serialize.
        @param pretty If true, will add indentation and line breaks to the output.
    **/
    @:native("write_json")
    public static function writeJson(data: Any, pretty: Bool = false): WriteJsonResult;

    /**
        Converts a Lua table into a string form understandable by `deserialize`.
    **/
    @:native("serialize")
    public static function serialize(table: AnyTable): String;

    /**
        Converts a `serialize`d string into a Lua table.

        WARNING: Even though this function loads `str` in an empty sandbox environment,
        it should NOT be used on untrusted data.
        @param safe If true, will not load functions.
    **/
    @:native("deserialize")
    public static function deserialize(str: String, safe: Bool = false): Null<AnyTable>;
}
