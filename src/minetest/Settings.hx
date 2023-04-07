// SPDX-License-Identifier: Zlib
package minetest;

import minetest.math.NoiseParams;
import lua.Table;
import minetest.util.NativeSet;

/**
    An interface to load and save .conf config files.
**/
@:native("Settings")
extern class Settings {

    /**
        Reads the contents of a file.
    **/
    @:selfCall
    public function new(path: String);

    @:native("get")
    public function get(key: String): Null<String>;
    @:native("get_bool")
    public function getBool(key: String, ?def: Bool): Null<Bool>;
    #if !csm
    @:native("get_np_group")
    public function getNoiseParamsGroup(key: String): NoiseParams;
    @:native("get_flags")
    public function getFlags(key: String): NativeSet<String>;
    #end

    /**
        Keys cannot contain whitespace or any of `="{}#`.
        Values cannot contain the sequence `\n"""`.
        If this object is a main settings object (`Minetest.settings`),
        keys starting with "secure." cannot be set.
    **/
    @:native("set")
    public function set(key: String, value: Any): Void;
    #if !csm
    @:native("set_bool")
    public function setBool(key: String, value: Bool): Void;
    @:native("set_np_group")
    public function setNoiseParamsGroup(key: String, value: NoiseParams): Void;
    #end
    @:native("remove")
    public function remove(key: String): Bool;
    @:native("get_names")
    public function getNames(): Dynamic;
    @:native("write")
    public function write(): Bool;
    @:native("to_table")
    public function toTable(): Table<String, Dynamic>;
}
