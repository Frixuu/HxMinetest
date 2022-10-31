package minetest.macro;

#if macro
import haxe.io.Path;
import haxe.macro.Expr;
import haxe.macro.ExprTools;
import haxe.macro.Compiler;
import haxe.macro.Context;
import sys.FileSystem;
#end

final class Snippets {

    /**
        Includes a file relative to where the macro was called.
    **/
    public static macro function includeFile(path: ExprOf<String>): Expr {
        final position = Context.currentPos();
        final posInfos = Context.getPosInfos(position);
        final directory = Path.directory(posInfos.file);
        final filePath = Path.join([directory, ExprTools.getValue(path)]);
        if (FileSystem.exists(filePath)) {
            Compiler.includeFile(filePath);
        } else {
            Context.error('Included file $filePath was not found', position);
        }
        return macro null;
    }
}
