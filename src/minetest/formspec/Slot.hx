package minetest.formspec;

abstract Slot(Float) {
    public inline function new(amount: Float) {
        this = amount;
    }

    @:from
    public static inline function from(amount: Float): Slot {
        return new Slot(amount);
    }

    @:to
    public inline function toPixels(): Pixel {
        return new Pixel(this * 64.0);
    }
}
