package minetest.craft;

enum abstract RecipeType(String) {
    var Shaped = "shaped";
    var Shapeless = "shapeless";
    var ToolRepair = "toolrepair";
    var Cooking = "cooking";
    var Fuel = "fuel";
}
