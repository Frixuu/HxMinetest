import minetest.Minetest;

var previousHp: Int = 0;

function evaluateHealth() {
    Minetest.log(Action, "Health changed, figuring out what to do");
    final oldHp = previousHp;
    final newHp = Minetest.localPlayer.getHp();
    previousHp = newHp;
    if (newHp <= 5 && oldHp > newHp) {
        Minetest.log(Action, "Oh yeah, low HP! Bailing");
        Minetest.disconnect();
    }
}

function main() {
    Minetest.log(Action, "Enabling RageQuit");
    Minetest.registerOnDamageTaken(_ -> evaluateHealth());
    Minetest.registerOnHpModification(_ -> evaluateHealth());
}
