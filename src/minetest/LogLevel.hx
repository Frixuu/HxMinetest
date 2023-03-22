package minetest;

/**
    Controls severity of the log messages.
**/
enum abstract LogLevel(String) {

    /**
        Logs that describe some critical state
        that requires special, immediate attention.
    **/
    var Error = "error";

    /**
        Logs that describe an abnormal state,
        but the mod/game can be continued with extra caution.
    **/
    var Warning = "warning";

    /**
        Logs that describe certain actions taken by the players.

        Note: By default, this is the least severe category that still gets printed to the console.
    **/
    var Action = "action";

    /**
        Logs that should describe the general flow of the mod's code.
    **/
    var Info = "info";

    /**
        Detailed logs that should provide additional developer context.
    **/
    var Verbose = "verbose";

    /**
        Detailed logs that should provide additional developer context.
    **/
    var Trace = "trace";

    /**
        Special level that is always printed.
    **/
    var None = "none";

    /**
        A special case level that makes the log message be treated as a deprecation notice.
    **/
    var Deprecated = "deprecated";
}
