package minetest.math;

class NoiseParams {
    @:native("offset")
    public var offset: Float = 0.0;

    @:native("scale")
    public var scale: Float = 0.0;

    @:native("persist")
    public var persist: Float = 0.0;

    @:native("lacunarity")
    public var lacunarity: Float = 0.0;

    @:native("seed")
    public var seed: Int = 0;

    @:native("octaves")
    public var octaves: UInt = 0;

    @:native("flags")
    public var flags: UInt = 0;

    @:native("spread")
    public var spread: Vector = Vector.zero();

    public function new() {}
}
