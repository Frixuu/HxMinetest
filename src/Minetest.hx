import minetest.data.ObjectRef;

typedef PlayerJoinCallback = (player:ObjectRef, lastLogin:Null<Int>) -> Void;

@:enum
abstract LogLevel(String) {
	var None = "none";
	var Error = "error";
	var Warning = "warning";
	var Action = "action";
	var Info = "info";
	var Verbose = "verbose";
}

@:native("minetest")
extern class Minetest {
	@:native("log")
	static function log(level:LogLevel, message:String):Void;
	@:native("register_on_joinplayer")
	static function registerOnPlayerJoin(callback:PlayerJoinCallback):Void;
	@:native("chat_send_all")
	static function chatSendAll(text:String):Void;
}
