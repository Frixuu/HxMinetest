package minetest.player;

import minetest.data.PlayerRef;
import haxe.extern.EitherType;

@:using(minetest.player.PlayerLikeTools)
typedef PlayerLike = EitherType<PlayerRef, String>;
