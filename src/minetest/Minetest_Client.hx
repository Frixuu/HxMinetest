package minetest;

#if hxminetest._clientside
import partials.Partial;

@:noCompletion
extern class Minetest_Client implements Partial {

    /**
        A reference to the local player object.
    **/
    @:native("localplayer")
    public static var localPlayer(default, null): Null<LocalPlayer>;

    /**
        A reference to the camera object.
    **/
    @:native("camera")
    public static var camera(default, null): Null<Camera>;

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

    @:native("get_csm_restrictions")
    public static function getCsmRestrictions(): Flags.TableForm<CsmRestrictions>;
}
#end
