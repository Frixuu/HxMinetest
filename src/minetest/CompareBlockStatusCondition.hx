package minetest;

enum abstract CompareBlockStatusCondition(String) {
    var Unknown = "unknown";
    var Emerging = "emerging";
    var Loaded = "loaded";
    var Active = "active";
}
