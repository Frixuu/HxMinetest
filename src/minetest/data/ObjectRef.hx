package minetest.data;

extern abstract class ObjectRef extends lua.UserData {
	/**
		If the object is a player, returns that player's name.
		Otherwise returns an empty string.
	**/
	@:native("get_player_name")
	function getPlayerName():String;
}
