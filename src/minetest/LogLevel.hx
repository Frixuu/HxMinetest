package minetest;

@:enum
abstract LogLevel(String) {
    var None = "none";
    var Error = "error";
    var Warning = "warning";
    var Action = "action";
    var Info = "info";
    var Verbose = "verbose";
}
