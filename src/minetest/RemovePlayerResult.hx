package minetest;

enum abstract RemovePlayerResult(Int) {
    public var Success = 0;
    public var ErrorNoSuchPlayer = 1;
    public var ErrorCurrentlyConnected = 2;
}
