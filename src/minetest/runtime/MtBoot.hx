package minetest.runtime;

import minetest.insecure.http.HttpApi;
import minetest.macro.Snippets;

@:keep
@:native("__hxminetest")
@:dox(hide)
@:noCompletion
extern class MtBoot {
    public static inline function __init__() {
        Snippets.includeFile("00_setup.lua");
        Snippets.includeFile("10_request_http_api.lua");
    }

    @:native("http_api")
    public static var httpApi(default, never): Null<HttpApi>;
}
