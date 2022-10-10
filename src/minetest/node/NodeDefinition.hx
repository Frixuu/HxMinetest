package minetest.node;

typedef NodeDefinition = {
    @:optional var description: String;
    @:optional var tiles: Dynamic;
    @:optional var is_ground_content: Bool;
    @:optional var groups: Dynamic;
}
