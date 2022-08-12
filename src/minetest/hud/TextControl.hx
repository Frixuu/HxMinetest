package minetest.hud;

import minetest.colors.Color;

class TextControl extends Control {
    private var _color: Null<Color> = null;
    private var _position: {x: Float, y: Float} = {x: 0.0, y: 0.0};
    private var _scale: {x: Int, y: Int} = {x: 100, y: 100};
    private var _offset: {x: Int, y: Int} = {x: 100, y: 100};
    private var _alignment: {x: Float, y: Float} = {x: 0.0, y: 0.0};
    private var _text: String;
    private var _fontSizeMultiplier: Int = 1;

    public function new(?text: String) {
        this._text = text;
    }

    public inline function text(t: String): TextControl {
        this._text = t;
        return this;
    }

    public inline function color(c: Color): TextControl {
        this._color = c;
        return this;
    }

    public inline function position(x: Float, y: Float): TextControl {
        this._position = {x: x, y: y};
        return this;
    }

    public inline function offset(x: Int, y: Int): TextControl {
        this._offset = {x: x, y: y};
        return this;
    }

    public inline function alignment(x: Float, y: Float): TextControl {
        this._alignment = {x: x, y: y};
        return this;
    }

    public inline function size(x: Int, y: Int): TextControl {
        this._scale = {x: x, y: y};
        return this;
    }

    public inline function fontSizeScale(multiplier: Int): TextControl {
        this._fontSizeMultiplier = multiplier;
        return this;
    }

    public function buildNativeDefinition(): HudDefinition {
        final def: HudDefinition = {hud_elem_type: Text};
        def.position = this._position;
        def.offset = this._offset;
        def.text = this._text;
        def.alignment = this._alignment;
        def.scale = this._scale;
        if (this._zIndex != 0) {
            def.z_index = this._zIndex;
        }
        if (this._fontSizeMultiplier != 1) {
            def.size = {x: this._fontSizeMultiplier, y: 0};
        }
        if (this._color != null) {
            def.number = this._color.toIntRgb();
        }
        return def;
    }
}
