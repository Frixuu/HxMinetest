package minetest;

interface VersionInfo {

    /**
        Name of the project.
    **/
    @:native("project")
    var engineName: String;

    /**
        Simple version.
    **/
    @:native("string")
    var version: String;

    /**
        Full git version (if available).
    **/
    @:native("hash")
    var versionGit: Null<String>;

    /**
        Is it a development build?
    **/
    @:native("is_dev")
    var isDev: Bool;
}
