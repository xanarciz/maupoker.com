// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table
{
	import flash.display.MovieClip;
	import flash.display.Bitmap;
	import flash.events.Event;
	import com.script.poker.PokerUser;
	import com.script.poker.table.asset.PlayerRollover;
	import caurina.transitions.*;
	import flash.net.URLRequest;
	import com.script.display.SafeImageLoader;
	import com.script.format.*;
	public class ProvController
	{
		public var mt:com.script.poker.table.TableView;
		public var thisZid:String;
		public var prov:com.script.poker.table.asset.PlayerRollover;
		private var picSize:int = 90;
		public var provY:int;
		public var provX:int;
		public var ldrPic:com.script.display.SafeImageLoader;
		public var smoother:flash.display.Bitmap;
		public function ProvController(p__1:com.script.poker.table.TableView, p__2:com.script.poker.table.asset.PlayerRollover):void
		{
			prov = p__2;
			mt = p__1;
			initProv();
			
		}
		public function initProv():void
		{
			prov.mouseEnabled = false;
			prov.mouseChildren = false;
			provX = prov.x;
			provY = prov.y;
			prov.alpha = 0;
			prov.visible = false;
			prov.rankBadge.stop();
		}
		public function showProv(p__1:com.script.poker.PokerUser):void
		{
			var l__3:Number = 0;
			var l__4:String;
			var l__5:String;
			var l__6:String;
			var l__7:Array;
			var l__8:String;
			removeImages();
			var l__2:com.script.poker.PokerUser = p__1;
			if (l__2 != null){
				thisZid = p__1.zid;
				prov.nameTF.text = l__2.sUserName;
				//prov.levelTF.text = mt.ptModel.getRankName(l__2.nAchievementRank);
				prov.levelTF.text = "";
				prov.chipsTF.text = ("" + StringUtility.StringToMoney(l__2.nTotalPoints));
				l__3 = l__2.nAchievementRank;
				if (l__3 == -1){
					l__4 = "Unranked";
				}
				if (l__3 < 1){
					prov.rankBadge.visible = false;
				}
				if (l__3 > 0){
					//prov.rankBadge.visible = true;
					prov.rankBadge.visible = false;
					//prov.rankBadge.gotoAndStop(l__3);
				}
				l__4 = l__2.nRank.toString();
				if (l__4 == "-1"){
					l__4 = "Unranked";
				}
				//prov.rankTF.text = l__4;
				prov.rankTF.text = "";
				/*
				l__5 = l__2.sNetwork;
				if (l__5.length > 20){
					l__5 = (l__5.substr(0, 18) + "...");
				}
				prov.networkTF.text = l__5;
				
				l__6 = l__2.sTourneyState;
				if (l__6 == "0"){
					l__6 = " is not playing in the Weekly Tournament.";
				}
				if (l__6 == "1"){
					l__6 = " has joined the Weekly Tournament.";
				}
				if (l__6 == "2"){
					l__6 = " is in the money in the Weekly Tournament!";
				}
				if (l__6 == "3"){
					l__6 = " is in the top 20% in the Weekly Tournament!";
				}
				if (l__6 == "4"){
					l__6 = " is in the top 10% in the Weekly Tournament!";
				}
				*/
				l__7 = l__2.sUserName.split(" ");
				l__8 = l__7[0];
				//prov.tournyTF.text = (l__8 + l__6);
				loadPlayerPic(l__2.sPicLrgURL);
				prov.alpha = 0;
				prov.visible = true;
				Tweener.removeTweens(prov, "alpha");
				Tweener.addTween(prov, {alpha:1, time:0.25, delay:0.25, transition:"easeOutSine"});
			}
		}
		public function hideProv():void
		{
			Tweener.removeTweens(prov, "alpha");
			Tweener.addTween(prov, {alpha:0, time:0.2, transition:"easeOutSine"});
		}
		private function loadPlayerPic(p__1:String):void
		{
			var l__2:flash.net.URLRequest = new URLRequest(p__1);
			ldrPic = new SafeImageLoader();
			ldrPic.alpha = 0;
			ldrPic.contentLoaderInfo.addEventListener(Event.COMPLETE, onPicLoadComplete);
			ldrPic.load(l__2);
		}
		public function removeImages():void
		{
			var l__1:int;
			prov.visible = false;
			if (prov.playerImg.numChildren > 0){
				l__1 = 0;
				while(prov.playerImg.numChildren > 0){
					prov.playerImg.removeChildAt(0);
				}
			}
		}
		private function onPicLoadComplete(p__1:flash.events.Event):void
		{
			var l__5:* = undefined;
			var l__2:String = thisZid.substr(0, 1);
			var l__3:Number = 78.5;
			var l__4:Number = 64.55;
		
			if ((ldrPic.height > l__4) || (ldrPic.width > l__3)){
				l__5 = 1 / Math.min(ldrPic.height / l__4, ldrPic.width / l__3);
				ldrPic.scaleY *= l__5;
				ldrPic.scaleX *= l__5;
				ldrPic.height = 78.5
				ldrPic.width = 70.55
				
			}
			ldrPic.x = (((0 - ldrPic.width) >> 1) + (l__3 >> 1));
			ldrPic.y = 0;
			ldrPic.alpha = 1;
			prov.playerImg.addChild(ldrPic);
		}
	}
}