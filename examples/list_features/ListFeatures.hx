import minetest.Minetest;

class ListFeatures {
    private static function main() {
        Minetest.log("Features:");
        for (feature in Minetest.features) {
            Minetest.log('  - $feature');
        }
    }
}
