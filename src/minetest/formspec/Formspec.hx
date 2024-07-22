package minetest.formspec;

import minetest.formspec.element.Button;
import minetest.formspec.element.Field;
import minetest.formspec.element.Label;
import minetest.formspec.element.Size;
import minetest.formspec.element.VersionDefinition;
import minetest.formspec.element.FormspecElement;

abstract Formspec(Impl) {
    private inline function new(v: Null<Int>, elements: Array<FormspecElement>) {
        this = {_version: version(v ?? 1), _elements: elements};
    }

    public static inline function v2(elements: Array<FormspecElement>): Formspec {
        return new Formspec(2, elements);
    }

    public static inline function v3(elements: Array<FormspecElement>): Formspec {
        return new Formspec(3, elements);
    }

    public static inline function v4(elements: Array<FormspecElement>): Formspec {
        return new Formspec(4, elements);
    }

    public static inline function v5(elements: Array<FormspecElement>): Formspec {
        return new Formspec(5, elements);
    }

    public static inline function v6(elements: Array<FormspecElement>): Formspec {
        return new Formspec(6, elements);
    }

    public static inline function version(v: Int): VersionDefinition {
        return {version: v};
    }

    public static inline function size(def: Size): Size {
        return def;
    }

    public static inline function field(def: Field): Field {
        return def;
    }

    public static inline function label(def: Label): Label {
        return def;
    }

    public static inline function button(def: Button): Button {
        return def;
    }

    @:to
    public function toFormspecString(): FormspecString {

        final sb = new StringBuf();

        var seenVersion = false;
        if (this._version != null) {
            seenVersion = true;
            this._version.intoFormspecString(sb);
        }

        for (element in this._elements) {
            if (Std.isOfType(element, VersionDefinition) && seenVersion) {
                throw "formspec version declared more than once";
            }
            element.intoFormspecString(sb);
        }
        return sb.toString();
    }
}

@:structInit
private final class Impl {
    public var _version: Null<VersionDefinition>;
    public var _elements: Array<FormspecElement>;
}
