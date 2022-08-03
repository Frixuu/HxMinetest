package minetest.data;

/**
	A reference to some ServerActiveObject.

	The reference can become invalid when an object it is refering to
	gets unloaded or removed.
**/
extern abstract class ObjectRef extends lua.UserData {
	/**
		If the object is a player, returns that player's name.
		Otherwise returns an empty string.
	**/
	@:native("get_player_name")
	function getPlayerName():String;

	@:native("get_breath")
	function getBreath():UInt;

	@:native("set_breath")
	function setBreath(value:UInt):Void;
}
