// SPDX-License-Identifier: Zlib
package minetest.data;

/**
    An `ObjectRef` that is known to represent a player.
**/
@:remove
@:using(minetest.data.PlayerTools)
interface PlayerRef extends ObjectRef {

    /**
        Overrides the player's field of view.
        @param fov FOV value.
        @param isMultiplier Is the value a multiplier?
        @param transitionTime Time (in seconds)
    **/
    @:native("set_fov")
    public function setFov(
        fov: Float,
        isMultiplier: Bool = false,
        transitionTime: Float = 0.0
    ): Void;
}
