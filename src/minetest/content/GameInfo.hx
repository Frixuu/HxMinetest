package minetest.content;

@:remove
interface GameInfo {

    /**
     * The technical name/ID of a game.
     */
    @:native("id")
    public var id: String;

    /**
     * The human-readable title of the game.
     */
    @:native("title")
    public var title: String;

    /**
     * The author of the game.
     */
    @:native("author")
    public var author: String;

    /**
     * The path to the game.
     */
    @:native("path")
    public var path: String;
}
