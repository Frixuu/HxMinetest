package minetest.math;

@:native("SecureRandom")
extern final class SecureRandom {
    @:selfCall
    public static function tryNew(): Null<SecureRandom>;
}
