package minetest.worldgen;

enum abstract EmergeType(Int) {
    public var Cancelled = 0;
    public var Errored = 1;
    public var LoadedFromMemory = 2;
    public var LoadedFromDisk = 3;
    public var Generated = 4;
}
