package minetest;

import partials.Partial;

@:noCompletion
extern class Minetest_Chat implements Partial {
    #if csm
    @:native("send_chat_message")
    public static function sendChatMessage(message: String): Void;

    @:native("run_server_chatcommand")
    public static function runServerChatCommand(command: String, param: String): Void;

    @:native("clear_out_chat_queue")
    public static function clearOutChatQueue(): Void;

    @:native("display_chat_message")
    public static function displayChatMessage(message: String): Bool;
    #else

    /**
        Sends a chat message to all online players.
    **/
    @:native("chat_send_all")
    public static function chatSendAll(message: String): Void;

    /**
        Sends a chat message to a player with a specified name.
    **/
    @:native("chat_send_player")
    public static function chatSendPlayer(name: String, message: String): Void;

    @:native("format_chat_message")
    public static dynamic function formatChatMessage(name: String, message: String): String;
    #end
}
