// SPDX-License-Identifier: Zlib
package minetest;

import lua.Table;

/**
    A set of engine flags.
**/
abstract Flags<E>(Any) {
    @:from
    public static inline function fromElement<E>(el: E): Flags<E> {
        return StringForm.fromElement(el);
    }

    @:from
    public static inline function fromArray<E>(arr: Array<E>): Flags<E> {
        return StringForm.fromArray(arr);
    }

    @:from
    @:generic
    public static inline function fromMap<E>(m: Map<E, Bool>): Flags<E> {
        return cast TableForm.fromMap(m);
    }

    @:from
    public static inline function fromStringForm<E>(sf: StringForm<E>): Flags<E> {
        return cast sf;
    }

    @:from
    public static inline function fromTableForm<E>(tf: TableForm<E>): Flags<E> {
        return cast tf;
    }
}

/**
    A comma-separated set of flags.
**/
abstract StringForm<E>(String) from String to String {
    public static inline function fromArray<E>(arr: Array<E>): StringForm<E> {
        return arr.join(", ");
    }

    @:from
    public static inline function fromElement<E>(el: E): StringForm<E> {
        return Std.string(el);
    }

    @:op(A | B)
    public static inline function union1<E>(lhs: StringForm<E>, rhs: E): StringForm<E> {
        return lhs + ", " + rhs;
    }

    @:op(A | B)
    public static inline function union2<E>(lhs: E, rhs: StringForm<E>): StringForm<E> {
        return lhs + ", " + rhs;
    }
}

/**
    A representation of flags in the form of a `Table.`.
**/
abstract TableForm<E>(Table<E, Bool>) from Table<E, Bool> to Table<E, Bool> {
    @:generic
    public static inline function fromMap<E>(m: Map<E, Bool>): TableForm<E> {
        return cast Table.fromMap(m);
    }

    public static inline function fromArray<E>(arr: Array<E>): TableForm<E> {
        final table = Table.create();
        for (flag in arr) {
            table[untyped flag] = true;
        }
        return cast table;
    }
}
