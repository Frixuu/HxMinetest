package minetest;

@:structInit
class DynamicMediaOptions {
    @:native("filepath")
    public var filePath: String;
    @:native("to_player")
    public var toPlayer: String;
    @:native("ephemeral")
    public var ephemeral: Bool;
}
