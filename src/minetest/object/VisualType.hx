package minetest.object;

enum abstract VisualType(String) {

    /**
        A node-sized cube.
    **/
    var Cube = "cube";

    /**
        A flat texture, always facing the player.
    **/
    var Sprite = "sprite";

    /**
        A vertical, flat texture.
    **/
    var UprightSprite = "upright_sprite";
    var Mesh = "mesh";
    var WieldItem = "wielditem";
    var Item = "item";
}
