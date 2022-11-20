package minetest.chat;

import lua.Table;

@:structInit
class ChatCommandDefinition {
    @:native("params")
    @:optional public var paramDescription: Null<String>;
    @:native("description")
    @:optional public var description: Null<String>;
    @:native("privs")
    @:optional public var privs: Table<String, Bool>;
    @:native("func")
    public var func: Dynamic;
}
