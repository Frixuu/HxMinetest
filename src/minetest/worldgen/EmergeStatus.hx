package minetest.worldgen;

/**
    Status of the block emerge operation.
**/
enum abstract EmergeStatus(Int) {

    /**
        The block emerge has been cancelled.
    **/
    public var Cancelled = 0;

    /**
        The operation has finished unsuccessfully.
    **/
    public var Errored = 1;

    /**
        The block has been fetched from the memory.
    **/
    public var LoadedFromMemory = 2;

    /**
        The block has been fetched from the disk.
    **/
    public var LoadedFromDisk = 3;

    /**
        The area the block is in has just been generated.
    **/
    public var Generated = 4;
}
