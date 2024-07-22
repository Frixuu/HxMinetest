package minetest.formspec;

abstract Pixel(Float) {
    public inline function new(amount: Float) {
        this = amount;
    }

    @:to
    public inline function toSlots(): Slot {
        return new Slot(this / 64.0);
    }
}
