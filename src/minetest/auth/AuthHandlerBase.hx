package minetest.auth;

import lua.Lua.PairsResult;
import lua.Table;
import minetest.auth.AuthHandler;

/**
    A convenient `AuthHandler` starting point.
**/
abstract class AuthHandlerBase implements AuthHandler {
    @:native("mod_origin")
    public var modOrigin: Null<String>;

    @:luaDotMethod
    @:native("get_auth")
    public var getAuth(default, null): (name: String) -> Null<AuthData>;

    @:luaDotMethod
    @:native("create_auth")
    public var createAuth(default, null): (name: String, passwordRepr: Any) -> Void;

    @:luaDotMethod
    @:native("delete_auth")
    public var deleteAuth(default, null): (name: String) -> Bool;

    @:luaDotMethod
    @:native("set_password")
    public var setPassword(default, null): (name: String, passwordRepr: String) -> Bool;

    @:luaDotMethod
    @:native("set_privileges")
    public var setPrivileges(default, null): (name: String, privs: Table<String, Bool>) -> Void;

    @:luaDotMethod
    @:native("reload")
    public var reload(default, null): () -> Bool;

    @:luaDotMethod
    @:native("record_login")
    public var recordLogin(default, null): (name: String) -> Void;

    @:luaDotMethod
    @:native("iterate")
    public var iterate(default, null): () -> PairsResult<String, Bool>;

    public function new() {
        // Assigning function to fields/dot methods currently does not work correctly
        // TODO fix when/if https://github.com/HaxeFoundation/haxe/pull/10817 gets merged
        this.getAuth = untyped __lua__("function(name) return self:_get_auth_impl(name); end");
        this.createAuth = untyped __lua__("function(name, pwd) self:_create_auth_impl(name, pwd); end");
        this.deleteAuth = untyped __lua__("function(name) return self:_delete_auth_impl(name); end");
        this.setPassword = untyped __lua__("function(name, pwd) return self:_set_password_impl(name, pwd); end");
        this.setPrivileges = untyped __lua__("function(name, privs) self:_set_privileges_impl(name, privs); end");
        this.reload = untyped __lua__("function() return self:_reload_impl(); end");
        this.recordLogin = untyped __lua__("function(name) self:_record_login_impl(name); end");
        this.iterate = untyped __lua__("function() return self:_iterate_impl(); end");
    }

    @:keep
    @:native("_get_auth_impl")
    private abstract function getAuthImpl(name: String): Null<AuthData>;

    @:keep
    @:native("_create_auth_impl")
    private abstract function createAuthImpl(name: String, passwordRepr: Any): Void;

    @:keep
    @:native("_delete_auth_impl")
    private abstract function deleteAuthImpl(name: String): Bool;

    @:keep
    @:native("_set_password_impl")
    private abstract function setPasswordImpl(name: String, passwordRepr: Any): Bool;

    @:keep
    @:native("_reload_impl")
    private abstract function reloadImpl(): Bool;

    @:keep
    @:native("_record_login_impl")
    private abstract function recordLoginImpl(name: String): Void;

    @:keep
    @:native("_iterate_impl")
    private abstract function iterateImpl(): Dynamic;
}
