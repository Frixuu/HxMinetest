package minetest.colors;

/**
    `Color` represents a 24-bit RGB or a 32-bit RGBA color value.
**/
class Color {

    /** Represents the RGB part of the value, in the 0xRRGGBB form. **/
    private var _reprRgb: Int;

    /** Represents the alpha byte of the color value. **/
    private var _alpha: Int;

    private inline function new(rgb: Int, alpha: Int) {
        this._reprRgb = rgb;
        this._alpha = alpha;
    }

    /**
        Constructs a new RGB `Color`.
        @param red Red channel, values 0-255.
        @param green Green channel, values 0-255.
        @param blue Blue channel, values 0-255.
    **/
    public static inline function rgb(red: Int, green: Int, blue: Int): Color {
        return Color.rgba(red, green, blue, 255);
    }

    /**
        Constructs a new RGBA `Color`.
        @param red Red channel, values 0-255.
        @param green Green channel, values 0-255.
        @param blue Blue channel, values 0-255.
        @param blue Alpha channel, values 0-255.
    **/
    public static inline function rgba(red: Int, green: Int, blue: Int, alpha: Int): Color {
        return new Color((blue & 255) + ((green & 255) << 8) + ((red & 255) << 16), alpha);
    }

    /** Gets the red channel value of the color. **/
    public inline function red(): Int {
        return (this._reprRgb >> 16) & 255;
    }

    /** Gets the green channel value of the color. **/
    public inline function green(): Int {
        return (this._reprRgb >> 8) & 255;
    }

    /** Gets the blue channel value of the color. **/
    public inline function blue(): Int {
        return this._reprRgb & 255;
    }

    /** Gets the alpha channel value of the color. **/
    public inline function alpha(): Int {
        return this._alpha & 255;
    }

    /**
        Converts this `Color` object to a 32-bit integer
        representing the RGB value of this color.
    **/
    public inline function toIntRgb(): Int {
        return this._reprRgb;
    }

    /**
        Converts this `Color` object to a 32-bit integer
        representing the ARGB value of this color.
    **/
    public inline function toIntArgb(): Int {
        return this._reprRgb + ((this._alpha & 255) << 24);
    }

    /**
        Returns this `Color`'s hex representation as a `String`.
    **/
    public function toString(): String {
        final sb = new StringBuf();
        sb.add("#");
        sb.add(StringTools.hex(_reprRgb & 16777215, 6));
        if (_alpha != 255) {
            sb.add(StringTools.hex(_alpha & 255, 2));
        }
        return sb.toString();
    }
}
