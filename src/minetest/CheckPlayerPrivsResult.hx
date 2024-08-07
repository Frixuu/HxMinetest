package minetest;

import haxe.extern.EitherType;
import minetest.util.NativeArray;

@:multiReturn
extern class CheckPlayerPrivsResult {
    public var success: Bool;
    public var missing: EitherType<String, NativeArray<String>>;
}
