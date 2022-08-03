package minetest;

abstract class Scheduler {
    /**
        Runs a specified piece of code later.
        @param delay The delay after which the calback should be run, in seconds.
        @param callback The function to be run.
    **/
    public static inline function runAfter(delay: Float, callback: () -> Void): Void {
        Externs.after(delay, callback);
    }
}

@:native("minetest")
private extern class Externs {
    @:native("after")
    public static function after(delay: Float, callback: () -> Void): Void;
}
