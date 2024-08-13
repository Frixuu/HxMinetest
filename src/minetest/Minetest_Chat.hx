package minetest;

import partials.Partial;

@:noCompletion
extern class Minetest_Chat implements Partial {

    #if hxminetest._clientside
    /**
        Acts as if the provided `message` was typed by the player.

        Note: This method might fail if server restricted this client-side API.
    **/
    @:native("send_chat_message")
    public static function sendChatMessage(message: String): Void;

    /**
        Runs a server command as the local player.

        Note: This method might fail if server restricted this client-side API.
    **/
    @:native("run_server_chatcommand")
    public static function runServerChatCommand(command: String, param: String): Void;

    /**
        Clears the chat queue.
    **/
    @:native("clear_out_chat_queue")
    public static function clearOutChatQueue(): Void;

    /**
        Shows a chat message to the current player.
    **/
    @:native("display_chat_message")
    public static function displayChatMessage(message: String): Void;
    #end

    #if hxminetest._serverside
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

    /**
        This method is used by the server to format chat messages. Can be redefined by mods.

        The default behavior is as follows:
        - Takes chat_message_format from minetest.conf as the format string.
        - Valid placeholders: @name (required), @message (required), @timestamp.
        - Only the first occurrence of a placeholder is replaced.
    **/
    @:native("format_chat_message")
    public static dynamic function formatChatMessage(name: String, message: String): String;
    #end
}
