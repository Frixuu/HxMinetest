package minetest.macro;

#if macro
import haxe.macro.Compiler;
import haxe.macro.Context;
import haxe.macro.Expr.Position;

final class Defines {

    /**
        Registers custom defines documentation
        for `haxe --library hxminetest --help-user-defines`.
    **/
    public static function registerCustom() {
        #if (haxe < version("4.3.999"))
        Compiler.registerCustomDefine({
            define: "hxminetest.clientside",
            doc: "If defined, HxMinetest will try its best to only enable client-side externs. " +
            "If omitted, it will be configured for regular, server-side modding.",
            platforms: [Lua],
        }, "hxminetest");
        #end
    }

    public static function applyEnv() {

        // Accept legacy define
        if (Context.defined("csm")) {
            Compiler.define("hxminetest.clientside");
            final noPos = Context.makePosition({min: 0, max: 0, file: ""});
            Context.warning("the define `csm` is deprecated", noPos, 0);
            Context.warning("use `hxminetest.clientside` instead", noPos, 1);
        }

        // Two separate defines are used,
        // so library authors can get LSP support and full doc dump,
        // while library users still get locked to one side only.
        if (Context.defined("hxminetest.clientside")) {
            Compiler.define("hxminetest._clientside");
        } else {
            Compiler.define("hxminetest._serverside");
        }
    }
}
#end
