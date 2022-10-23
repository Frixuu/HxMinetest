package minetest.object;

interface LuaEntity {
    @:native("get_staticdata")
    public function getStaticData(): String;
}
