package minetest;

import minetest.math.Vector;

@:multiReturn
extern class LosCheckResult {
    var hasLineOfSight: Bool;
    var blockingNodePos: Vector;
}
