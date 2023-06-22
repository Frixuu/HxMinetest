// SPDX-License-Identifier: Zlib
package minetest.serialization;

/**
    The result of `Minetest.writeJson`.
**/
@:multiReturn
extern class WriteJsonResult {

    /**
        If serializing to JSON was successful, contains the JSON document.
    **/
    public var json: Null<String>;

    /**
        If serializing failed, contains the error message.
    **/
    public var errorMessage: Null<String>;
}
