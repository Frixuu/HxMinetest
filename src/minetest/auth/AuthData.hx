// SPDX-License-Identifier: Zlib
package minetest.auth;

import lua.Table;
import minetest.util.NativeSet;

/**
    Schema for authentication data returned by native auth handler.
**/
interface AuthData {
    @:native("password")
    public var password: String;
    @:native("privileges")
    public var privileges: NativeSet<String>;
    @:native("last_login")
    public var lastLogin: Null<Int>;
}
