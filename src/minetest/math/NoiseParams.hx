package minetest.math;

extern class NoiseParams {
    @:native("offset")
    var offset: Float;
    @:native("scale")
    var scale: Float;
    @:native("persist")
    var persist: Float;
    @:native("lacunarity")
    var lacunarity: Float;
    @:native("seed")
    var seed: Int;
    @:native("octaves")
    var octaves: UInt;
    @:native("flags")
    var flags: UInt;
    @:native("spread")
    var spread: Vector;
}
