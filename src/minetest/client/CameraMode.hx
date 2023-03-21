package minetest.client;

#if csm
enum abstract CameraMode(Int) {
    var FirstPerson = 0;
    var ThirdPerson = 1;
    var ThirdPersonFront = 2;
}
#end
