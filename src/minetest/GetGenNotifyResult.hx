package minetest;

import minetest.util.NativeArray;

@:multiReturn
extern final class GetGenNotifyResult {
    public var flags: String;
    public var decorationIds: NativeArray<UInt>;
    public var customIds: NativeArray<String>;
}
