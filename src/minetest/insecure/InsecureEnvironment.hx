package minetest.insecure;

import lua.Lua.PCallResult;
import lua.Table.AnyTable;

extern final class InsecureEnvironment {
    var debug: Dynamic;
    var string: Dynamic;

    @:luaDotMethod
    public function getfenv(data: Any): AnyTable;

    @:luaDotMethod
    public function setfenv(data: Any, tbl: Any): Void;

    @:luaDotMethod
    public function pcall(fn: Any, ...args: Dynamic): PCallResult;

    @:native("require")
    @:luaDotMethod
    private function requireRaw(module: String): Dynamic;

    public inline function require(module: String): Dynamic {
        return cast EnvironmentExtensions.run(this, module, m -> this.requireRaw(m));
    }
}
