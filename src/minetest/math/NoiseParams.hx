package minetest.math;

typedef NoiseParams = {
    public var offset: Float;
    public var scale: Float;
    public var spread: Vector;
    public var seed: Int;
    public var octaves: UInt;
    public var persistence: Float;
    public var lacunarity: Float;
    @:optional public var flags: String;
}
