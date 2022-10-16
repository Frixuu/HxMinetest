package minetest.auth;

import lua.Table;

extern interface AuthHandler {
    @:native("mod_origin")
    public var modOrigin: Null<String>;

    @:luaDotMethod
    @:native("get_auth")
    public dynamic function getAuth(name: String): Null<AuthData>;

    /**
        @param passwordRepr An engine-defined representation of the password.
    **/
    @:luaDotMethod
    @:native("create_auth")
    public dynamic function createAuth(name: String, passwordRepr: Any): Void;

    @:luaDotMethod
    @:native("delete_auth")
    public dynamic function deleteAuth(name: String): Bool;

    /**
        @param passwordRepr An engine-defined representation of the password.
    **/
    @:luaDotMethod
    @:native("set_password")
    public dynamic function setPassword(name: String, passwordRepr: String): Bool;

    @:luaDotMethod
    @:native("set_privileges")
    public dynamic function setPrivileges(name: String, privs: Table<String, Bool>): Void;

    @:luaDotMethod
    @:native("reload")
    public dynamic function reload(): Bool;

    @:luaDotMethod
    @:native("record_login")
    public dynamic function recordLogin(name: String): Void;

    @:luaDotMethod
    @:native("iterate")
    public dynamic function iterate(): (() -> IterateResult);
}

@:multiReturn extern class IterateResult {
    var currentName: Null<String>;
    var exists: Bool;
}
