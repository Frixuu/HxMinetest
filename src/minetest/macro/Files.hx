// SPDX-License-Identifier: Zlib
package minetest.macro;

#if macro
import haxe.io.Path;
import haxe.macro.Expr;
import haxe.macro.ExprTools;
import haxe.macro.MacroStringTools;
import haxe.macro.Compiler;
import haxe.macro.Context;
import sys.FileSystem;
import sys.io.File;
#end

final class Files {

    /**
        Gets a path relative to the caller source file.
    **/
    public static macro function getPath(leaf: ExprOf<String>): ExprOf<String> {
        final posInfos = Context.getPosInfos(Context.currentPos());
        final directory = Path.directory(posInfos.file);
        final path = Path.join([directory, ExprTools.getValue(leaf)]);
        return macro $v{Path.normalize(path)};
    }

    /**
        Gets contents of a file, relative to the caller source file.
    **/
    public static macro function getContents(path: ExprOf<String>): ExprOf<String> {
        final position = Context.currentPos();
        final posInfos = Context.getPosInfos(position);
        final directory = Path.directory(posInfos.file);
        final filePath = Path.join([directory, ExprTools.getValue(path)]);
        return if (FileSystem.exists(filePath)) {
            final contents: String = File.getContent(filePath);
            macro $v{contents};
        } else {
            Context.error('Requested file $filePath was not found', position);
            macro "";
        }
    }
}
