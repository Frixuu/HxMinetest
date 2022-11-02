package minetest;

enum abstract RemovePlayerResult(Int) {
    public var Success = 0;
    public var NoSuchPlayer = 1;
    public var PlayerConnected = 2;
}
