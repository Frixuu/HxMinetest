package minetest.lib;

#if (interp || eval)
import haxe.Exception;
import haxe.io.Path;
import sys.io.File;
import sys.FileSystem;
import Sys.println;

class Main {
    static function main() {
        final args = Sys.args();
        var workingDir = Sys.getCwd();
        if (Sys.getEnv("HAXELIB_RUN") != null) {
            final dir = args.pop();
            workingDir = dir != null ? dir : workingDir;
        }

        if (!FileSystem.exists(workingDir)) {
            throw new Exception('The working directory does not exist: $workingDir');
        }

        if (args.length == 0) {
            println("Usage: haxelib run hxminetest [subcommand]");
            Sys.exit(1);
        }

        final subcommand = args[0];
        switch (subcommand) {
            case "create-mod", "init", "new":
                var modName = "my_awesome_mod";
                if (args.length != 2) {
                    println('No mod name given: using "$modName"');
                } else {
                    modName = args[1];
                };

                try {
                    scaffoldNewMod(modName, workingDir);
                    Sys.exit(0);
                } catch (e:Exception) {
                    println('An exception was thrown when scaffolding the mod $modName:');
                    println(e.details());
                    Sys.exit(2);
                }

            default:
                println('Unknown subcommand: $subcommand');
                Sys.exit(3);
        }
    }

    /**
        Saves a simple Hello World mod to disk.
        @param name "Technical" name of the mod.
        @param parentDir The parent directory of the newly created mod folder.
    **/
    private static function scaffoldNewMod(name: String, parentDir: String) {
        final modDirPath = Path.join([parentDir, name]);
        if (FileSystem.exists(modDirPath)) {
            throw new Exception('The directory $name already exists in $parentDir');
        }

        FileSystem.createDirectory(modDirPath);

        File.saveContent(Path.join([modDirPath, "build.hxml"]), [
            "--class-path src",
            "--lua init.lua",
            "--define analyzer-optimize",
            "--dce full",
            "--library hxminetest",
            "--main Mod"
        ].join("\n"));

        File.saveContent(Path.join([modDirPath, "mod.conf"]), [
            'name = $name',
            "description = This is a description of my super awesome mod using Haxe!"
        ].join("\n"));

        File.saveContent(Path.join([modDirPath, ".gitignore"]), "init.lua\n");

        var srcPath = Path.join([modDirPath, "src"]);
        FileSystem.createDirectory(srcPath);

        File.saveContent(Path.join([srcPath, "Mod.hx"]), [
            "import minetest.Minetest;",
            "",
            "class Mod {",
            "	public static function main():Void {",
            '		Minetest.log(Action, "Hello world! I\'m $name");',
            "	}",
            "}"
        ].join("\n"));

        println("Mod scaffolded successfully! Here's how you build it:");
        println('  1. cd $name');
        println("  2. haxe build.hxml");
    }
}
#end
