package minetest.client;

#if hxminetest._clientside
enum abstract CameraMode(Int) {
    public var FirstPerson = 0;
    public var ThirdPerson = 1;
    public var ThirdPersonFront = 2;
}
#end
