package minetest;

import minetest.data.PlayerRef;

class Events {}
typedef PlayerJoinCallback = (player:PlayerRef, lastLogin:Null<Int>) -> Void;
typedef ChatMessageCallback = (name:String, message:String) -> Bool;
