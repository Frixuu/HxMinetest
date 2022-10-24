package minetest.auth;

import lua.Lua.PairsResult;
import lua.Table;

interface AuthHandler {

    /**
        The mod this auth handler comes from.
    **/
    @:native("mod_origin")
    public var modOrigin: Null<String>;

    @:luaDotMethod
    @:native("get_auth")
    public var getAuth(default, null): (name: String) -> Null<AuthData>;

    /**
        @param passwordRepr An engine-defined representation of the password.
    **/
    @:luaDotMethod
    @:native("create_auth")
    public var createAuth(default, null): (name: String, passwordRepr: Any) -> Void;

    @:luaDotMethod
    @:native("delete_auth")
    public var deleteAuth(default, null): (name: String) -> Bool;

    /**
        @param passwordRepr An engine-defined representation of the password.
    **/
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
}
