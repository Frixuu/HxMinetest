import minetest.Minetest;

var detected: Null<Float> = null;

function tryDetect(maxRange: Float) {

    final localPlayer = Minetest.localPlayer ?? return;
    final playerPos = localPlayer.getPos();
    final dir = if (playerPos.y < 0) {
        1;
    } else {
        -1;
    };

    var i = maxRange;
    while (i >= 0.0) {
        if (Minetest.getNode(playerPos.offset(0, dir * i, 0).round()) != null) {
            break;
        }
        i -= 0.5;
    }

    if (i >= 0.0) {
        detected = i;
    }
}
