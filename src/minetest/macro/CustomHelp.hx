package minetest.macro;

#if macro
import haxe.macro.Compiler;

final class CustomHelp {
    public static function register() {
        Compiler.registerCustomDefine({
            define: "csm",
            doc: "If defined, HxMinetest will try its best to only enable client-side externs. " +
            "If omitted, it will be configured for regular, server-side modding.",
            platforms: [Lua]
        }, null);
    }
}
#end
