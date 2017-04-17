// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table.asset
{
	import com.script.poker.table.TableView;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.display.Bitmap;
	import flash.display.InteractiveObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import com.script.display.SafeImageLoader;
	import caurina.transitions.properties.*;
	public class Chicklet extends flash.display.MovieClip
	{
		public var mt:com.script.poker.table.TableView;
		public var aRankNames:Array = new Array("", "Rookie", "Playa", "Poker Pro", "Big Dog", "Shark", "PRO      100K", "PRO      250K", "PRO      500K", "PRO     1M", "PRO     5M", "PRO     10M", "PRO     20M", "PRO     50M");
		public var thisZid:String;
		public var ldrPic:com.script.display.SafeImageLoader;
		public var smoother:flash.display.Bitmap;
		public var hitter:flash.display.MovieClip;
		public var thisName:String;
		public var vipBadge:flash.display.MovieClip;
		public var thisSide:String;
		public var rankTF:flash.text.TextField;
		public var thisVip:Boolean;
		public var playerImg:flash.display.MovieClip;
		//public var playerImgBg:flash.display.MovieClip;
		public var rankStar:flash.display.MovieClip;
		public var thisChips:Number = 0;
		public var picSize:Number = 44;
		public var chipsBG:flash.display.MovieClip;
		public var color_rollover:uint;
		public var thisID:int;
		public var nameTF:flash.text.TextField;
		public var isSeated:Boolean = false;
		public var isTurn:Boolean = false;
		public var aSitAlign:Array = new Array("left", "left", "left", "right", "right", "right", "right", "right", "left");
		public var isBlank:Boolean = false;
		public var playerSit:flash.display.MovieClip;
		public var chipsTF:flash.text.TextField;
		public var playerBG:flash.display.MovieClip;
		public var thisRank:int;
		public var isViewer:Boolean = false;
		public var color_viewer:uint;
		public var thisURL:String;
		public var bStatus:Number = 0;
		public function Chicklet()
		{
			playerSit.gotoAndStop(1);
			nameTF.visible = false;
			chipsTF.visible = false;
			chipsBG.visible = false;
			chipsBG.enabled = false;
			rankStar.visible = false;
			rankStar.enabled = false;
			vipBadge.visible = false;
			vipBadge.mouseEnabled = true;
			vipBadge.mouseChildren = true;
			vipBadge.useHandCursor = true;
			vipBadge.buttonMode = true;
			playerBG.visible = false;
			playerBG.enabled = false;
			playerImg.visible = false;
			playerImg.enabled = false;
			//playerImgBg.visible = false;
			//playerImgBg.enabled = false;
			playerSit.visible = false;
			playerSit.enabled = false;
			hitter.buttonMode = true;
		}
		public function initChicklet(p__1:int, p__2:com.script.poker.table.TableView, p__3:String = ""):void
		{
			thisID = p__1;
			mt = p__2;
			isTurn = false;
			isSeated = false;
			if (isSeated){
				showInfo();
			} else if ((p__3) != "shootout"){
				showSit();
			}
			hitter.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			hitter.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			vipBadge.addEventListener(MouseEvent.CLICK, vipBadgeClick);
		}
		private function onMouseOver(p__1:flash.events.MouseEvent):void
		{
			playerSit.gotoAndStop(2);
		}
		private function onMouseOut(p__1:flash.events.MouseEvent):void
		{
			playerSit.gotoAndStop(1);
		}
		private function vipBadgeClick(p__1:flash.events.MouseEvent):void
		{
			mt.launchVipPopup();
		}
		private function loadPlayerPic():void
		{
			var l__2:flash.net.URLRequest;
			playerBG.visible = true;
			var l__1:int;
			while(l__1 < playerImg.numChildren){
				playerImg.removeChildAt(0);
			}
			if (thisURL != ""){
				if (ldrPic != null){
					ldrPic = null;
				}
				l__2 = new URLRequest(thisURL);
				ldrPic = new SafeImageLoader("../Avatar/default.jpg");
				ldrPic.visible = false;
				ldrPic.contentLoaderInfo.addEventListener(Event.COMPLETE, onPicLoadComplete);
				ldrPic.load(l__2);
			}
		}
		private function onPicLoadComplete(p__1:flash.events.Event):void
		{
			var l__6:Number = 0;
			var l__2:Number = 27;
			var l__3:Number = 27;
			var l__4:Number = 54;
			var l__5:Number = 54;
			
			if ((ldrPic.height > l__5) || (ldrPic.width > l__4)){
				
				l__6 = 1 / Math.max(ldrPic.height / l__5, ldrPic.width / l__4);
				ldrPic.scaleY *= l__6;
				ldrPic.scaleX *= l__6;
			}
			//ldrPic.x = ((0 - (ldrPic.width >> 1)) + l__2);
			//ldrPic.y = ((0 - (ldrPic.height >> 1)) + l__3);
			ldrPic.x = 1;
			ldrPic.y = 2;
			ldrPic.visible = true;
			ldrPic.width = 50;
			ldrPic.height = 50;
			playerImg.addChild(ldrPic);
			playerBG.visible = false;
		}
		public function setPlayerInfo(p__1:String, p__2:String, p__3:int, p__4:Number, p__5:Boolean, p__6:Boolean, p__7:String):void
		{
			thisURL = p__1;
			thisSide = aSitAlign[thisID];
			thisName = p__2;
			thisRank = p__3;
			thisChips = p__4;
			thisVip = p__5;
			isSeated = true;
			isViewer = p__6;
			thisZid = p__7;
			updateRank(thisRank);
			loadPlayerPic();
			showInfo();
		}
		public function updateChips(p__1:Number = 0):void
		{
			thisChips = p__1;
			trace(thisChips+"cabe hijau");
			chipsTF.text = thisChips.toString();
		}
		public function updateRank(p__1:int = 0):void
		{
			thisRank = p__1;
			rankTF.visible = true;
			//rankTF.text = aRankNames[p__1];
			rankTF.text = "";
			rankStar.visible = false;
			rankStar.x = 0;
			if (thisRank > 5){
				//rankStar.visible = true;
				rankStar.visible = false;
			}
			if ((thisRank == 9) || (thisRank == 10)){
				rankStar.x = 4;
			}
			if (thisRank > 10){
				rankStar.x = 2;
			}
		}
		private function setSide():void
		{
			if (thisSide == "left"){
				vipBadge.x = -25;
			} else if (thisSide == "right"){
				vipBadge.x = 25;
			}
			if (thisVip == true){
				vipBadge.visible = true;
				//vipBadge.visible = false;
			}
		}
		public function showInfo():void
		{
			var l__1:String;
			isSeated = true;
			isBlank = false;
			hitter.useHandCursor = true;
			hitter.enabled = true;
			if (thisName.length > 10){
				l__1 = (thisName.substr(0, 8) + "...");
			} else {
				l__1 = thisName;
			}
			nameTF.text = l__1;
			chipsTF.text = thisChips.toString();
			nameTF.visible = true;
			chipsTF.visible = true;
			chipsBG.visible = true;
			playerBG.visible = true;
			playerImg.visible = true;
			//playerImgBg.visible = true;
			playerSit.visible = false;
			setSide();
			stopHighlight();
			
		}
		public function showSit():void
		{
			isSeated = false;
			isBlank = false;
			nameTF.visible = false;
			chipsTF.visible = false;
			chipsBG.visible = false;
			playerBG.visible = false;
			playerImg.visible = false;
			//playerImgBg.visible = false;
			rankTF.visible = false;
			rankStar.visible = false;
			vipBadge.visible = false;
			playerSit.visible = true;
			stopHighlight();
			hitter.useHandCursor = true;
			hitter.enabled = true;
		}
		public function showLeave():void
		{
			isBlank = true;
			isSeated = false;
			hitter.useHandCursor = false;
			hitter.enabled = false;
			nameTF.visible = false;
			chipsTF.visible = false;
			chipsBG.visible = false;
			playerBG.visible = false;
			playerImg.visible = false;
			playerSit.visible = false;
			vipBadge.visible = false;
			rankTF.visible = false;
			rankStar.visible = false;
			stopHighlight();
		}
		public function showHighlight():void
		{
			isTurn = true;
		}
		public function stopHighlight():void
		{
			isTurn = false;
		}
		public function returnData():Object
		{
			var l__1:Object = new Object();
			l__1.seated = isSeated;
			l__1.id = thisID;
			l__1.side = thisSide;
			l__1.name = thisName;
			l__1.rank = thisRank;
			l__1.vip = thisVip;
			return(l__1);
		}
		public function hideMe():void
		{
			this.visible = false;
		}
	}
	FilterShortcuts.init();
	//var l__1:* = ColorShortcuts.init();
	//return(l__1);
}