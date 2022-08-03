package minetest.metadata;

extern abstract class MetaDataRef extends lua.UserData {
    /**
        Returns true if key is present, otherwise false.
        Returns null when the metadata is inexistent.
    **/
    @:native("contains")
    function contains(key: String): Null<Bool>;

    /**
        Returns stored string or null, if key is not present.
    **/
    @:native("get")
    function get(key: String): Null<String>;

    /**
        Returns a string value associated with the provided key.
        If the key is not present, returns an empty string.
    **/
    @:native("get_string")
    function getString(key: String): String;

    /**
        Sets a string value.
        If the value is an empty string, deletes the key.
    **/
    @:native("set_string")
    function setString(key: String, value: String): Void;

    /**
        Returns an integer value associated with the provided key.
        If the key is not present, returns 0.
    **/
    @:native("get_int")
    function getInt(key: String): Int;

    /**
        Sets an integer value.
        If the value is 0, deletes the key.
    **/
    @:native("set_int")
    function setInt(key: String, value: Int): Void;

    /**
        Returns a float value associated with the provided key.
        If the key is not present, returns 0.0.
    **/
    @:native("get_float")
    function getFloat(key: String): Float;

    /**
        Sets a float value.
        If the value is 0.0, deletes the key.
    **/
    @:native("set_float")
    function setFloat(key: String, value: Float): Void;

    /**
        Returns an object representation of the storage.
    **/
    @:native("to_table")
    function toTable(): Null<Any>;

    /**
        Loads metadata in-place from an object.
        Returns true on success.
    **/
    @:native("from_table")
    function loadFromTable(table: Null<Any>): Bool;

    /**
        Checks if both metadata objects have the same key-value pairs.
    **/
    @:native("equals")
    function equals(other: MetaDataRef): Bool;
}
