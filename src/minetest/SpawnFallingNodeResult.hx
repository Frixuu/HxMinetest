package minetest;

import minetest.data.ObjectRef;

@:multiReturn
extern class SpawnFallingNodeResult {
    var success: Bool;
    var spawnedEntity: Null<ObjectRef>;
}
