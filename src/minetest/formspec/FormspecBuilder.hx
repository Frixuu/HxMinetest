package minetest.formspec;

using minetest.formspec.UnitTools;

abstract class FormspecBuilder {
    public var version(default, null): Int;

    private var elements: Array<Element>;
    private var cachedString: Null<String>;

    private function new(version: Int) {
        this.elements = [];
        this.version = version;
        this.cachedString = null;
    }

    private function addElement(element: Element) {
        elements.push(element);
        this.cachedString = null;
    }

    /**
        @since Minetest 5.1.0
    **/
    public static function v2(): FormspecBuilderv2 {
        return new FormspecBuilderv2();
    }

    /**
        @since Minetest 5.2.0
    **/
    public static function v3(): FormspecBuilderv3 {
        return new FormspecBuilderv3();
    }

    /**
        @since Minetest 5.4.0
    **/
    public static function v4(): FormspecBuilderv4 {
        return new FormspecBuilderv4();
    }

    /**
        @since Minetest 5.5.0
    **/
    public static function v5(): FormspecBuilderv5 {
        return new FormspecBuilderv5();
    }

    /**
        @since Minetest 5.6.0
    **/
    public static function v6(): FormspecBuilderv6 {
        return new FormspecBuilderv6();
    }

    public function build(): String {
        return switch (this.cachedString) {
            case null:
                final stringBuf = new StringBuf();
                stringBuf.add("formspec_version[");
                stringBuf.add(this.version);
                stringBuf.add("]\n");
                for (element in elements) {
                    stringBuf.add(element.toString());
                    stringBuf.add("\n");
                }

                final result: String = stringBuf.toString();
                this.cachedString = result;
                result;
            case var cached:
                cached;
        }
    }
}
