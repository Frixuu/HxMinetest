package partials;

import haxe.macro.Context;
import haxe.macro.Compiler;
import haxe.macro.Expr;
import haxe.ds.StringMap;

using Lambda;

/**
 * Utility macros for defining multiple parts of a class in different files. To define a class
 * as a partial, simply implement the partials.Partial interface. To indicate the "host" class
 * for a series of partials, use the `@:partials()` metadata on the class, like so:
 *
 * ```haxe
 * package my.package;
 *
 * @:partials(my.package.PartialDefinitionA, my.package.partials.PartialDefinitionB)
 * class MyClassThatWouldBeReallyLongWithoutPartials implements partials.Partial {
 *     public function new() {
 *         trace("My partials are here!");
 *         foo();
 *         bar();
 *     }
 * }
 * ```
 *
 * ```haxe
 * package my.package;
 *
 * class PartialDefinitionA implements partials.Partial {
 *     public function foo() {
 *         trace("FOO!");
 *     }
 * }
 * ```
 *
 * ```haxe
 * package my.package.partials;
 *
 * class PartialDefinitionB implements partials.Partial {
 *     public function bar() {
 *         trace("BAR!");
 *     }
 * }
 * ```
 *
 * This would output:
 *
 * ```
 * My partials are here!
 * FOO!
 * BAR!
 * ```
 */
class Partials {
    private static var partials: StringMap<Array<Field>> = new StringMap<Array<Field>>();

    private static function getModuleName(e: Expr): Null<String> {
        return switch (e.expr) {
            case EConst(c):
                switch (c) {
                    case CIdent(s): s;
                    default: null;
                }
            case EField(e, field):
                getModuleName(e) + "." + field;
            default: null;
        };
    }

    macro public static function process(): Array<Field> {

        final localClass = Context.getLocalClass();
        final localModule = Context.getLocalModule();
        final localFields = Context.getBuildFields();

        // see if it is a partial host
        final meta = localClass.get().meta;
        if (meta.has(":partials")) {

            // yup, it is!
            final currentPos = Context.currentPos();
            for (candidate in meta.extract(":partials").flatMap(e -> e.params)) {

                // force-import the referenced module
                final moduleName: Null<String> = getModuleName(candidate);
                for (typ in Context.getModule(moduleName)) {
                    switch (typ) {
                        case TInst(ct, _):
                            final classType = ct.get();
                        case _:
                    }
                }

                // ok, now that it's imported, bring in all of its fields
                final moduleFields: Null<Array<Field>> = partials.get(moduleName);
                if (moduleFields == null) {
                    Context.info('No cached fields for module $moduleName', currentPos);
                } else {
                    for (field in moduleFields) {
                        field.pos = currentPos;
                        localFields.push(field);
                    }
                }
            }
        } else {
            // nope, just a regular partial
            // save its fields
            partials.set(localModule, localFields);

            // and trash it
            localClass.get().exclude();
            return [];
        }

        return localFields;
    }
}
