package minetest;

import partials.Partial;

@:noCompletion
extern class Minetest_FileIo implements Partial {

    /**
        Recursively creates a directory specified by `path`.
        @param path Path to the target directory.
        @throws String An exception is thrown if the mod
        does not have permission to write to the target location.
        @return True on success, false if creating any of the directories failed.
    **/
    @:native("mkdir")
    public static function directoryCreate(path: String): Bool;

    /**
        Removes a directory specified by `path`.
        @param path Path to the target directory.
        @param recursive Should the contents also be deleted?
        @throws String An exception is thrown if the mod
        does not have permission to write to the target location.
        @return True on success, false if removing directories failed.
    **/
    @:native("rmdir")
    public static function directoryRemove(path: String, recursive: Bool): Bool;

    /**
        Copies a directory specified by `source` to `destination`.
        Any existing files will be overwritten.
        @param source Path to the source directory.
        @param destination Path of the target directory.
        @throws String An exception is thrown if the mod
        does not have permission to read from source
        or to write to the destination.
        @return True on success.
    **/
    @:native("cpdir")
    public static function directoryCopy(source: String, destination: String): Bool;

    /**
        Moves a directory specified by `source` to `destination`.
        The move will fail if the `destination` is not empty.
        @param source Path to the source directory.
        @param destination Path of the target directory.
        @throws String An exception is thrown if the mod
        does not have permission to read from source
        or to write to the destination.
        @return True on success, false if:
        - source does not exist,
        - destination exists and is non-empty,
        - cannot create new files or remove old ones.
    **/
    @:native("mvdir")
    public static function directoryMove(source: String, destination: String): Bool;

    @:native("get_dir_list")
    private static function getDirListRaw(path: String, include: ListEntries): LuaArray<String>;

    /**
        Returns an array of files and/or subfolders in a directory.
        @param path Path to the requested directory.
        @param include What type of children should be returned?
        @throws String An exception is thrown if the mod does not have permission to read files.
    **/
    public static inline function directoryList(
        path: String,
        include: ListEntries = All
    ): Array<String> {
        return @:privateAccess getDirListRaw(path, include).convertIntoHaxeArray();
    }

    /**
        Atomically replaces contents of a file.
        @param path Path to the file.
        @param content New contents of the file.
        @throws String An exception is thrown if the mod does not have permission to write files.
        @return True on success.
    **/
    @:native("safe_file_write")
    public static function safeFileWrite(path: String, content: String): Bool;
}
