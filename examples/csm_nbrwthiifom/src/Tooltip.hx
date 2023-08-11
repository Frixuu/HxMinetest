import minetest.Minetest;
import minetest.hud.HudHandle;

using Lambda;
using StringTools;
using TextTools;
using haxe.EnumTools.EnumValueTools;

class Tooltip {
    private var handleName: Null<HudHandle> = null;
    private var handleMod: Null<HudHandle> = null;
    private var lastUpdate: Null<UInt> = null;
    private var lastTarget: Target = Nothing;

    public function new() {}

    public function secondsSinceLastUpdate(): Float {
        final now = Minetest.getUsTime();
        final duration = now - (lastUpdate ?? 0);
        return duration * 0.000001;
    }

    public function update(target: Target) {

        lastUpdate = Minetest.getUsTime();
        if (lastTarget.equals(target)) {
            return;
        } else {
            lastTarget = target;
        }

        final localPlayer = Minetest.localPlayer;
        switch (target) {
            case Node(node):
                final technicalName: String = node.name;
                final parts = technicalName.split(":");
                updateMod(parts[0].formatAsModName());

                // Typically we would fetch the node's definition and use the description here,
                // but, as of writing, it does not get sent to the client.
                // As a workaround, we're going to format the technical name

                updateName(parts[1].snakeCaseToPascalCase());
            case Object(id):
                updateName('object #${id}');
                updateMod(null);
            case NodeUnknown:
                updateName("???");
                updateMod("???");
            case _:
                updateName(null);
                updateMod(null);
        }
    }

    private function updateName(text: Null<String>) {

        final localPlayer = Minetest.localPlayer;

        if (text == null) {
            if (handleName != null) {
                localPlayer.removeHud(handleName);
                handleName = null;
            }
            return;
        }

        if (handleName == null) {
            handleName = localPlayer.addHud({
                hud_elem_type: Text,
                position: {x: 0.5, y: 0.0},
                offset: {x: 0, y: 30},
                text: text,
                alignment: {x: 0, y: 0},
                scale: {x: 130, y: 30},
                number: 0xFFFFFF,
            });
            return;
        }

        localPlayer.changeHud(handleName, "text", text);
    }

    private function updateMod(text: Null<String>) {

        final localPlayer = Minetest.localPlayer;

        if (text == null) {
            if (handleMod != null) {
                localPlayer.removeHud(handleMod);
                handleMod = null;
            }
            return;
        }

        if (handleMod == null) {
            handleMod = localPlayer.addHud({
                hud_elem_type: Text,
                position: {x: 0.5, y: 0.0},
                offset: {x: 0, y: 50},
                text: text,
                alignment: {x: 0, y: 0},
                scale: {x: 130, y: 30},
                number: 0xFFFFFF,
                style: minetest.hud.HudDefinition.TextStyle.Italic,
            });
            return;
        }

        localPlayer.changeHud(handleMod, "text", text);
    }
}
