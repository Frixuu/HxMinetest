package minetest.colors;

/**
    ColorString is a string
    that represents an RGB or an RGBA color.
**/
abstract ColorString(String) from String to String {
    public inline function new(s: String) {
        this = s;
    }

    @:from
    public static inline function fromColor(c: Color): ColorString {
        return new ColorString(c.toString());
    }
}
