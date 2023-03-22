package minetest;

import partials.Partial;

@:noCompletion
extern class Minetest_Logging implements Partial {

    /**
        Prints debug info.
    **/
    @:native("debug")
    public static function debug(...args: Dynamic): Void;

    @:native("log")
    @:overload(function(message: String): Void {})
    public static function log(level: LogLevel, message: String): Void;
}
