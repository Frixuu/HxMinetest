package minetest.formspec.element;

interface FormspecElement {
    public function intoFormspecString(sb: StringBuf): Void;
}
