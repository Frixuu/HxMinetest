package minetest.auth;

import lua.Table;

extern class AuthData {
    @:native("password")
    var password: String;
    @:native("privileges")
    var privileges: Table<String, Bool>;
    @:native("last_login")
    var lastLogin: Null<Float>;
}
