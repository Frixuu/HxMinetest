// SPDX-License-Identifier: Zlib
package minetest;

import lua.Table;
import minetest.util.NativeSet;

@:multiReturn
extern class HasFeatureResult {
    var success: Bool;
    var missing: NativeSet<String>;
}
