// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table.asset
{
	import flash.display.*;
	import flash.events.*;
	public class FaceArt extends flash.display.MovieClip
	{
		public var rK:flash.display.MovieClip;
		public var bJ:flash.display.MovieClip;
		public var bK:flash.display.MovieClip;
		public var bQ:flash.display.MovieClip;
		public var rJ:flash.display.MovieClip;
		public var rQ:flash.display.MovieClip;
		public function FaceArt()
		{
			hideAll();
		}
		public function showFace(p__1:Number, p__2:String)
		{
			rJ.visible = false;
			rQ.visible = false;
			rK.visible = false;
			bJ.visible = false;
			bQ.visible = false;
			bK.visible = false;
			if (((p__2) == "diamond") || ((p__2) == "heart")){
				if ((p__1) == 11){
					rJ.visible = true;
				} else if ((p__1) == 12){
					rQ.visible = true;
				} else if ((p__1) == 13){
					rK.visible = true;
				}
			} else if (((p__2) == "club") || ((p__2) == "spade")){
				if ((p__1) == 11){
					bJ.visible = true;
				} else if ((p__1) == 12){
					bQ.visible = true;
				} else if ((p__1) == 13){
					bK.visible = true;
				}
			}
		}
		public function hideAll():void
		{
			rJ.visible = false;
			rQ.visible = false;
			rK.visible = false;
			bJ.visible = false;
			bQ.visible = false;
			bK.visible = false;
		}
		public function showArt(p__1:String, p__2:String):void
		{
			hideAll();
			if (((p__1) == "heart") || ((p__1) == "diamond")){
				if ((p__2) == "J"){
					rJ.visible = true;
				} else if ((p__2) == "Q"){
					rQ.visible = true;
				} else if ((p__2) == "K"){
					rK.visible = true;
				}
			} else if (((p__1) == "spade") || ((p__1) == "club")){
				if ((p__2) == "J"){
					bJ.visible = true;
				} else if ((p__2) == "Q"){
					bQ.visible = true;
				} else if ((p__2) == "K"){
					bK.visible = true;
				}
			}
		}
	}
}