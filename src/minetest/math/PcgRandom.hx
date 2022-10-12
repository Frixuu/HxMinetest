package minetest.math;

@:native("PcgRandom")
extern final class PcgRandom {
    @:selfCall
    public function new(seed: Any, ?sequence: Any);
}
