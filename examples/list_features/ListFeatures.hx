import minetest.Minetest;

function main() {
    Minetest.log("Features:");
    for (feature in Minetest.features) {
        Minetest.log('  - $feature');
    }
}
