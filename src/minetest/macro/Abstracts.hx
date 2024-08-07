// SPDX-License-Identifier: Zlib
package minetest.macro;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;
#end

using Lambda;

final class Abstracts {

    /**
        When type-building an abstract,
        auto-implements all variables/physical properties.
    **/
    public static macro function forwardProperties(): Array<Field> {

        final fields = Context.getBuildFields();
        final pos = Context.currentPos();

        switch Context.getLocalClass().get().kind {
            case KAbstractImpl(_):
                // Expected, do nothing
            case _:
                Context.error("This build macro should only be used on abstracts", pos);
                return fields;
        }

        fields
            .map(f -> switch f.kind {
                // Future: Perhaps we could be using properties with custom access, like "auto"?
                // Variables were chosen simply because they are already illegal in abstracts
                case FVar(t, e):
                    {field: f, type: t, expr: e};
                case _:
                    null;
            })
            .filter(f -> f != null)
            .iter(entry -> {

                final field = entry.field;

                final haxeName = field.name;
                final nativeMeta = field.meta?.find(m -> m.name == ":native");
                final nativeName = if (nativeMeta != null) {
                    switch nativeMeta.params[0].expr {
                        case EConst(CString(name, _)):
                            name;
                        case _:
                            haxeName;
                    };
                } else {
                    haxeName;
                };

                field.kind = FProp("get", "set", entry.type, entry.expr);
                fields.push({
                    pos: field.pos,
                    name: 'get_${haxeName}',
                    access: [APrivate, AInline],
                    kind: FFun({
                        params: [],
                        args: [],
                        ret: entry.type,
                        expr: macro return untyped this.$nativeName,
                    }),
                });
                fields.push({
                    pos: field.pos,
                    name: 'set_${haxeName}',
                    access: [APrivate, AInline],
                    kind: FFun({
                        params: [],
                        args: [
                            {
                                name: "value",
                                type: entry.type,
                            }
                        ],
                        ret: entry.type,
                        expr: macro return untyped this.$nativeName = value,
                    }),
                });
            });

        return fields;
    }
}
