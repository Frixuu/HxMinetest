import minetest.Minetest;
import minetest.craft.FuelRecipe;
import minetest.data.PlayerRef;
import minetest.item.ItemStack;
import minetest.math.Vector;
import minetest.util.Pair;

using Lambda;

class ExampleLuckyNode {

    /**
        Name of the node we're creating.
    **/
    public static inline final NODE_NAME = "example_lucky_node:lucky_node";

    private static function main() {

        final S = Minetest.getTranslator("lucky");
        Minetest.registerNode(NODE_NAME, {
            description: S("Lucky Node"),
            tiles: ["example_lucky_node_lucky_node.png"],
            groups: ["oddly_breakable_by_hand" => 2],
            onDestruct: onLuckyNodeDestroyed,
            drop: "",
        });

        Minetest.registerCraft(new FuelRecipe(NODE_NAME, 128.0));
    }

    private static function onLuckyNodeDestroyed(pos: Vector) {
        final randomValue = Math.random();
        if (randomValue < 0.5) {
            Minetest.itemDrop(new ItemStack("default:silver_sandstone_brick"), null, pos);
        } else if (randomValue < 0.9) {
            Minetest.addEntity(pos.offset(0, 1.5, 0), "carts:cart");
        } else {
            final closestPlayer = Minetest.getConnectedPlayers()
                .copyToArray()
                .map(player -> new Pair(player, player.getPosition().distance(pos)))
                .fold((item, min: Pair<PlayerRef, Float>) -> (item.right < min.right) ? item : min,
                    new Pair(null, 999999999.9))
                .left;

            if (closestPlayer != null) {
                final S = Minetest.getTranslator("lucky");
                closestPlayer.sendChatMessage(S("You've angered the gods!"));
                closestPlayer.setHealth(0, {
                    type: Drown,
                    from: Mod
                });
            }
        }
    }
}
