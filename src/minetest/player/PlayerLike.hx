// SPDX-License-Identifier: Zlib
package minetest.player;

import minetest.data.PlayerRef;

/**
    A value that somehow represents a Minetest player,
    be it a username or an actual player ref returned from the engine.
**/
@:using(minetest.player.PlayerLikeTools)
abstract PlayerLike(Dynamic) from PlayerRef from String {}
