package minetest.colors;

import lua.Table;

/**
    Specifies a 32-bit color.
**/
abstract ColorSpec(Any) to Any {
    private inline function new(repr: Any) {
        this = repr;
    }

    @:from
    public static inline function fromTable(t: Table<String, Int>): ColorSpec {
        return new ColorSpec(t);
    }

    @:from
    public static inline function fromArgb8(v: Int): ColorSpec {
        return new ColorSpec(v);
    }

    @:from
    public static inline function fromColorString(s: ColorString): ColorSpec {
        return new ColorSpec(s);
    }

    @:from
    public static inline function fromColor(c: Color): ColorSpec {
        return ColorSpec.fromArgb8(c.toIntArgb());
    }
}
