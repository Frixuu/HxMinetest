package minetest.text;

import minetest.colors.ColorString;

class Escape {
    public static inline function getColorSequence(color: ColorString): String {
        return Externs.getColorEscapeSequence(color);
    }

    public static inline function getBackgroundColorSequence(color: ColorString): String {
        return Externs.getBackgroundEscapeSequence(color);
    }

    public static inline function colorize(color: ColorString, message: String): String {
        return Externs.colorize(color, message);
    }

    public static inline function stripBackgroundColors(message: String): String {
        return Externs.stripBackgroundColors(message);
    }

    public static inline function stripForegroundColors(message: String): String {
        return Externs.stripForegroundColors(message);
    }

    public static inline function stripColors(message: String): String {
        return Externs.stripColors(message);
    }
}

@:native("minetest")
private extern class Externs {
    @:native("get_color_escape_sequence")
    static function getColorEscapeSequence(color: String): String;
    @:native("get_background_escape_sequence")
    static function getBackgroundEscapeSequence(color: String): String;
    @:native("colorize")
    static function colorize(color: String, message: String): String;
    @:native("strip_foreground_colors")
    static function stripForegroundColors(message: String): String;
    @:native("strip_background_colors")
    static function stripBackgroundColors(message: String): String;
    @:native("strip_colors")
    static function stripColors(message: String): String;
}
