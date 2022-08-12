package minetest.lib;

#if (interp || eval)
import haxe.io.Path;
import sys.io.File;
import sys.FileSystem;

class Main {
    static function main() {
        var args = Sys.args();
        var workingDir = Sys.getCwd();
        if (Sys.getEnv("HAXELIB_RUN") != null) {
            final dir = args.pop();
            workingDir = dir != null ? dir : workingDir;
        }

        if (args.length == 0) {
            Sys.println("Usage: haxelib run hxminetest [subcommand]");
            Sys.exit(1);
        }

        final subcommand = args[0];
        switch (subcommand) {
            case "create-mod", "init", "new":
                var modName = "my_awesome_mod";
                if (args.length != 2) {
                    Sys.println('No mod name given: using "$modName"');
                } else {
                    modName = args[1];
                };

                var modDirPath = Path.join([workingDir, modName]);
                FileSystem.createDirectory(modDirPath);

                File.saveContent(Path.join([modDirPath, "build.hxml"]), [
                    "-cp src",
                    "--lua init.lua",
                    "-D lua-ver 5.1",
                    "-D lua-vanilla",
                    "-D lua_jit",
                    "-D analyzer-optimize",
                    "-dce full",
                    "-L hxminetest",
                    "-m Mod"
                ].join("\n"));

                File.saveContent(Path.join([modDirPath, "mod.conf"]), [
                    'name = $modName',
                    "description = This is a description of my super awesome mod using Haxe!"
                ].join("\n"));

                File.saveContent(Path.join([modDirPath, ".gitignore"]), "init.lua");

                var srcPath = Path.join([modDirPath, "src"]);
                FileSystem.createDirectory(srcPath);

                File.saveContent(Path.join([srcPath, "Mod.hx"]), [
                    "import minetest.Log;",
                    "",
                    "class Mod {",
                    "	public static function main():Void {",
                    '		Log.action("Hello world! I\'m $modName!");',
                    "	}",
                    "}"
                ].join("\n"));

                Sys.println("Mod scaffolded successfully! Here's how you build it:");
                Sys.println('  1. cd $modName');
                Sys.println("  2. haxe build.hxml");
                Sys.exit(0);

            default:
                Sys.println('Unknown subcommand: $subcommand');
                Sys.exit(2);
        }
    }
}
#end
