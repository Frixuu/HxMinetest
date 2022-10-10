package minetest;

import haxe.extern.EitherType;
import lua.Table;

@:multiReturn
extern class CheckPlayerPrivsResult {
    var success: Bool;
    var missing: EitherType<String, Table<Int, String>>;
}
