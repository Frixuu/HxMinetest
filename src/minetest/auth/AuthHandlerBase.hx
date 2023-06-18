// SPDX-License-Identifier: Zlib
package minetest.auth;

import lua.Lua.PairsResult;
import lua.Table;
import minetest.auth.AuthHandler;

/**
    A convenient starting point for creating custom `AuthHandler`s.
**/
@:nullSafety(Off)
abstract class AuthHandlerBase implements AuthHandler {
    @:dox(hide)
    @:native("mod_origin")
    public var modOrigin: Null<String>;

    @:dox(hide)
    @:luaDotMethod
    @:native("get_auth")
    public var getAuth(default, null): (name: String) -> Null<AuthData>;

    @:dox(hide)
    @:luaDotMethod
    @:native("create_auth")
    public var createAuth(default, null): (name: String, passwordRepr: Any) -> Void;

    @:dox(hide)
    @:luaDotMethod
    @:native("delete_auth")
    public var deleteAuth(default, null): (name: String) -> Bool;

    @:dox(hide)
    @:luaDotMethod
    @:native("set_password")
    public var setPassword(default, null): (name: String, passwordRepr: String) -> Bool;

    @:dox(hide)
    @:luaDotMethod
    @:native("set_privileges")
    public var setPrivileges(default, null): (name: String, privs: Table<String, Bool>) -> Void;

    @:dox(hide)
    @:luaDotMethod
    @:native("reload")
    public var reload(default, null): () -> Bool;

    @:dox(hide)
    @:luaDotMethod
    @:native("record_login")
    public var recordLogin(default, null): (name: String) -> Void;

    @:dox(hide)
    @:luaDotMethod
    @:native("iterate")
    public var iterate(default, null): () -> PairsResult<String, Bool>;

    public function new() {
        this.getAuth = this.getAuthImpl;
        this.createAuth = this.createAuthImpl;
        this.deleteAuth = this.deleteAuthImpl;
        this.setPassword = this.setPasswordImpl;
        this.setPrivileges = this.setPrivilegesImpl;
        this.reload = this.reloadImpl;
        this.recordLogin = this.recordLoginImpl;
        this.iterate = this.iterateImpl;
    }

    @:dox(show)
    private abstract function getAuthImpl(name: String): Null<AuthData>;

    @:dox(show)
    private abstract function createAuthImpl(name: String, passwordRepr: Any): Void;

    @:dox(show)
    private abstract function deleteAuthImpl(name: String): Bool;

    @:dox(show)
    private abstract function setPasswordImpl(name: String, passwordRepr: Any): Bool;

    @:dox(show)
    private abstract function setPrivilegesImpl(name: String, privs: Table<String, Bool>): Void;

    @:dox(show)
    private abstract function reloadImpl(): Bool;

    @:dox(show)
    private abstract function recordLoginImpl(name: String): Void;

    @:dox(show)
    private abstract function iterateImpl(): Dynamic;
}
