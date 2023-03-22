package minetest;

import partials.Partial;

@:noCompletion
extern class Minetest_EscapeSequences implements Partial {

    /**
        Sets the following text color to the provided color.
    **/
    @:pure
    @:native("get_color_escape_sequence")
    public static function getColorEscapeSequence(color: ColorString): String;

    /**
        Sets the background of the whole text element to the provided color.
        Only defined for item descriptions and tooltips.
    **/
    @:pure
    @:native("get_background_escape_sequence")
    public static function getBackgroundEscapeSequence(color: ColorString): String;

    /**
        Colorizes a message, suffixing it with a white color escape sequence.
    **/
    @:pure
    @:native("colorize")
    public static function colorize(color: ColorString, message: String): String;

    /**
        Removes foreground color escape sequences from a provided string.
    **/
    @:pure
    @:native("strip_foreground_colors")
    public static function stripForegroundColors(message: String): String;

    /**
        Removes background color escape sequences from a provided string.
    **/
    @:pure
    @:native("strip_background_colors")
    public static function stripBackgroundColors(message: String): String;

    /**
        Removes all color escape sequences from a message.
    **/
    @:pure
    @:native("strip_colors")
    public static function stripColors(message: String): String;
}
