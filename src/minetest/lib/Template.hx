// SPDX-License-Identifier: Zlib
package minetest.lib;

#if (interp || eval)
import haxe.io.Path;
import sys.FileSystem;
import sys.io.File;

enum Entry {
    File(name: String);
    Directory(name: String, contents: Array<Entry>);
}

final class Template {
    private var templateBasePath: String;
    private var fileTree: Entry;

    private function new(templateBasePath: String, fileTree: Entry) {
        this.templateBasePath = templateBasePath;
        this.fileTree = fileTree;
    }

    public static function ofName(name: String): Template {

        final templateBasePath = minetest.macro.Files.getPath("../../../templates/");
        final path = Path.join([templateBasePath, name]);
        if (!FileSystem.exists(path)) {
            throw 'Template directory $name does not exist';
        }

        final entries = [];
        final tree = Directory(name, entries);

        function visitDir(path: String, entries: Array<Entry>) {
            final rawEntries = FileSystem.readDirectory(path);
            for (rawEntry in rawEntries) {
                final fullPath = Path.join([path, rawEntry]);
                entries.push(if (FileSystem.isDirectory(fullPath)) {
                    final subEntries = [];
                    final entry = Directory(rawEntry, subEntries);
                    visitDir(fullPath, subEntries);
                    entry;
                } else {
                    File(rawEntry);
                });
            }
        }

        visitDir(path, entries);
        return new Template(templateBasePath, tree);
    }

    public function installToDir(parentPath: String, projectName: String) {

        final targetPath = Path.join([parentPath, projectName]);
        if (FileSystem.exists(targetPath)) {
            throw 'The directory $targetPath already exists';
        }

        function copySubdir(
            entry: Entry,
            sourceDir: String,
            targetDir: String,
            ?overrideName: Null<String>
        ) {
            switch (entry) {
                case File(name):
                    final sourcePath = Path.join([sourceDir, name]);
                    final targetPath = Path.join([targetDir, overrideName ?? name]);
                    final fileContent = sys.io.File.getContent(sourcePath);
                    final processedContent = ~/\$name/g.replace(fileContent, projectName);
                    sys.io.File.saveContent(targetPath, processedContent);
                case Directory(name, contents):
                    final targetPath = Path.join([targetDir, overrideName ?? name]);
                    FileSystem.createDirectory(targetPath);
                    for (content in contents) {
                        copySubdir(content, Path.join([sourceDir, name]), targetPath);
                    }
            }
        }

        copySubdir(this.fileTree, this.templateBasePath, parentPath, projectName);
    }
}
#end
