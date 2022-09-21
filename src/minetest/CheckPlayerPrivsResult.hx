package minetest;

import haxe.extern.EitherType;
import lua.Table;

@:multiReturn
@:structInit
extern class CheckPlayerPrivsResult {
    var success: Bool;
    var missingPrivs: EitherType<String, Table<Int, String>>;
}
