package minetest;

import minetest.math.NoiseParams;
import lua.Table;

/**
    An interface to load and save .conf config files.
**/
extern class Settings {
    @:native("get")
    function get(key: String): Null<String>;
    @:native("get_bool")
    function getBool(key: String, ?def: Bool): Null<Bool>;
    @:native("get_np_group")
    function getNoiseParamsGroup(key: String): NoiseParams;
    @:native("get_flags")
    function getFlags(key: String): Table<String, Bool>;

    /**
        Keys cannot contain whitespace or any of `="{}#`.
        Values cannot contain the sequence `\n"""`.
        If this object is a main settings object (`Minetest.settings`),
        keys starting with "secure." cannot be set.
    **/
    @:native("set")
    function set(key: String, value: Any): Void;
    @:native("set_bool")
    function setBool(key: String, value: Bool): Void;
    @:native("set_np_group")
    function setNoiseParamsGroup(key: String, value: NoiseParams): Void;
    @:native("remove")
    function remove(key: String): Bool;
    @:native("get_names")
    function getNames(): Dynamic;
    @:native("write")
    function write(): Bool;
    @:native("to_table")
    function toTable(): AnyTable;
}
