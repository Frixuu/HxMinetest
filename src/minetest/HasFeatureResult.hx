package minetest;

import lua.Table;

@:multiReturn
extern class HasFeatureResult {
    var success: Bool;
    var missing: Table<String, Bool>;
}
