﻿// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package caurina.transitions.properties
{
	import flash.display.*;
	import com.script.poker.table.asset.Pot;
	import flash.filters.BitmapFilter;
	import flash.filters.BevelFilter;
	import flash.filters.BlurFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.ConvolutionFilter;
	import flash.filters.DisplacementMapFilter;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.filters.GradientBevelFilter;
	import flash.filters.GradientGlowFilter;
	import caurina.transitions.*;
	import flash.geom.*;
	public class FilterShortcuts
	{
		public function FilterShortcuts()
		{
		}
		public static function init():void
		{
			Tweener.registerSpecialPropertySplitter("_filter", _filter_splitter);
			Tweener.registerSpecialProperty("_Bevel_angle", _filter_property_get, _filter_property_set, [BevelFilter, "angle"]);
			Tweener.registerSpecialProperty("_Bevel_blurX", _filter_property_get, _filter_property_set, [BevelFilter, "blurX"]);
			Tweener.registerSpecialProperty("_Bevel_blurY", _filter_property_get, _filter_property_set, [BevelFilter, "blurY"]);
			Tweener.registerSpecialProperty("_Bevel_distance", _filter_property_get, _filter_property_set, [BevelFilter, "distance"]);
			Tweener.registerSpecialProperty("_Bevel_highlightAlpha", _filter_property_get, _filter_property_set, [BevelFilter, "highlightAlpha"]);
			Tweener.registerSpecialPropertySplitter("_Bevel_highlightColor", _generic_color_splitter, ["_Bevel_highlightColor_r", "_Bevel_highlightColor_g", "_Bevel_highlightColor_b"]);
			Tweener.registerSpecialProperty("_Bevel_highlightColor_r", _filter_property_get, _filter_property_set, [BevelFilter, "highlightColor", "color", "r"]);
			Tweener.registerSpecialProperty("_Bevel_highlightColor_g", _filter_property_get, _filter_property_set, [BevelFilter, "highlightColor", "color", "g"]);
			Tweener.registerSpecialProperty("_Bevel_highlightColor_b", _filter_property_get, _filter_property_set, [BevelFilter, "highlightColor", "color", "b"]);
			Tweener.registerSpecialProperty("_Bevel_knockout", _filter_property_get, _filter_property_set, [BevelFilter, "knockout"]);
			Tweener.registerSpecialProperty("_Bevel_quality", _filter_property_get, _filter_property_set, [BevelFilter, "quality"]);
			Tweener.registerSpecialProperty("_Bevel_shadowAlpha", _filter_property_get, _filter_property_set, [BevelFilter, "shadowAlpha"]);
			Tweener.registerSpecialPropertySplitter("_Bevel_shadowColor", _generic_color_splitter, ["_Bevel_shadowColor_r", "_Bevel_shadowColor_g", "_Bevel_shadowColor_b"]);
			Tweener.registerSpecialProperty("_Bevel_shadowColor_r", _filter_property_get, _filter_property_set, [BevelFilter, "shadowColor", "color", "r"]);
			Tweener.registerSpecialProperty("_Bevel_shadowColor_g", _filter_property_get, _filter_property_set, [BevelFilter, "shadowColor", "color", "g"]);
			Tweener.registerSpecialProperty("_Bevel_shadowColor_b", _filter_property_get, _filter_property_set, [BevelFilter, "shadowColor", "color", "b"]);
			Tweener.registerSpecialProperty("_Bevel_strength", _filter_property_get, _filter_property_set, [BevelFilter, "strength"]);
			Tweener.registerSpecialProperty("_Bevel_type", _filter_property_get, _filter_property_set, [BevelFilter, "type"]);
			Tweener.registerSpecialProperty("_Blur_blurX", _filter_property_get, _filter_property_set, [BlurFilter, "blurX"]);
			Tweener.registerSpecialProperty("_Blur_blurY", _filter_property_get, _filter_property_set, [BlurFilter, "blurY"]);
			Tweener.registerSpecialProperty("_Blur_quality", _filter_property_get, _filter_property_set, [BlurFilter, "quality"]);
			Tweener.registerSpecialPropertySplitter("_ColorMatrix_matrix", _generic_matrix_splitter, [[1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0], ["_ColorMatrix_matrix_rr", "_ColorMatrix_matrix_rg", "_ColorMatrix_matrix_rb", "_ColorMatrix_matrix_ra", "_ColorMatrix_matrix_ro", "_ColorMatrix_matrix_gr", "_ColorMatrix_matrix_gg", "_ColorMatrix_matrix_gb", "_ColorMatrix_matrix_ga", "_ColorMatrix_matrix_go", "_ColorMatrix_matrix_br", "_ColorMatrix_matrix_bg", "_ColorMatrix_matrix_bb", "_ColorMatrix_matrix_ba", "_ColorMatrix_matrix_bo", "_ColorMatrix_matrix_ar", "_ColorMatrix_matrix_ag", "_ColorMatrix_matrix_ab", "_ColorMatrix_matrix_aa", "_ColorMatrix_matrix_ao"]]);
			Tweener.registerSpecialProperty("_ColorMatrix_matrix_rr", _filter_property_get, _filter_property_set, [ColorMatrixFilter, "matrix", "matrix", 0]);
			Tweener.registerSpecialProperty("_ColorMatrix_matrix_rg", _filter_property_get, _filter_property_set, [ColorMatrixFilter, "matrix", "matrix", 1]);
			Tweener.registerSpecialProperty("_ColorMatrix_matrix_rb", _filter_property_get, _filter_property_set, [ColorMatrixFilter, "matrix", "matrix", 2]);
			Tweener.registerSpecialProperty("_ColorMatrix_matrix_ra", _filter_property_get, _filter_property_set, [ColorMatrixFilter, "matrix", "matrix", 3]);
			Tweener.registerSpecialProperty("_ColorMatrix_matrix_ro", _filter_property_get, _filter_property_set, [ColorMatrixFilter, "matrix", "matrix", 4]);
			Tweener.registerSpecialProperty("_ColorMatrix_matrix_gr", _filter_property_get, _filter_property_set, [ColorMatrixFilter, "matrix", "matrix", 5]);
			Tweener.registerSpecialProperty("_ColorMatrix_matrix_gg", _filter_property_get, _filter_property_set, [ColorMatrixFilter, "matrix", "matrix", 6]);
			Tweener.registerSpecialProperty("_ColorMatrix_matrix_gb", _filter_property_get, _filter_property_set, [ColorMatrixFilter, "matrix", "matrix", 7]);
			Tweener.registerSpecialProperty("_ColorMatrix_matrix_ga", _filter_property_get, _filter_property_set, [ColorMatrixFilter, "matrix", "matrix", 8]);
			Tweener.registerSpecialProperty("_ColorMatrix_matrix_go", _filter_property_get, _filter_property_set, [ColorMatrixFilter, "matrix", "matrix", 9]);
			Tweener.registerSpecialProperty("_ColorMatrix_matrix_br", _filter_property_get, _filter_property_set, [ColorMatrixFilter, "matrix", "matrix", 10]);
			Tweener.registerSpecialProperty("_ColorMatrix_matrix_bg", _filter_property_get, _filter_property_set, [ColorMatrixFilter, "matrix", "matrix", 11]);
			Tweener.registerSpecialProperty("_ColorMatrix_matrix_bb", _filter_property_get, _filter_property_set, [ColorMatrixFilter, "matrix", "matrix", 12]);
			Tweener.registerSpecialProperty("_ColorMatrix_matrix_ba", _filter_property_get, _filter_property_set, [ColorMatrixFilter, "matrix", "matrix", 13]);
			Tweener.registerSpecialProperty("_ColorMatrix_matrix_bo", _filter_property_get, _filter_property_set, [ColorMatrixFilter, "matrix", "matrix", 14]);
			Tweener.registerSpecialProperty("_ColorMatrix_matrix_ar", _filter_property_get, _filter_property_set, [ColorMatrixFilter, "matrix", "matrix", 15]);
			Tweener.registerSpecialProperty("_ColorMatrix_matrix_ag", _filter_property_get, _filter_property_set, [ColorMatrixFilter, "matrix", "matrix", 16]);
			Tweener.registerSpecialProperty("_ColorMatrix_matrix_ab", _filter_property_get, _filter_property_set, [ColorMatrixFilter, "matrix", "matrix", 17]);
			Tweener.registerSpecialProperty("_ColorMatrix_matrix_aa", _filter_property_get, _filter_property_set, [ColorMatrixFilter, "matrix", "matrix", 18]);
			Tweener.registerSpecialProperty("_ColorMatrix_matrix_ao", _filter_property_get, _filter_property_set, [ColorMatrixFilter, "matrix", "matrix", 19]);
			Tweener.registerSpecialProperty("_Convolution_alpha", _filter_property_get, _filter_property_set, [ConvolutionFilter, "alpha"]);
			Tweener.registerSpecialProperty("_Convolution_bias", _filter_property_get, _filter_property_set, [ConvolutionFilter, "bias"]);
			Tweener.registerSpecialProperty("_Convolution_clamp", _filter_property_get, _filter_property_set, [ConvolutionFilter, "clamp"]);
			Tweener.registerSpecialPropertySplitter("_Convolution_color", _generic_color_splitter, ["_Convolution_color_r", "_Convolution_color_g", "_Convolution_color_b"]);
			Tweener.registerSpecialProperty("_Convolution_color_r", _filter_property_get, _filter_property_set, [ConvolutionFilter, "color", "color", "r"]);
			Tweener.registerSpecialProperty("_Convolution_color_g", _filter_property_get, _filter_property_set, [ConvolutionFilter, "color", "color", "g"]);
			Tweener.registerSpecialProperty("_Convolution_color_b", _filter_property_get, _filter_property_set, [ConvolutionFilter, "color", "color", "b"]);
			Tweener.registerSpecialProperty("_Convolution_divisor", _filter_property_get, _filter_property_set, [ConvolutionFilter, "divisor"]);
			Tweener.registerSpecialProperty("_Convolution_matrixX", _filter_property_get, _filter_property_set, [ConvolutionFilter, "matrixX"]);
			Tweener.registerSpecialProperty("_Convolution_matrixY", _filter_property_get, _filter_property_set, [ConvolutionFilter, "matrixY"]);
			Tweener.registerSpecialProperty("_Convolution_preserveAlpha", _filter_property_get, _filter_property_set, [ConvolutionFilter, "preserveAlpha"]);
			Tweener.registerSpecialProperty("_DisplacementMap_alpha", _filter_property_get, _filter_property_set, [DisplacementMapFilter, "alpha"]);
			Tweener.registerSpecialPropertySplitter("_DisplacementMap_color", _generic_color_splitter, ["_DisplacementMap_color_r", "_DisplacementMap_color_r", "_DisplacementMap_color_r"]);
			Tweener.registerSpecialProperty("_DisplacementMap_color_r", _filter_property_get, _filter_property_set, [DisplacementMapFilter, "color", "color", "r"]);
			Tweener.registerSpecialProperty("_DisplacementMap_color_g", _filter_property_get, _filter_property_set, [DisplacementMapFilter, "color", "color", "g"]);
			Tweener.registerSpecialProperty("_DisplacementMap_color_b", _filter_property_get, _filter_property_set, [DisplacementMapFilter, "color", "color", "b"]);
			Tweener.registerSpecialProperty("_DisplacementMap_componentX", _filter_property_get, _filter_property_set, [DisplacementMapFilter, "componentX"]);
			Tweener.registerSpecialProperty("_DisplacementMap_componentY", _filter_property_get, _filter_property_set, [DisplacementMapFilter, "componentY"]);
			Tweener.registerSpecialProperty("_DisplacementMap_mapBitmap", _filter_property_get, _filter_property_set, [DisplacementMapFilter, "mapBitmap"]);
			Tweener.registerSpecialProperty("_DisplacementMap_mapPoint", _filter_property_get, _filter_property_set, [DisplacementMapFilter, "mapPoint"]);
			Tweener.registerSpecialProperty("_DisplacementMap_mode", _filter_property_get, _filter_property_set, [DisplacementMapFilter, "mode"]);
			Tweener.registerSpecialProperty("_DisplacementMap_scaleX", _filter_property_get, _filter_property_set, [DisplacementMapFilter, "scaleX"]);
			Tweener.registerSpecialProperty("_DisplacementMap_scaleY", _filter_property_get, _filter_property_set, [DisplacementMapFilter, "scaleY"]);
			Tweener.registerSpecialProperty("_DropShadow_alpha", _filter_property_get, _filter_property_set, [DropShadowFilter, "alpha"]);
			Tweener.registerSpecialProperty("_DropShadow_angle", _filter_property_get, _filter_property_set, [DropShadowFilter, "angle"]);
			Tweener.registerSpecialProperty("_DropShadow_blurX", _filter_property_get, _filter_property_set, [DropShadowFilter, "blurX"]);
			Tweener.registerSpecialProperty("_DropShadow_blurY", _filter_property_get, _filter_property_set, [DropShadowFilter, "blurY"]);
			Tweener.registerSpecialPropertySplitter("_DropShadow_color", _generic_color_splitter, ["_DropShadow_color_r", "_DropShadow_color_g", "_DropShadow_color_b"]);
			Tweener.registerSpecialProperty("_DropShadow_color_r", _filter_property_get, _filter_property_set, [DropShadowFilter, "color", "color", "r"]);
			Tweener.registerSpecialProperty("_DropShadow_color_g", _filter_property_get, _filter_property_set, [DropShadowFilter, "color", "color", "g"]);
			Tweener.registerSpecialProperty("_DropShadow_color_b", _filter_property_get, _filter_property_set, [DropShadowFilter, "color", "color", "b"]);
			Tweener.registerSpecialProperty("_DropShadow_distance", _filter_property_get, _filter_property_set, [DropShadowFilter, "distance"]);
			Tweener.registerSpecialProperty("_DropShadow_hideObject", _filter_property_get, _filter_property_set, [DropShadowFilter, "hideObject"]);
			Tweener.registerSpecialProperty("_DropShadow_inner", _filter_property_get, _filter_property_set, [DropShadowFilter, "inner"]);
			Tweener.registerSpecialProperty("_DropShadow_knockout", _filter_property_get, _filter_property_set, [DropShadowFilter, "knockout"]);
			Tweener.registerSpecialProperty("_DropShadow_quality", _filter_property_get, _filter_property_set, [DropShadowFilter, "quality"]);
			Tweener.registerSpecialProperty("_DropShadow_strength", _filter_property_get, _filter_property_set, [DropShadowFilter, "strength"]);
			Tweener.registerSpecialProperty("_Glow_alpha", _filter_property_get, _filter_property_set, [GlowFilter, "alpha"]);
			Tweener.registerSpecialProperty("_Glow_blurX", _filter_property_get, _filter_property_set, [GlowFilter, "blurX"]);
			Tweener.registerSpecialProperty("_Glow_blurY", _filter_property_get, _filter_property_set, [GlowFilter, "blurY"]);
			Tweener.registerSpecialPropertySplitter("_Glow_color", _generic_color_splitter, ["_Glow_color_r", "_Glow_color_g", "_Glow_color_b"]);
			Tweener.registerSpecialProperty("_Glow_color_r", _filter_property_get, _filter_property_set, [GlowFilter, "color", "color", "r"]);
			Tweener.registerSpecialProperty("_Glow_color_g", _filter_property_get, _filter_property_set, [GlowFilter, "color", "color", "g"]);
			Tweener.registerSpecialProperty("_Glow_color_b", _filter_property_get, _filter_property_set, [GlowFilter, "color", "color", "b"]);
			Tweener.registerSpecialProperty("_Glow_inner", _filter_property_get, _filter_property_set, [GlowFilter, "inner"]);
			Tweener.registerSpecialProperty("_Glow_knockout", _filter_property_get, _filter_property_set, [GlowFilter, "knockout"]);
			Tweener.registerSpecialProperty("_Glow_quality", _filter_property_get, _filter_property_set, [GlowFilter, "quality"]);
			Tweener.registerSpecialProperty("_Glow_strength", _filter_property_get, _filter_property_set, [GlowFilter, "strength"]);
			Tweener.registerSpecialProperty("_GradientBevel_angle", _filter_property_get, _filter_property_set, [GradientBevelFilter, "angle"]);
			Tweener.registerSpecialProperty("_GradientBevel_blurX", _filter_property_get, _filter_property_set, [GradientBevelFilter, "blurX"]);
			Tweener.registerSpecialProperty("_GradientBevel_blurY", _filter_property_get, _filter_property_set, [GradientBevelFilter, "blurY"]);
			Tweener.registerSpecialProperty("_GradientBevel_distance", _filter_property_get, _filter_property_set, [GradientBevelFilter, "distance"]);
			Tweener.registerSpecialProperty("_GradientBevel_quality", _filter_property_get, _filter_property_set, [GradientBevelFilter, "quality"]);
			Tweener.registerSpecialProperty("_GradientBevel_strength", _filter_property_get, _filter_property_set, [GradientBevelFilter, "strength"]);
			Tweener.registerSpecialProperty("_GradientBevel_type", _filter_property_get, _filter_property_set, [GradientBevelFilter, "type"]);
			Tweener.registerSpecialProperty("_GradientGlow_angle", _filter_property_get, _filter_property_set, [GradientGlowFilter, "angle"]);
			Tweener.registerSpecialProperty("_GradientGlow_blurX", _filter_property_get, _filter_property_set, [GradientGlowFilter, "blurX"]);
			Tweener.registerSpecialProperty("_GradientGlow_blurY", _filter_property_get, _filter_property_set, [GradientGlowFilter, "blurY"]);
			Tweener.registerSpecialProperty("_GradientGlow_distance", _filter_property_get, _filter_property_set, [GradientGlowFilter, "distance"]);
			Tweener.registerSpecialProperty("_GradientGlow_knockout", _filter_property_get, _filter_property_set, [GradientGlowFilter, "knockout"]);
			Tweener.registerSpecialProperty("_GradientGlow_quality", _filter_property_get, _filter_property_set, [GradientGlowFilter, "quality"]);
			Tweener.registerSpecialProperty("_GradientGlow_strength", _filter_property_get, _filter_property_set, [GradientGlowFilter, "strength"]);
			Tweener.registerSpecialProperty("_GradientGlow_type", _filter_property_get, _filter_property_set, [GradientGlowFilter, "type"]);
		}
		public static function _generic_color_splitter(p__1:Number, p__2:Array):Array
		{
			var l__3:Array = new Array();
			l__3.push({name:p__2[0], value:AuxFunctions.numberToR(p__1)});
			l__3.push({name:p__2[1], value:AuxFunctions.numberToG(p__1)});
			l__3.push({name:p__2[2], value:AuxFunctions.numberToB(p__1)});
			return(l__3);
		}
		public static function _generic_matrix_splitter(p__1:Array, p__2:Array):Array
		{
			if ((p__1) == null){
				p__1 = (p__2[0]).concat();
			}
			var l__3:Array = new Array();
			var l__4:Number;
			while(l__4 < (p__1.length)){
				l__3.push({name:p__2[1][l__4], value:p__1[l__4]});
				l__4++;
			}
			return(l__3);
		}
		public static function _filter_splitter(p__1:flash.filters.BitmapFilter, p__2:Array, p__3:Object = null):Array
		{
			var l__4:Array = new Array();
			if ((p__1) is BevelFilter){
				l__4.push({name:"_Bevel_angle", value:BevelFilter(p__1).angle});
				l__4.push({name:"_Bevel_blurX", value:BevelFilter(p__1).blurX});
				l__4.push({name:"_Bevel_blurY", value:BevelFilter(p__1).blurY});
				l__4.push({name:"_Bevel_distance", value:BevelFilter(p__1).distance});
				l__4.push({name:"_Bevel_highlightAlpha", value:BevelFilter(p__1).highlightAlpha});
				l__4.push({name:"_Bevel_highlightColor", value:BevelFilter(p__1).highlightColor});
				l__4.push({name:"_Bevel_knockout", value:BevelFilter(p__1).knockout});
				l__4.push({name:"_Bevel_quality", value:BevelFilter(p__1).quality});
				l__4.push({name:"_Bevel_shadowAlpha", value:BevelFilter(p__1).shadowAlpha});
				l__4.push({name:"_Bevel_shadowColor", value:BevelFilter(p__1).shadowColor});
				l__4.push({name:"_Bevel_strength", value:BevelFilter(p__1).strength});
				l__4.push({name:"_Bevel_type", value:BevelFilter(p__1).type});
			} else if ((p__1) is BlurFilter){
				l__4.push({name:"_Blur_blurX", value:BlurFilter(p__1).blurX});
				l__4.push({name:"_Blur_blurY", value:BlurFilter(p__1).blurY});
				l__4.push({name:"_Blur_quality", value:BlurFilter(p__1).quality});
			} else if ((p__1) is ColorMatrixFilter){
				l__4.push({name:"_ColorMatrix_matrix", value:ColorMatrixFilter(p__1).matrix});
			} else if ((p__1) is ConvolutionFilter){
				l__4.push({name:"_Convolution_alpha", value:ConvolutionFilter(p__1).alpha});
				l__4.push({name:"_Convolution_bias", value:ConvolutionFilter(p__1).bias});
				l__4.push({name:"_Convolution_clamp", value:ConvolutionFilter(p__1).clamp});
				l__4.push({name:"_Convolution_color", value:ConvolutionFilter(p__1).color});
				l__4.push({name:"_Convolution_divisor", value:ConvolutionFilter(p__1).divisor});
				l__4.push({name:"_Convolution_matrixX", value:ConvolutionFilter(p__1).matrixX});
				l__4.push({name:"_Convolution_matrixY", value:ConvolutionFilter(p__1).matrixY});
				l__4.push({name:"_Convolution_preserveAlpha", value:ConvolutionFilter(p__1).preserveAlpha});
			} else if ((p__1) is DisplacementMapFilter){
				l__4.push({name:"_DisplacementMap_alpha", value:DisplacementMapFilter(p__1).alpha});
				l__4.push({name:"_DisplacementMap_color", value:DisplacementMapFilter(p__1).color});
				l__4.push({name:"_DisplacementMap_componentX", value:DisplacementMapFilter(p__1).componentX});
				l__4.push({name:"_DisplacementMap_componentY", value:DisplacementMapFilter(p__1).componentY});
				l__4.push({name:"_DisplacementMap_mapBitmap", value:DisplacementMapFilter(p__1).mapBitmap});
				l__4.push({name:"_DisplacementMap_mapPoint", value:DisplacementMapFilter(p__1).mapPoint});
				l__4.push({name:"_DisplacementMap_mode", value:DisplacementMapFilter(p__1).mode});
				l__4.push({name:"_DisplacementMap_scaleX", value:DisplacementMapFilter(p__1).scaleX});
				l__4.push({name:"_DisplacementMap_scaleY", value:DisplacementMapFilter(p__1).scaleY});
			} else if ((p__1) is DropShadowFilter){
				l__4.push({name:"_DropShadow_alpha", value:DropShadowFilter(p__1).alpha});
				l__4.push({name:"_DropShadow_angle", value:DropShadowFilter(p__1).angle});
				l__4.push({name:"_DropShadow_blurX", value:DropShadowFilter(p__1).blurX});
				l__4.push({name:"_DropShadow_blurY", value:DropShadowFilter(p__1).blurY});
				l__4.push({name:"_DropShadow_color", value:DropShadowFilter(p__1).color});
				l__4.push({name:"_DropShadow_distance", value:DropShadowFilter(p__1).distance});
				l__4.push({name:"_DropShadow_hideObject", value:DropShadowFilter(p__1).hideObject});
				l__4.push({name:"_DropShadow_inner", value:DropShadowFilter(p__1).inner});
				l__4.push({name:"_DropShadow_knockout", value:DropShadowFilter(p__1).knockout});
				l__4.push({name:"_DropShadow_quality", value:DropShadowFilter(p__1).quality});
				l__4.push({name:"_DropShadow_strength", value:DropShadowFilter(p__1).strength});
			} else if ((p__1) is GlowFilter){
				l__4.push({name:"_Glow_alpha", value:GlowFilter(p__1).alpha});
				l__4.push({name:"_Glow_blurX", value:GlowFilter(p__1).blurX});
				l__4.push({name:"_Glow_blurY", value:GlowFilter(p__1).blurY});
				l__4.push({name:"_Glow_color", value:GlowFilter(p__1).color});
				l__4.push({name:"_Glow_inner", value:GlowFilter(p__1).inner});
				l__4.push({name:"_Glow_knockout", value:GlowFilter(p__1).knockout});
				l__4.push({name:"_Glow_quality", value:GlowFilter(p__1).quality});
				l__4.push({name:"_Glow_strength", value:GlowFilter(p__1).strength});
			} else if ((p__1) is GradientBevelFilter){
				l__4.push({name:"_GradientBevel_angle", value:GradientBevelFilter(p__1).strength});
				l__4.push({name:"_GradientBevel_blurX", value:GradientBevelFilter(p__1).blurX});
				l__4.push({name:"_GradientBevel_blurY", value:GradientBevelFilter(p__1).blurY});
				l__4.push({name:"_GradientBevel_distance", value:GradientBevelFilter(p__1).distance});
				l__4.push({name:"_GradientBevel_quality", value:GradientBevelFilter(p__1).quality});
				l__4.push({name:"_GradientBevel_strength", value:GradientBevelFilter(p__1).strength});
				l__4.push({name:"_GradientBevel_type", value:GradientBevelFilter(p__1).type});
			} else if ((p__1) is GradientGlowFilter){
				l__4.push({name:"_GradientGlow_angle", value:GradientGlowFilter(p__1).strength});
				l__4.push({name:"_GradientGlow_blurX", value:GradientGlowFilter(p__1).blurX});
				l__4.push({name:"_GradientGlow_blurY", value:GradientGlowFilter(p__1).blurY});
				l__4.push({name:"_GradientGlow_distance", value:GradientGlowFilter(p__1).distance});
				l__4.push({name:"_GradientGlow_knockout", value:GradientGlowFilter(p__1).knockout});
				l__4.push({name:"_GradientGlow_quality", value:GradientGlowFilter(p__1).quality});
				l__4.push({name:"_GradientGlow_strength", value:GradientGlowFilter(p__1).strength});
				l__4.push({name:"_GradientGlow_type", value:GradientGlowFilter(p__1).type});
			} else {
			}
			return(l__4);
		}
		public static function _filter_property_get(p__1:Object, p__2:Array, p__3:Object = null):Number
		{
			var l__5:Number;
			var l__9:Object;
			var l__10:String;
			var l__4:Array = p__1.filters;
			var l__6:Object = p__2[0];
			var l__7:String = p__2[1];
			var l__8:String = p__2[2];
			l__5 = 0;
			while(l__5 < l__4.length){
				if (l__4[l__5] is Class(l__6)){
					if (l__8 == "color"){
						l__10 = p__2[3];
						if (l__10 == "r"){
							return(AuxFunctions.numberToR(l__4[l__5][l__7]));
						}
						if (l__10 == "g"){
							return(AuxFunctions.numberToG(l__4[l__5][l__7]));
						}
						if (l__10 == "b"){
							return(AuxFunctions.numberToB(l__4[l__5][l__7]));
						}
					} else {
						if (l__8 == "matrix"){
							return(l__4[l__5][l__7][p__2[3]]);
						}
						return(l__4[l__5][l__7]);
					}
				}
				l__5++;
			}
			switch(l__6){
				case BevelFilter:
				{
					l__9 = {angle:NaN, blurX:0, blurY:0, distance:0, highlightAlpha:1, highlightColor:NaN, knockout:null, quality:NaN, shadowAlpha:1, shadowColor:NaN, strength:2, type:null};
					break;
				}
				case BlurFilter:
				{
					l__9 = {blurX:0, blurY:0, quality:NaN};
					break;
				}
				case ColorMatrixFilter:
				{
					l__9 = {matrix:[1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0]};
					break;
				}
				case ConvolutionFilter:
				{
					l__9 = {alpha:0, bias:0, clamp:null, color:NaN, divisor:1, matrix:[1], matrixX:1, matrixY:1, preserveAlpha:null};
					break;
				}
				case DisplacementMapFilter:
				{
					l__9 = {alpha:0, color:NaN, componentX:null, componentY:null, mapBitmap:null, mapPoint:null, mode:null, scaleX:0, scaleY:0};
					break;
				}
				case DropShadowFilter:
				{
					l__9 = {distance:0, angle:NaN, color:NaN, alpha:1, blurX:0, blurY:0, strength:1, quality:NaN, inner:null, knockout:null, hideObject:null};
					break;
				}
				case GlowFilter:
				{
					l__9 = {alpha:1, blurX:0, blurY:0, color:NaN, inner:null, knockout:null, quality:NaN, strength:2};
					break;
				}
				case GradientBevelFilter:
				{
					l__9 = {alphas:null, angle:NaN, blurX:0, blurY:0, colors:null, distance:0, knockout:null, quality:NaN, ratios:NaN, strength:1, type:null};
					break;
				}
				case GradientGlowFilter:
				{
					l__9 = {alphas:null, angle:NaN, blurX:0, blurY:0, colors:null, distance:0, knockout:null, quality:NaN, ratios:NaN, strength:1, type:null};
					break;
				}
			}
			if (l__8 == "color"){
				return(NaN);
			}
			if (l__8 == "matrix"){
				return(l__9[l__7][p__2[3]]);
			}
			return(l__9[l__7]);
		}
		public static function _filter_property_set(p__1:Object, p__2:Number, p__3:Array, p__4:Object = null):void
		{
			var l__6:Number;
			var l__10:flash.filters.BitmapFilter;
			var l__11:String;
			var l__12:Array;
			var l__5:Array = p__1.filters;
			var l__7:Object = p__3[0];
			var l__8:String = p__3[1];
			var l__9:String = p__3[2];
			l__6 = 0;
			while(l__6 < l__5.length){
				if (l__5[l__6] is Class(l__7)){
					if (l__9 == "color"){
						l__11 = p__3[3];
						if (l__11 == "r"){
							l__5[l__6][l__8] = ((l__5[l__6][l__8] & 65535) | ((((p__2) << 16))));
						}
						if (l__11 == "g"){
							l__5[l__6][l__8] = ((l__5[l__6][l__8] & 16711935) | ((((p__2) << 8))));
						}
						if (l__11 == "b"){
							l__5[l__6][l__8] = ((l__5[l__6][l__8] & 16776960) | (p__2));
						}
					} else if (l__9 == "matrix"){
						l__12 = l__5[l__6][l__8];
						l__12[p__3[3]] = p__2;
						l__5[l__6][l__8] = l__12;
					} else {
						l__5[l__6][l__8] = p__2;
					}
					p__1.filters = l__5;
					return;
				}
				l__6++;
			}
			if (l__5 == null){
				l__5 = new Array();
			}
			switch(l__7){
				case BevelFilter:
				{
					l__10 = new BevelFilter(0, 45, 16777215, 1, 0, 1, 0, 0);
					break;
				}
				case BlurFilter:
				{
					l__10 = new BlurFilter(0, 0);
					break;
				}
				case ColorMatrixFilter:
				{
					l__10 = new ColorMatrixFilter([1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0]);
					break;
				}
				case ConvolutionFilter:
				{
					l__10 = new ConvolutionFilter(1, 1, [1], 1, 0, true, true, 0, 0);
					break;
				}
				case DisplacementMapFilter:
				{
					l__10 = new DisplacementMapFilter(new BitmapData(10, 10), new Point(0, 0), 0, 1, 0, 0);
					break;
				}
				case DropShadowFilter:
				{
					l__10 = new DropShadowFilter(0, 45, 0, 1, 0, 0);
					break;
				}
				case GlowFilter:
				{
					l__10 = new GlowFilter(16711680, 1, 0, 0);
					break;
				}
				case GradientBevelFilter:
				{
					l__10 = new GradientBevelFilter(0, 45, [16777215, 0], [1, 1], [32, 223], 0, 0);
					break;
				}
				case GradientGlowFilter:
				{
					l__10 = new GradientGlowFilter(0, 45, [16777215, 0], [1, 1], [32, 223], 0, 0);
					break;
				}
			}
			l__5.push(l__10);
			p__1.filters = l__5;
			_filter_property_set(p__1, p__2, p__3);
		}
	}
}