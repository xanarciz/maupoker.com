// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package caurina.transitions.properties
{
	import com.script.poker.table.asset.InviteEnv;
	import flash.filters.ColorMatrixFilter;
	import caurina.transitions.*;
	import flash.geom.ColorTransform;
	public class ColorShortcuts
	{
		private static var LUMINANCE_B:Number = 0.072169;
		private static var LUMINANCE_G:Number = 0.71516;
		private static var LUMINANCE_R:Number = 0.212671;
		public function ColorShortcuts()
		{
		}
		public static function init():void
		{
			Tweener.registerSpecialProperty("_color_ra", _oldColor_property_get, _oldColor_property_set, ["redMultiplier"]);
			Tweener.registerSpecialProperty("_color_rb", _color_property_get, _color_property_set, ["redOffset"]);
			Tweener.registerSpecialProperty("_color_ga", _oldColor_property_get, _oldColor_property_set, ["greenMultiplier"]);
			Tweener.registerSpecialProperty("_color_gb", _color_property_get, _color_property_set, ["greenOffset"]);
			Tweener.registerSpecialProperty("_color_ba", _oldColor_property_get, _oldColor_property_set, ["blueMultiplier"]);
			Tweener.registerSpecialProperty("_color_bb", _color_property_get, _color_property_set, ["blueOffset"]);
			Tweener.registerSpecialProperty("_color_aa", _oldColor_property_get, _oldColor_property_set, ["alphaMultiplier"]);
			Tweener.registerSpecialProperty("_color_ab", _color_property_get, _color_property_set, ["alphaOffset"]);
			Tweener.registerSpecialProperty("_color_redMultiplier", _color_property_get, _color_property_set, ["redMultiplier"]);
			Tweener.registerSpecialProperty("_color_redOffset", _color_property_get, _color_property_set, ["redOffset"]);
			Tweener.registerSpecialProperty("_color_greenMultiplier", _color_property_get, _color_property_set, ["greenMultiplier"]);
			Tweener.registerSpecialProperty("_color_greenOffset", _color_property_get, _color_property_set, ["greenOffset"]);
			Tweener.registerSpecialProperty("_color_blueMultiplier", _color_property_get, _color_property_set, ["blueMultiplier"]);
			Tweener.registerSpecialProperty("_color_blueOffset", _color_property_get, _color_property_set, ["blueOffset"]);
			Tweener.registerSpecialProperty("_color_alphaMultiplier", _color_property_get, _color_property_set, ["alphaMultiplier"]);
			Tweener.registerSpecialProperty("_color_alphaOffset", _color_property_get, _color_property_set, ["alphaOffset"]);
			Tweener.registerSpecialPropertySplitter("_color", _color_splitter);
			Tweener.registerSpecialPropertySplitter("_colorTransform", _colorTransform_splitter);
			Tweener.registerSpecialProperty("_brightness", _brightness_get, _brightness_set, [false]);
			Tweener.registerSpecialProperty("_tintBrightness", _brightness_get, _brightness_set, [true]);
			Tweener.registerSpecialProperty("_contrast", _contrast_get, _contrast_set);
			Tweener.registerSpecialProperty("_hue", _hue_get, _hue_set);
			Tweener.registerSpecialProperty("_saturation", _saturation_get, _saturation_set, [false]);
			Tweener.registerSpecialProperty("_dumbSaturation", _saturation_get, _saturation_set, [true]);
		}
		public static function _color_splitter(p__1:*, p__2:Array):Array
		{
			var l__3:Array = new Array();
			if ((p__1) == null){
				l__3.push({name:"_color_redMultiplier", value:1});
				l__3.push({name:"_color_redOffset", value:0});
				l__3.push({name:"_color_greenMultiplier", value:1});
				l__3.push({name:"_color_greenOffset", value:0});
				l__3.push({name:"_color_blueMultiplier", value:1});
				l__3.push({name:"_color_blueOffset", value:0});
			} else {
				l__3.push({name:"_color_redMultiplier", value:0});
				l__3.push({name:"_color_redOffset", value:AuxFunctions.numberToR(p__1)});
				l__3.push({name:"_color_greenMultiplier", value:0});
				l__3.push({name:"_color_greenOffset", value:AuxFunctions.numberToG(p__1)});
				l__3.push({name:"_color_blueMultiplier", value:0});
				l__3.push({name:"_color_blueOffset", value:AuxFunctions.numberToB(p__1)});
			}
			return(l__3);
		}
		public static function _colorTransform_splitter(p__1:Object, p__2:Array):Array
		{
			var l__3:Array = new Array();
			if ((p__1) == null){
				l__3.push({name:"_color_redMultiplier", value:1});
				l__3.push({name:"_color_redOffset", value:0});
				l__3.push({name:"_color_greenMultiplier", value:1});
				l__3.push({name:"_color_greenOffset", value:0});
				l__3.push({name:"_color_blueMultiplier", value:1});
				l__3.push({name:"_color_blueOffset", value:0});
			} else {
				if ((p__1.ra) != undefined){
					l__3.push({name:"_color_ra", value:p__1.ra});
				}
				if ((p__1.rb) != undefined){
					l__3.push({name:"_color_rb", value:p__1.rb});
				}
				if ((p__1.ga) != undefined){
					l__3.push({name:"_color_ba", value:p__1.ba});
				}
				if ((p__1.gb) != undefined){
					l__3.push({name:"_color_bb", value:p__1.bb});
				}
				if ((p__1.ba) != undefined){
					l__3.push({name:"_color_ga", value:p__1.ga});
				}
				if ((p__1.bb) != undefined){
					l__3.push({name:"_color_gb", value:p__1.gb});
				}
				if ((p__1.aa) != undefined){
					l__3.push({name:"_color_aa", value:p__1.aa});
				}
				if ((p__1.ab) != undefined){
					l__3.push({name:"_color_ab", value:p__1.ab});
				}
				if ((p__1.redMultiplier) != undefined){
					l__3.push({name:"_color_redMultiplier", value:p__1.redMultiplier});
				}
				if ((p__1.redOffset) != undefined){
					l__3.push({name:"_color_redOffset", value:p__1.redOffset});
				}
				if ((p__1.blueMultiplier) != undefined){
					l__3.push({name:"_color_blueMultiplier", value:p__1.blueMultiplier});
				}
				if ((p__1.blueOffset) != undefined){
					l__3.push({name:"_color_blueOffset", value:p__1.blueOffset});
				}
				if ((p__1.greenMultiplier) != undefined){
					l__3.push({name:"_color_greenMultiplier", value:p__1.greenMultiplier});
				}
				if ((p__1.greenOffset) != undefined){
					l__3.push({name:"_color_greenOffset", value:p__1.greenOffset});
				}
				if ((p__1.alphaMultiplier) != undefined){
					l__3.push({name:"_color_alphaMultiplier", value:p__1.alphaMultiplier});
				}
				if ((p__1.alphaOffset) != undefined){
					l__3.push({name:"_color_alphaOffset", value:p__1.alphaOffset});
				}
			}
			return(l__3);
		}
		public static function _oldColor_property_get(p__1:Object, p__2:Array, p__3:Object = null):Number
		{
			return((p__1.transform.colorTransform[p__2[0]]) * 100);
		}
		public static function _oldColor_property_set(p__1:Object, p__2:Number, p__3:Array, p__4:Object = null):void
		{
			var l__5:flash.geom.ColorTransform = p__1.transform.colorTransform;
			l__5[p__3[0]] = (p__2) / 100;
			p__1.transform.colorTransform = l__5;
		}
		public static function _color_property_get(p__1:Object, p__2:Array, p__3:Object = null):Number
		{
			return(p__1.transform.colorTransform[p__2[0]]);
		}
		public static function _color_property_set(p__1:Object, p__2:Number, p__3:Array, p__4:Object = null):void
		{
			var l__5:flash.geom.ColorTransform = p__1.transform.colorTransform;
			l__5[p__3[0]] = p__2;
			p__1.transform.colorTransform = l__5;
		}
		public static function _brightness_get(p__1:Object, p__2:Array, p__3:Object = null):Number
		{
			var l__4:Boolean = p__2[0];
			var l__5:flash.geom.ColorTransform = p__1.transform.colorTransform;
			var l__6:Number = (1 - ((((l__5.redMultiplier + l__5.greenMultiplier) + l__5.blueMultiplier)) / 3));
			var l__7:Number = (((l__5.redOffset + l__5.greenOffset) + l__5.blueOffset)) / 3;
			if (l__4){
				return((l__7 > 0) ? (l__7 / 255) : (-l__6));
			} else {
				return(l__7 / 100);
			}
		}
		public static function _brightness_set(p__1:Object, p__2:Number, p__3:Array, p__4:Object = null):void
		{
			var l__6:Number;
			var l__7:Number;
			var l__5:Boolean = p__3[0];
			if (l__5){
				l__6 = (1 - Math.abs(p__2));
				l__7 = ((p__2) > 0) ? Math.round((p__2) * 255) : 0;
			} else {
				l__6 = 1;
				l__7 = Math.round((p__2) * 100);
			}
			var l__8:flash.geom.ColorTransform = new ColorTransform(l__6, l__6, l__6, 1, l__7, l__7, l__7, 0);
			p__1.transform.colorTransform = l__8;
		}
		public static function _saturation_get(p__1:Object, p__2:Array, p__3:Object = null):Number
		{
			var l__4:Array = getObjectMatrix(p__1);
			var l__5:Boolean = p__2[0];
			var l__6:Number = l__5 ? (1 / 3) : LUMINANCE_R;
			var l__7:Number = l__5 ? (1 / 3) : LUMINANCE_G;
			var l__8:Number = l__5 ? (1 / 3) : LUMINANCE_B;
			var l__9:Number = (((((l__4[0] - l__6)) / (((1 - l__6))) + (((l__4[6] - l__7)) / (((1 - l__7))))) + (((l__4[12] - l__8)) / (((1 - l__8)))))) / 3;
			var l__10:Number = (1 - (((((((l__4[1] / l__7 + (l__4[2] / l__8)) + (l__4[5] / l__6)) + (l__4[7] / l__8)) + (l__4[10] / l__6)) + (l__4[11] / l__7))) / 6));
			return((l__9 + l__10) / 2);
		}
		public static function _saturation_set(p__1:Object, p__2:Number, p__3:Array, p__4:Object = null):void
		{
			var l__5:Boolean = p__3[0];
			var l__6:Number = l__5 ? (1 / 3) : LUMINANCE_R;
			var l__7:Number = l__5 ? (1 / 3) : LUMINANCE_G;
			var l__8:Number = l__5 ? (1 / 3) : LUMINANCE_B;
			var l__9:Number = p__2;
			var l__10:Number = (1 - l__9);
			var l__11:Number = l__6 * l__10;
			var l__12:Number = l__7 * l__10;
			var l__13:Number = l__8 * l__10;
			var l__14:Array = [(l__11 + l__9), l__12, l__13, 0, 0, l__11, (l__12 + l__9), l__13, 0, 0, l__11, l__12, (l__13 + l__9), 0, 0, 0, 0, 0, 1, 0];
			setObjectMatrix(p__1, l__14);
		}
		public static function _contrast_get(p__1:Object, p__2:Array, p__3:Object = null):Number
		{
			var l__5:Number;
			var l__6:Number;
			var l__4:flash.geom.ColorTransform = p__1.transform.colorTransform;
			l__5 = (((l__4.redMultiplier + l__4.greenMultiplier) + l__4.blueMultiplier) / 3) - 1;
			l__6 = (((l__4.redOffset + l__4.greenOffset) + l__4.blueOffset) / 3) / -128;
			return((l__5 + l__6) / 2);
		}
		public static function _contrast_set(p__1:Object, p__2:Number, p__3:Array, p__4:Object = null):void
		{
			var l__5:Number;
			var l__6:Number;
			l__5 = (p__2 + 1);
			l__6 = Math.round((p__2) * -128);
			var l__7:flash.geom.ColorTransform = new ColorTransform(l__5, l__5, l__5, 1, l__6, l__6, l__6, 0);
			p__1.transform.colorTransform = l__7;
		}
		public static function _hue_get(p__1:Object, p__2:Array, p__3:Object = null):Number
		{
			var l__6:Number;
			var l__8:Number;
			var l__4:Array = getObjectMatrix(p__1);
			var l__5:Array = [];
			l__5[0] = {angle:-179.9, matrix:getHueMatrix(-179.9)};
			l__5[1] = {angle:180, matrix:getHueMatrix(180)};
			l__6 = 0;
			while(l__6 < l__5.length){
				l__5[l__6].distance = getHueDistance(l__4, l__5[l__6].matrix);
				l__6++;
			}
			var l__7:Number = 15;
			l__6 = 0;
			while(l__6 < l__7){
				if (l__5[0].distance < l__5[1].distance){
					l__8 = 1;
				} else {
					l__8 = 0;
				}
				l__5[l__8].angle = (l__5[0].angle + l__5[1].angle) / 2;
				l__5[l__8].matrix = getHueMatrix(l__5[l__8].angle);
				l__5[l__8].distance = getHueDistance(l__4, l__5[l__8].matrix);
				l__6++;
			}
			return(l__5[l__8].angle);
		}
		public static function _hue_set(p__1:Object, p__2:Number, p__3:Array, p__4:Object = null):void
		{
			setObjectMatrix(p__1, getHueMatrix(p__2));
		}
		public static function getHueDistance(p__1:Array, p__2:Array):Number
		{
			return((Math.abs(p__1[0] - p__2[0]) + Math.abs(p__1[1] - p__2[1])) + Math.abs(p__1[2] - p__2[2]));
		}
		public static function getHueMatrix(p__1:Number):Array
		{
			var l__2:Number = ((p__1) * Math.PI) / 180;
			var l__3:Number = LUMINANCE_R;
			var l__4:Number = LUMINANCE_G;
			var l__5:Number = LUMINANCE_B;
			var l__6:Number = Math.cos(l__2);
			var l__7:Number = Math.sin(l__2);
			var l__8:Array = [((l__3 + (l__6 * (((1 - l__3))))) + (l__7 * (-l__3))), ((l__4 + (l__6 * (-l__4))) + (l__7 * (-l__4))), ((l__5 + (l__6 * (-l__5))) + (l__7 * (((1 - l__5))))), 0, 0, ((l__3 + (l__6 * (-l__3))) + (l__7 * 0.143)), ((l__4 + (l__6 * (((1 - l__4))))) + (l__7 * 0.14)), ((l__5 + (l__6 * (-l__5))) + (l__7 * -0.283)), 0, 0, ((l__3 + (l__6 * (-l__3))) + (l__7 * -((1 - l__3)))), ((l__4 + (l__6 * (-l__4))) + (l__7 * l__4)), ((l__5 + (l__6 * (((1 - l__5))))) + (l__7 * l__5)), 0, 0, 0, 0, 0, 1, 0];
			return(l__8);
		}
		private static function getObjectMatrix(p__1:Object):Array
		{
			var l__2:Number;
			while(l__2 < (p__1.filters.length)){
				if ((p__1.filters[l__2]) is ColorMatrixFilter){
					return((p__1.filters[l__2].matrix).concat());
				}
				l__2++;
			}
			return([1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0]);
		}
		private static function setObjectMatrix(p__1:Object, p__2:Array):void
		{
			var l__6:flash.filters.ColorMatrixFilter;
			var l__3:Array = (p__1.filters).concat();
			var l__4:Boolean;
			var l__5:Number;
			while(l__5 < l__3.length){
				if (l__3[l__5] is ColorMatrixFilter){
					l__3[l__5].matrix = (p__2).concat();
					l__4 = true;
				}
				l__5++;
			}
			if (!l__4){
				l__6 = new ColorMatrixFilter(p__2);
				l__3[l__3.length] = l__6;
			}
			p__1.filters = l__3;
		}
	}
}