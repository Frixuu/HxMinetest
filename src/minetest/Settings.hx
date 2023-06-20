// SPDX-License-Identifier: Zlib
package minetest;

import minetest.util.NativeArray;
import lua.Table;
import minetest.math.NoiseParams;
import minetest.util.NativeSet;

using minetest.util.NativeArrayTools;

/**
    An interface to load and save .conf config files.

    Implementation details:
    - Keys cannot contain whitespace or any of `="{}#`.
    - Values cannot contain the sequence `\n"""`.
    - If this object is a main settings object (`Minetest.settings`),
    keys starting with "secure." cannot be set.
**/
@:native("Settings")
extern class Settings {

    /**
        Creates a new `Settings` object, backed by a provided file.
    **/
    @:selfCall
    public function new(path: String);

    /**
        Returns a setting value.
    **/
    @:native("get")
    public function get(key: String): Null<String>;

    /**
        Returns a boolean setting value.
    **/
    @:native("get_bool")
    public overload function getBool(key: String): Null<Bool>;

    /**
        Returns a boolean setting value.
        @param defaultValue The default value, returned if `key` is not found.
    **/
    @:native("get_bool")
    public overload function getBool(key: String, defaultValue: Bool): Bool;

    /**
        Sets a string setting value.
    **/
    @:native("set")
    public function set(key: String, value: String): Void;

    /**
        Sets a boolean setting value.
    **/
    @:native("set_bool")
    public function setBool(key: String, value: Bool): Void;

    /**
        Removes a settings.
        @return True on success.
    **/
    @:native("remove")
    public function remove(key: String): Bool;

    @:native("get_names")
    private function getNamesRaw(): NativeArray<String>;

    /**
        Returns an array of all the setting keys.
    **/
    public inline function getNames(): Array<String> {
        return @:privateAccess getNamesRaw().convertIntoHaxeArray();
    }

    /**
        Checks whether a setting `key` exists.

        Note: for the main settings object (`Minetest.settings`),
        `get` might return a non-null, default value
        even when `has` returns false.
        @since Minetest 5.8.0
    **/
    @:native("has")
    public function has(key: String): Bool;

    /**
        Writes changes to the file backing these `Settings`.
        @return True on success.
    **/
    @:native("write")
    public function write(): Bool;

    /**
        Copies settings from this object to a new `Table`.
    **/
    @:native("to_table")
    public function toTable(): Table<String, Dynamic>;

    #if !csm
    @:native("get_np_group")
    public function getNoiseParamsGroup(key: String): Null<NoiseParams>;
    @:native("set_np_group")
    public function setNoiseParamsGroup(key: String, value: NoiseParams): Void;
    @:native("get_flags")
    public function getFlags(key: String): Null<NativeSet<String>>;
    #end
}
