package minetest.data;

/**
    These extensions provide idiomatic functions for the player object
    that should be easier to use than their plain Lua counterparts.
**/
class PlayerRefExtensions {
    /**
        Sends a chat message to that player.
    **/
    static public function sendChatMessage(player: PlayerRef, text: String) {
        final playerName = player.getPlayerName();
        if (playerName != "") {
            Minetest.chatSendPlayer(playerName, text);
        }
    }
}
