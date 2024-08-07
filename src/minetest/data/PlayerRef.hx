// SPDX-License-Identifier: Zlib
package minetest.data;

/**
    An `ObjectRef` that is known to represent a player.
**/
@:forward
@:using(minetest.data.PlayerTools)
abstract PlayerRef(ObjectRef) to ObjectRef {

    /**
        Overrides the player's field of view.
        @param fov FOV value.
        @param isMultiplier Is the value a multiplier?
        @param transitionTime Time (in seconds)
    **/
    public inline function setFov(
        fov: Float,
        isMultiplier: Bool = false,
        transitionTime: Float = 0.0
    ): Void {
        untyped this.set_fov(fov, isMultiplier, transitionTime);
    }
}
