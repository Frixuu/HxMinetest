package minetest;

#if !csm
import partials.Partial;

@:noCompletion
extern class Minetest_Server implements Partial {

    /**
        Requests a server shutdown.
        @param clientMessage Message sent to clients.
        @param suggestReconnect If true, clients will display a reconnect button.
        @param delay Optional delay, in seconds, before shutdown.
        Subsequent calls with a negative delay will cancel the currently scheduled shutdown.
    **/
    @:native("request_shutdown")
    public static function requestShutdown(
        ?clientMessage: String,
        ?suggestReconnect: Bool,
        ?delay: Float
    ): Void;

    @:native("cancel_shutdown_requests")
    public static function cancelShutdownRequests(): Void;

    @:native("get_server_status")
    public static dynamic function getServerStatus(name: String, joined: Bool): Null<String>;

    @:native("get_server_uptime")
    public static function getServerUptime(): Float;

    @:native("get_server_max_lag")
    public static function getServerMaxLag(): Null<Float>;

    @:native("remove_player")
    public static function removePlayer(name: String): RemovePlayerResult;

    @:native("remove_player_auth")
    public static function removePlayerAuth(name: String): Bool;

    /**
        Pushes a specific media file to clients.
        @throws String Raises an error if the server has not started yet
        or the mod does not have permission to read the media file.
        @return True on success.
    **/
    @:native("dynamic_add_media")
    public static function dynamicAddMedia(
        options: EitherType<DynamicMediaOptions, String>,
        callback: (playerName: String) -> Void
    ): Bool;
}
#end
