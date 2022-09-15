package minetest;

class Log {
    public static inline function info(message: String) {
        Minetest.log(Info, message);
    }

    public static inline function warn(message: String) {
        Minetest.log(Warning, message);
    }

    public static inline function error(message: String) {
        Minetest.log(Error, message);
    }

    public static inline function action(message: String) {
        Minetest.log(Action, message);
    }

    public static inline function verbose(message: String) {
        Minetest.log(Verbose, message);
    }
}
