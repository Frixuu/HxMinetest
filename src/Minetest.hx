import minetest.Events.ChatMessageCallback;
import minetest.Events.PlayerJoinCallback;
import minetest.data.PlayerRef;
import minetest.metadata.StorageRef;

@:native("minetest")
extern class Minetest {
    @:native("register_on_joinplayer")
    static function registerOnPlayerJoin(callback: PlayerJoinCallback): Void;
    @:native("register_on_chat_message")
    static function registerOnChatMessage(callback: ChatMessageCallback): Void;
    @:native("get_player_by_name")
    static function getPlayerByName(name: String): Null<PlayerRef>;

    /**
        Sends a chat message to all online players.
    **/
    @:native("chat_send_all")
    static function chatSendAll(text: String): Void;

    /**
        Sends a chat message to a player with a specified name.
    **/
    @:native("chat_send_player")
    static function chatSendPlayer(name: String, text: String): Void;

    /**
        Gets the mod storage associated with this mod.

        NOTE: This method is safe to call only during load time (in main).
    **/
    @:native("get_mod_storage")
    static function getModStorage(): StorageRef;

    /**
        Prepares a string for client-side translation.
    **/
    @:native("translate")
    static function translate(domain: String, text: String, ...args: Any): String;
}
