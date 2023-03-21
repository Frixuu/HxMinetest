package minetest;

#if csm
import partials.Partial;

extern class Minetest_Csm implements Partial {

    /**
        A reference to the local player object.
    **/
    @:native("localplayer")
    public static var localPlayer(default, null): LocalPlayer;

    /**
        A reference to the camera object.
    **/
    @:native("camera")
    public static var camera(default, null): Camera;

    /**
        Disconnects from the server and exists to the main menu.
        @return False if the client is already disconnecting.
    **/
    @:native("disconnect")
    public static function disconnect(): Bool;

    /**
        Requests a respawn from the server.
    **/
    @:native("send_respawn")
    public static function sendRespawnRequest(): Void;

    @:native("get_server_info")
    public static function getServerInfo(): ServerInfo;
}
#end
