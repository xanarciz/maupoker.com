// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.script.poker.table.asset.PhoneIcon;
	import caurina.transitions.*;
	public class GiftController
	{
		public var aGiftRef:Array;
		public var mt:com.script.poker.table.TableView;
		public var aGifts:Array;
		public var aGiftCoords:Array;
		public var cont:flash.display.MovieClip;
		public var aSitCoords:Array;
		public function GiftController(p__1:com.script.poker.table.TableView, p__2:flash.display.MovieClip):void
		{
			mt = p__1;
			cont = p__2;			
			aSitCorods = mt.aChickletCoorData;
			aGiftCoords = mt.aGiftCoorData;
			initGifts();
		}
		public function initGifts():void
		{
			aGifts = new Array();
			aGiftRef = new Array();
		}
		public function sendGift(p__1:int, p__2:int, p__3:int, p__4:Number):void
		{
		}
		public function sendGift2(fromSit:int, toSit:int, inGiftId:Number):void
		{
			var gift:flash.display.MovieClip;
			var tester = undefined;
			tester = function(p__1:flash.events.MouseEvent):void
			{
			};
			var pushNew = function():void
			{
				aGiftRef[toSit] = null;
				var l__1:Object = new Object();
				l__1.sit = toSit;
				l__1.gift = gift;
				aGifts.push(l__1);
			};
			gift = GiftLibrary.GetInst().CreateGiftMovieClip(0, inGiftId.toString());
			gift.useHandCursor = true;
			gift.buttonMode = true;
			gift.mouseEnabled = true;
			gift.mouseChildren = true;
			gift.addEventListener(MouseEvent.ROLL_OVER, tester);
			gift.nSit = toSit;
			gift.addEventListener(MouseEvent.CLICK, giftClicked);
			gift.x = aSitCorods[fromSit][0];
			gift.y = aSitCorods[fromSit][1];
			cont.addChild(gift);
			var toX:int = aGiftCoords[toSit][0];
			var toY:int = aGiftCoords[toSit][1];
			Tweener.addTween(gift, {x:toX, y:toY, time:0.75, transition:"easeOutSine", onComplete:function()
			{
				clearOld(toSit);
				pushNew();
			}});
			aGiftRef[toSit] = gift;
		}
		 private function showEmptyGift(param1:int) : void
        {
			
            var _loc_2:flash.display.MovieClip = new EmptyGiftIcon();
            _loc_2.x = aGiftCoords[param1][0];
            _loc_2.y = aGiftCoords[param1][1];
            _loc_2.useHandCursor = true;
            _loc_2.buttonMode = true;
            _loc_2.mouseEnabled = true;
            _loc_2.mouseChildren = true;
            _loc_2.addEventListener(MouseEvent.CLICK, giftClicked);
			_loc_2.nSit = param1;
            var _loc_3:* = new Object();
            _loc_3.sit = param1;
            _loc_3.gift = _loc_2;
	
            aGifts.push(_loc_3);
            cont.addChild(_loc_2);
            return;
        }
		
		public function clearOld(p__1:int):void
		{
			var l__2:* = undefined;
			var l__3:flash.display.MovieClip;
			for (l__2 in aGifts){
				if (aGifts[l__2].sit == (p__1)){
					l__3 = aGifts[l__2].gift;
					if (l__3){
						
						GiftLibrary.GetInst().ReleaseGiftMovieClip(l__3);
						if (cont.contains(l__3)){
							cont.removeChild(l__3);
						}
					}
					l__3 = null;
					aGifts.splice(l__2, 1);
				}
			}
		}
		public function clearGiftFromSit(p__1:int):void
		{
			var l__2:Object;
			if (Tweener.isTweening(aGiftRef[p__1])){
				Tweener.removeTweens(aGiftRef[p__1]);
				clearOld(p__1);
				l__2 = new Object();
				l__2.sit = p__1;
				l__2.gift = aGiftRef[p__1];
				aGifts.push(l__2);
				aGiftRef[p__1] = null;
				
			}
			clearOld(p__1);
		}
		public function clearGifts():void
		{
			var l__1:* = undefined;
			var l__2:flash.display.MovieClip;
			for (l__1 in aGifts){
				l__2 = aGifts[l__1].gift;
				cont.removeChild(l__2);
				l__2 = null;
			}
			aGifts = [];
		}
		public function placeGift(p__1:int, p__2:int, p__3:Number):void
		{
			
		}
		public function placeGift2(Viewer_nHideGifts:Number, inSit:int, inGiftId:Number):void
		{
			var tester = undefined;
			tester = function(p__1:flash.events.MouseEvent):void
			{
			};
			if (inGiftId == -1){
				
				clearOld(inSit);
				showEmptyGift(inSit);
				return;
			}
			var oGift:com.script.poker.table.GiftItem = GiftLibrary.GetInst().GetGift(inGiftId);
			if (oGift == null){
				return;
			}
			var gift:flash.display.MovieClip = GiftLibrary.GetInst().CreateGiftMovieClip(0, inGiftId);
			if (gift == null){
				return;
			}
			if (Viewer_nHideGifts == 1){
				if (oGift.mbUserFilter){
					return;
				}
			}
			clearOld(inSit);
			///gift.mouseEnabled = false;
			//gift.mouseChildren = false;
			gift.useHandCursor = true;
			gift.buttonMode = true;
			gift.mouseEnabled = true;
			gift.mouseChildren = true;
			gift.nSit = inSit;
			gift.addEventListener(MouseEvent.ROLL_OVER, tester);
			gift.addEventListener(MouseEvent.CLICK, giftClicked);
			gift.x = aGiftCoords[inSit][0];
			gift.y = aGiftCoords[inSit][1];
			var dObj:Object = new Object();
			dObj.sit = inSit;
			dObj.gift = gift;
			aGifts.push(dObj);
			cont.addChild(gift);
			cont.visible = true;
		}
		public function giftClicked(p__1:flash.events.MouseEvent):void
		{
			//if (p__1.currentTarget.canFire){
				//mt.giftClick(findGiftSit(event.currentTarget as MovieClip));
				
				mt.onGiftPressed(p__1.currentTarget.nSit);
			//}
		}
		public function setPhoneIcon(inSit:int):void
		{
			var iPhonePromo = undefined;
			iPhonePromo = function(p__1:flash.events.MouseEvent):void
			{
				mt.iPhonePromo();
			};
			var phone:com.script.poker.table.asset.PhoneIcon = new PhoneIcon();
			phone.x = aGiftCoords[inSit][0];
			phone.y = aGiftCoords[inSit][1];
			phone.useHandCursor = true;
			phone.buttonMode = true;
			phone.mouseEnabled = true;
			phone.mouseChildren = true;
			phone.addEventListener(MouseEvent.CLICK, iPhonePromo);
			var dObj:Object = new Object();
			dObj.sit = inSit;
			dObj.gift = phone;
			aGifts.push(dObj);
			cont.addChild(phone);
		}
	}
}