package minetest.formspec;

final class UnitTools {
    public static inline function slots(amount: Float): Slot {
        return new Slot(amount);
    }

    public static inline function px(amount: Float): Pixel {
        return new Pixel(amount);
    }
}
