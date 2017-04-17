// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.popups
{
	import flash.events.*;
	import caurina.transitions.*;
	import flash.geom.*;
	import com.script.display.Dialog.*;
	import flash.display.*;
	import com.script.ui.scroll.*;
	import com.script.poker.table.asset.*;
	import flash.filters.*;
	public class PopupView extends flash.display.MovieClip
	{
		public var tmpXML:String = "<popup interstitial=\"false\" id=\"2\" type=\"php\" snid=\"1,7\" modal=\"true\" cancelable=\"false\"><event controller=\"lobby\">sitGoLocked</event><content width=\"300\" height=\"300\"><module src=\"demoModule.swf\"/><text>The sit n go tourney is locked!</text></content><buttons><button type=\"small\" offsetX=\"100\" offsetY=\"100\" label=\"Release All\" kind=\"STANDARD\"><action class=\"DialogEvent\" event=\"RELEASE\">unlockTourney</action></button><button type=\"large\" label=\"Close Me\" kind=\"STANDARD\"><action class=\"DialogEvent\" event=\"CLOSE\"></action></button></buttons></popup>";
		private var basicSkin:com.script.display.Dialog.DialogSkin;
		private var layer:com.script.display.Dialog.DialogLayer;
		private var buttonCore:Array;
		private var titleSkin:com.script.display.Dialog.DialogSkin;
		private var interSkin:com.script.display.Dialog.DialogSkin;
		private var stylebox:com.script.poker.popups.PopupStyleBox;
		private var layerIS:com.script.display.Dialog.DialogLayer;
		public function PopupView()
		{
			stylebox = new com.script.poker.popups.PopupStyleBox();
			stylebox.font1 = TahomaContainer;
			stylebox.input1 = TahomaInputContainer;
			stylebox.input2 = TahomaInputContainer14;
			stylebox.input3 = TahomaInputContainer16;
			stylebox.buttonSmall = SmButton;
			stylebox.buttonMedium = MidButton;
			stylebox.buttonLarge = LgButton;
			stylebox.myriad = myriadTF;
			com.script.display.Dialog.DialogEvent.disp.addEventListener(com.script.display.Dialog.DialogEvent.OPEN, releaseOthers);
			initPopupView();
		}
		public function releaseOthers(p__1:*)
		{
			com.script.ui.scroll.ScrollEvent.quickThrow(com.script.ui.scroll.ScrollEvent.DEFOCUS, this);
		}
		public function initPopupView()
		{
			layer = new com.script.display.Dialog.DialogLayer(760, 530, PanelBG, panelShow, panelHide);
			layerIS = new com.script.display.Dialog.DialogLayer(760, 530, PanelBGIS, panelShow, panelHide);
			addChild(layer);
			addChild(layerIS);
			buttonCore = new Array();
			titleSkin = new com.script.display.Dialog.DialogSkin();
			basicSkin = new com.script.display.Dialog.DialogSkin();
			interSkin = new com.script.display.Dialog.DialogSkin();
			defineSkins();
		}
		public function clickTest(p__1:*)
		{
		}
		public function hydrate(p__1)
		{
			var p__2:Object = new Object();
			var tmpSkin = undefined;
			var a = undefined;
			var tmpBtn = undefined;
			var pos = undefined;
			var tmpDGB = undefined;
			var b = undefined;
			
			p__2.interstitial = "false";
			p__2.cancelable = "true";
			p__2.modal = "true";
			p__2.title = "Error Message";

			
			tmpSkin = titleSkin;
			//var chunk = new XML(xmlchunk);
			if ((p__2.title.toString() == "") && !(p__2.interstitial == "true")){
				tmpSkin = basicSkin;
			} else if (p__2.interstitial != "true"){
				tmpSkin = titleSkin;
			}
			var interstitial:Boolean;
			if (p__2.interstitial == "true"){
				tmpSkin = interSkin;
				interstitial = true;
			}
			
			//var newPop = new com.script.display.Dialog.DialogBox(tmpSkin, Number(chunk.content.@width), Number(chunk.content.@height));
			var newPop = new com.script.display.Dialog.DialogBox(tmpSkin, Number(800), Number(800));
			//newPop.titleText = chunk.content.title.toString();
			newPop.titleText = p__2.title.toString();
			if (p__2.cancelable == "true"){
				newPop.cancelable = true;
			} else {
				newPop.cancelable = false;
			}
			if (p__2.modal == "true"){
				newPop.modal = true;
			} else {
				newPop.modal = false;
			}
			//p__1.preflight(stylebox)
			p__1.preflight(stylebox)
			
			/*if (p__1){
				try {
					p__1.preflight(stylebox);
					
				} catch (error:Error) {
				}
				try {
					p__1.pipe = newPop;
				} catch (error:Error) {
				}
				newPop.module = p__1;
				
			} else {
				//newPop.bodyText = chunk.content.text.toString();
				
			}
			*/
			
			/*
			for each (a in chunk.buttons.button){
				tmpBtn = new com.script.poker.table.asset.PokerButton(myriadTF, "large", a.@label, null, -1, 4);
				pos = null;
				if (!(String(a.@offsetX) == "") && !(String(a.@offsetY) == "")){
					pos = new flash.geom.Point(Number(a.@offsetX), Number(a.@offsetY));
				}
				tmpDGB = new com.script.poker.popups.PopupDialogButton(tmpBtn, pos);
				newPop.addButton(tmpDGB);
				for each (b in a.action){
					tmpDGB.addEvent(b.@["class"], b.@["event"], newPop);
				}
			}
			*/
			if (!interstitial){
				layer.add(newPop);
				
			} else {
				layerIS.add(newPop);
			}
			
			return(newPop);
		}
		public function createPopup(p__1:XML):com.script.display.Dialog.DialogBox
		{
			return(null);
		}
		private function popupShow(p__1:*)
		{
			p__1.filters = new Array(makeGlow());
			p__1.alpha = 0;
			caurina.transitions.Tweener.addTween(p__1, {alpha:1, time:0.25});
		}
		private function popupHide(p__1:*)
		{
			p__1.filters = null;
			p__1.alpha = 0;
			p__1.visible = false;
		}
		private function panelShow(p__1:*)
		{
			caurina.transitions.Tweener.addTween(p__1, {alpha:1, time:3});
		}
		private function panelHide(item:*)
		{
			caurina.transitions.Tweener.addTween(item, {alpha:0, time:0.5, transition:"linear", onComplete:function()
			{
				item.visible = false;
			}});
		}
		private function makeDrop(p__1:Boolean = false)
		{
			var l__2:Number = 0;
			var l__3:Number = 45;
			var l__4:Number = 0.35;
			var l__5:Number = 4;
			var l__6:Number = 4;
			var l__7:Number = 4;
			var l__8:Number = 1;
			p__1 = p__1;
			var l__9:Boolean;
			var l__10:Number = flash.filters.BitmapFilterQuality.LOW;
			return(new flash.filters.DropShadowFilter(l__7, l__3, l__2, l__4, l__5, l__6, l__8, l__10, p__1, l__9));
		}
		private function makeGlow()
		{
			var l__1:Number = 16777215;
			var l__2:Number = 0.75;
			var l__3:Number = 7;
			var l__4:Number = 7;
			var l__5:Number = 2;
			var l__6:Boolean;
			var l__7:Boolean;
			var l__8:Number = flash.filters.BitmapFilterQuality.HIGH;
			return(new flash.filters.GlowFilter(l__1, l__2, l__3, l__4, l__5, l__8, l__6, l__7));
		}
		private function defineSkins()
		{
			titleSkin.TopLeftCorner = new com.script.display.Dialog.DialogSkinItem(topLeft);
			titleSkin.TopRightCorner = new com.script.display.Dialog.DialogSkinItem(topRight);
			titleSkin.BottomLeftCorner = new com.script.display.Dialog.DialogSkinItem(botLeft);
			titleSkin.BottomRightCorner = new com.script.display.Dialog.DialogSkinItem(botRight);
			titleSkin.LeftBand = new com.script.display.Dialog.DialogSkinItem(sideBand);
			titleSkin.RightBand = new com.script.display.Dialog.DialogSkinItem(sideBand);
			titleSkin.TopBand = new com.script.display.Dialog.DialogSkinItem(topBand);
			titleSkin.BottomBand = new com.script.display.Dialog.DialogSkinItem(botBand);
			titleSkin.titleItem = titleText;
			titleSkin.bodyItem = bodyText;
			titleSkin.closeButton = closeButton;
			titleSkin.closeOffset = new flash.geom.Point(9, 15);
			titleSkin.showEffect = popupShow;
			titleSkin.hideEffect = popupHide;
			basicSkin.TopLeftCorner = new com.script.display.Dialog.DialogSkinItem(topLeftNT);
			basicSkin.TopRightCorner = new com.script.display.Dialog.DialogSkinItem(topRightNT);
			basicSkin.BottomLeftCorner = new com.script.display.Dialog.DialogSkinItem(botLeft);
			basicSkin.BottomRightCorner = new com.script.display.Dialog.DialogSkinItem(botRight);
			basicSkin.LeftBand = new com.script.display.Dialog.DialogSkinItem(sideBandNT);
			basicSkin.RightBand = new com.script.display.Dialog.DialogSkinItem(sideBandNT);
			basicSkin.TopBand = new com.script.display.Dialog.DialogSkinItem(topBandNT);
			basicSkin.BottomBand = new com.script.display.Dialog.DialogSkinItem(botBand);
			basicSkin.titleItem = titleText;
			basicSkin.bodyItem = bodyText;
			basicSkin.closeButton = closeButton;
			basicSkin.closeOffset = new flash.geom.Point(13, -13);
			interSkin.TopLeftCorner = new com.script.display.Dialog.DialogSkinItem(topLeftIS);
			interSkin.TopRightCorner = new com.script.display.Dialog.DialogSkinItem(topRightIS);
			interSkin.BottomLeftCorner = new com.script.display.Dialog.DialogSkinItem(botLeftIS);
			interSkin.BottomRightCorner = new com.script.display.Dialog.DialogSkinItem(botRightIS);
			interSkin.LeftBand = new com.script.display.Dialog.DialogSkinItem(BandIS);
			interSkin.RightBand = new com.script.display.Dialog.DialogSkinItem(BandIS);
			interSkin.TopBand = new com.script.display.Dialog.DialogSkinItem(BandIS);
			interSkin.BottomBand = new com.script.display.Dialog.DialogSkinItem(BandIS);
			interSkin.titleItem = titleTextIS;
			interSkin.bodyItem = bodyTextIS;
			interSkin.closeButton = closeButton;
			interSkin.closeOffset = new flash.geom.Point(-7, 10);
			interSkin.bgColor = 3355443;
			interSkin.bgOpacity = 0.6;
			
		}  
	}
}