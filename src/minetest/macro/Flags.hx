// SPDX-License-Identifier: Zlib
package minetest.macro;

#if macro
import haxe.macro.Expr;
import haxe.macro.Expr.ComplexType;
import haxe.macro.Context;
#end

final class Flags {
    public static macro function addOperators(): Array<Field> {

        var pack: Array<String> = [];
        var name: String = "";

        final fields = Context.getBuildFields();
        final pos = Context.currentPos();
        final classType = Context.getLocalClass().get();
        switch classType.kind {
            case KAbstractImpl(at):
                final abstractType = at.get();
                pack = abstractType.pack;
                name = abstractType.name;
            case _:
                Context.error("This build macro should only be used on abstracts", pos);
                return fields;
        }

        final typeAbstract: ComplexType = TPath({pack: pack, name: name});
        final typeStringForm: ComplexType = TPath({
            pack: ["minetest"],
            name: "Flags",
            sub: "StringForm",
            params: [TPType(typeAbstract)],
        });

        fields.push({
            pos: pos,
            name: "union",
            meta: [
                {
                    pos: pos,
                    name: ":op",
                    params: [
                        {
                            pos: pos,
                            expr: EBinop(OpOr, (macro $i{"A"}), (macro $i{"B"})),
                        }
                    ]
                }
            ],
            access: [APublic, AStatic, AInline],
            kind: FFun({
                params: [],
                args: [
                    {
                        name: "a",
                        type: typeAbstract,
                    },
                    {
                        name: "b",
                        type: typeAbstract,
                    }
                ],
                ret: typeStringForm,
                expr: macro return a + ", " + b,
            }),
        });

        fields.push({
            pos: pos,
            name: "negate",
            meta: [
                {
                    pos: pos,
                    name: ":op",
                    params: [
                        {
                            pos: pos,
                            expr: EUnop(OpNegBits, false, (macro $i{"A"})),
                        }
                    ]
                }
            ],
            access: [APublic, AStatic, AInline],
            kind: FFun({
                params: [],
                args: [
                    {
                        name: "a",
                        type: typeAbstract,
                    }
                ],
                ret: typeStringForm,
                expr: macro return "no" + a,
            }),
        });

        return fields;
    }
}
