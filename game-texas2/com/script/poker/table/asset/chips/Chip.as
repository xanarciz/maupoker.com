// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table.asset.chips
{
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.EventDispatcher;
	import flash.filters.DropShadowFilter;
	import caurina.transitions.*;
	import caurina.transitions.properties.*;
	public class Chip extends flash.display.Sprite
	{
		public var cont:flash.display.Sprite;
		public var colorList:Array = [[1, 14540253, null, true], [5, 16711680, null, true], [10, 1140479, null, true], [25, 52224, null, true], [100, 2236962, null, true], [500, 10092799, null, true], [1000, 11141154, null, true], [5000, 8734214, null, true], [10000, 15129344, null, true], [25000, 52224, "silver", true], [50000, 16742144, "silver", true], [100000, 2236962, "silver", true], [1000000, 14540253, "gold", true], [5000000, 16711680, "gold", true], [10000000, 1140479, "gold", true], [25000000, 52224, "gold", true], [100000000, 2236962, "gold", true], [500000000, 10092799, "gold", true], [1000000000, 0, "silver", true], [10000000000, 0, "black", true], [25000000000, 52428, "red", true], [100000000000, 0, "black", false], [1000000000000, 0, "silver", false]];
		public var chipValue:Number = 0;
		public var decorColorList:Array = [["silver", 16777215], ["gold", 16771584], ["black", 2236962], ["red", 13369344]];
		public var colorID:Number = 0;
		public function Chip(p__1:Class, p__2:Class, p__3:Number, p__4:Number)
		{
			var l__10:flash.display.Sprite;
			var l__11:Object;
			var l__12:com.script.poker.table.asset.chips.GradChipBG;
			var l__13:Object;
			var l__14:com.script.poker.table.asset.chips.GradChipBG;
			var l__15:Object;
			var l__16:com.script.poker.table.asset.chips.GradChipBG;
			var l__17:* = undefined;
			var l__18:uint;
			var l__19:Number = 0;
			cont = new Sprite();
			cont.scaleX = 0.8;
			cont.scaleY = 0.6;
			addChild(cont);
			var l__5:flash.filters.DropShadowFilter = new DropShadowFilter();
			l__5.alpha = 0.8;
			l__5.strength = 0.8;
			l__5.angle = 90;
			l__5.distance = 1;
			l__5.blurX = 1;
			l__5.blurY = 2.5;
			l__5.quality = 3;
			l__5.color = 0;
			var l__6:* = new Array();
			l__6.push(l__5);
			cont.filters = l__6;
			chipValue = p__3;
			var l__7:Number = 0;
			while(l__7 < colorList.length){
				if (colorList[l__7][0] == chipValue){
					colorID = l__7;
				}
				l__7++;
			}
			var l__8:* = colorList[colorID];
			if (colorID < 18){
				l__10 = new Sprite();
				l__10.graphics.beginFill(l__8[1], 1);
				l__10.graphics.drawEllipse(-10, -10, 20, 20);
				l__10.graphics.endFill();
				cont.addChild(l__10);
			} else if ((colorID > 17) && (colorID < 21)){
				l__11 = new Object();
				l__11.colors = [16772122, 12553984];
				l__11.alphas = [1, 1];
				l__11.ratios = [50, 255];
				l__12 = new GradChipBG(20, l__11, 90);
				cont.addChild(l__12);
			} else if (colorID == 21){
				l__13 = new Object();
				l__13.colors = [11776947, 16777215, 14540253, 8421504];
				l__13.alphas = [1, 1, 1, 1];
				l__13.ratios = [0, 127, 127, 255];
				l__14 = new GradChipBG(20, l__13, 75);
				cont.addChild(l__14);
			} else if (colorID == 22){
				l__15 = new Object();
				l__15.colors = [10878976, 16737894, 14352384, 7995392];
				l__15.alphas = [1, 1, 1, 1];
				l__15.ratios = [0, 127, 128, 255];
				l__16 = new GradChipBG(20, l__15, 75);
				cont.addChild(l__16);
			}
			if (l__8[2] != null){
				l__17 = new p__2();
				if ((l__8[2] == "black") || (l__8[2] == "red")){
					l__17.shad.visible = false;
				}
				l__18 = getColor(l__8[2]);
				l__19 = (Math.random() * 30 - 15);
				l__17.rotation = l__19;
				Tweener.addTween(l__17.theZ, {_color:l__18});
				cont.addChild(l__17);
			}
			var l__9:* = new p__1();
			l__9.ridges.rotation = p__4;
			if (!l__8[3]){
				l__9.ridges.visible = false;
			}
			if (colorID == 19){
				Tweener.addTween(l__9.ridges, {_color:2236962});
			}
			if (colorID == 20){
				Tweener.addTween(l__9.ridges, {_color:13369344});
			}
			cont.addChild(l__9);
		}
		public function getColor(p__1:String):uint
		{
			var l__2:uint;
			var l__3:Number = 0;
			while(l__3 < decorColorList.length){
				if (decorColorList[l__3][0] == (p__1)){
					l__2 = decorColorList[l__3][1];
				}
				l__3++;
			}
			return(l__2);
		}
	}
	//var l__1:* = ColorShortcuts.init();
	//return(l__1);
}