package minetest.hud;

import haxe.extern.EitherType;

typedef HudDefinition = {
    var hud_elem_type: ElementType;
    @:optional var name: String;
    @:optional var direction: Direction;
    @:optional var z_index: Int;
    @:optional var number: Int;
    @:optional var item: Int;
    @:optional var style: EitherType<Int, TextStyle>;
    @:optional var text: String;
    @:optional var text2: String;
    @:optional var alignment: {x: Float, y: Float};
    @:optional var position: {x: Float, y: Float};
    @:optional var offset: {x: Any, y: Any};
    @:optional var size: {x: Any, y: Any};
    @:optional var scale: {x: Any, y: Any};
    @:optional var world_pos: {x: Any, y: Any, z: Any};
}

/**
    Direction.
**/
enum abstract Direction(Int) {
    var LeftRight = 0;
    var RightLeft = 1;
    var TopBottom = 2;
    var BottomTop = 3;
}

/**
    Type of the HUD element.
**/
enum abstract ElementType(String) {
    var Image = "image";
    var Text = "text";
    var Statbar = "statbar";
    var Inventory = "inventory";
    var Waypoint = "waypoint";
    var ImageWaypoint = "image_waypoint";
    var Compass = "compass";
    var Minimap = "minimap";
}

/**
    Style of the text.
**/
enum abstract TextStyle(Int) {
    var None = 0;
    var Bold = 1;
    var Italic = 2;
    var Monospace = 4;
}
