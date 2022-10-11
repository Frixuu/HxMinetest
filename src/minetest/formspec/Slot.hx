package minetest.formspec;

abstract Slot(Float) {
    public function new(amount: Float) {
        this = amount;
    }

    @:to
    public inline function toPixels(): Pixel {
        return new Pixel(this * 64.0);
    }
}
