package minetest;

class Log {
	public static inline function info(message:String) {
		Externs.log(Level.Info, message);
	}

	public static inline function warn(message:String) {
		Externs.log(Level.Warning, message);
	}

	public static inline function error(message:String) {
		Externs.log(Level.Error, message);
	}

	public static inline function action(message:String) {
		Externs.log(Level.Action, message);
	}

	public static inline function verbose(message:String) {
		Externs.log(Level.Verbose, message);
	}
}

@:native("minetest")
private extern class Externs {
	@:native("log")
	static function log(level:Level, message:String):Void;
}

@:enum
abstract Level(String) {
	var None = "none";
	var Error = "error";
	var Warning = "warning";
	var Action = "action";
	var Info = "info";
	var Verbose = "verbose";
}
