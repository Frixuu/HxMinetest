import minetest.MapNode;
import minetest.Minetest;
import minetest.PointedThing;
import minetest.math.Vector;

inline final MAX_RANGE: Float = 10.0;

function main() {

    final restrictions = Minetest.getCsmRestrictions();
    if (restrictions.isSet(LookupNodes)) {
        Minetest.displayChatMessage("The server restricts node lookups. Range may be affected.");
        Minetest.after(0, () -> {
            if (Minetest.localPlayer?.getName() == "singleplayer") {
                Minetest.displayChatMessage("(Change option csm_restriction_noderange to fix it.)");
            }
        });
    }

    final tooltip = new Tooltip();
    Minetest.registerGlobalstep(_ -> {

        final camera = Minetest.camera ?? return;
        final startPos = camera.getPos();
        final endPos = startPos + (camera.getLookDir() * (Range.detected ?? MAX_RANGE));

        for (hit in Minetest.raycast(startPos, endPos, true, !Minetest.localPlayer.isInLiquid())) {
            switch (hit.type) {
                case Node:
                    final node = Minetest.getNode(hit.under);
                    if (node == null) {

                        // When a raycast detects a node, but the node itself is null,
                        // it means we have hit the CSM restriction for node lookup.

                        // As of writing (Minetest 5.8.0) the scripting API
                        // does not expose the node range to client mods,
                        // but we can try to approximate it anyway:
                        if (Range.detected == null) {
                            Range.tryDetect(MAX_RANGE);
                        }

                        // Anyway, not much we can do at this point
                        tooltip.update(NodeUnknown);
                        return;
                    }

                    tooltip.update(Node(node));
                    return;
                case Object:
                    final id = hit.objectId;
                    tooltip.update(Object(id));
                    return;
                case _:
            }
        }

        if (tooltip.secondsSinceLastUpdate() > 0.25) {
            tooltip.update(Nothing);
        }
    });

    Minetest.registerOnNodePunched((_, node) -> {
        tooltip.update(Node(node));
    });
}
