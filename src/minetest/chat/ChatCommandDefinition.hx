package minetest.chat;

import minetest.util.NativeSet;

@:structInit
class ChatCommandDefinition {
    @:native("params")
    public var paramDescription: Null<String>;
    @:native("description")
    public var description: Null<String>;
    @:native("privs")
    public var requiredPrivs: Null<NativeSet<String>>;
    @:native("func")
    public var handler: (String, String) -> Bool;

    private inline function new(
        handler: (playerName: String, args: String) -> Bool,
        ?privs: NativeSet<String>,
        ?description: String,
        ?paramDescription: String,
    ) {
        this.handler = handler;
        this.description = description;
        this.paramDescription = paramDescription;
        this.requiredPrivs = privs;
    }
}
