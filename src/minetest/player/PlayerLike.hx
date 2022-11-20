package minetest.player;

import minetest.data.PlayerRef;
import haxe.extern.EitherType;

typedef PlayerLike = EitherType<PlayerRef, String>;
