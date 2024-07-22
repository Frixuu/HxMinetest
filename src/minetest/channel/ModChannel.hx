package minetest.channel;

@:remove
interface ModChannel {
    @:native("leave")
    public function leave(): Void;

    @:native("is_writeable")
    public function isWriteable(): Bool;

    @:native("send_all")
    public function sendAll(message: String): Void;
}
