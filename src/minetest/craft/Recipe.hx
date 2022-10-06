package minetest.craft;

abstract class Recipe {

    /**
        Type of this recipe.
    **/
    private var type: RecipeType;

    private function new(type: RecipeType) {
        this.type = type;
    }
}
