// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table
{
	import flash.events.*;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.script.poker.table.asset.PhoneIcon;
	import caurina.transitions.*;
	import flash.utils.*;
	public class EmoController
	{
		public var aEmoRef:Array; 
		public var mt:com.script.poker.table.TableView;
		public var aEmos:Array;
		public var aEmoCoords:Array;
		public var cont:flash.display.MovieClip;
		public var aSitCoords:Array;
		private var showTimer:Array = new Array();
		private var showActive:Array = new Array();
		public var showTimerActive:Boolean = false;
		public var showAnimTimerActive:Boolean = false;
		
		public function EmoController(p__1:com.script.poker.table.TableView, p__2:flash.display.MovieClip):void
		{
			mt = p__1;
			cont = p__2;
			aSitCoords = mt.aChickletCoorData;
			aEmoCoords = mt.aEmoCoorData;
			initEmos();
		}
		public function initEmos():void
		{
			aEmos = new Array();
			aEmoRef = new Array();
		}
		public function sendEmo(fromSit:int, toSit:int, inEmoId:Number, inEmoStr:String):void
		{
			
			var Emo:flash.display.MovieClip;
			var tester = undefined;
			tester = function(p__1:flash.events.MouseEvent):void
			{
			};
			var pushNew = function():void
			{
				aEmoRef[99] = null;
				var l__1:Object = new Object();
				l__1.sit = 99;
				l__1.Emo = Emo;
				aEmos.push(l__1);
			};
			Emo = EmoLibrary.GetInst().CreateEmoMovieClip(0, inEmoId.toString());
			Emo.mouseEnabled = false;
			Emo.mouseChildren = false;
			Emo.addEventListener(MouseEvent.ROLL_OVER, tester);
			Emo.x = 0;
			Emo.y = 0;
			
			cont.addChild(Emo);
			var toX:int = 0;
			var toY:int = 0;
			//Tweener.addTween(Emo, {x:toX, y:toY, time:0.75, transition:"easeOutSine", onComplete:function()
			//{
				clearOld(99);
				pushNew();
			//}});
			aEmoRef[99] = Emo;
			//showTimer[toSit] = 
			if (showActive[99] == true) {
				showTimer[99].removeEventListener(flash.events.TimerEvent.TIMER, onShowEmo);
				showActive[99] = false;
			}
			if (showActive[99] != true){
				showTimer[99] = new flash.utils.Timer(30000, 99);
				showTimer[99].addEventListener(flash.events.TimerEvent.TIMER, onShowEmo);
				showTimer[99].start();
				showActive[99] = true;
			}
			showAnimTimerActive = true;
		}
		public function sendEmo2(fromSit:int, toSit:int, inEmoId:Number):void
		{
			var Emo:flash.display.MovieClip;
			var tester = undefined;
			tester = function(p__1:flash.events.MouseEvent):void
			{
			};
			var pushNew = function():void
			{
				aEmoRef[toSit] = null;
				var l__1:Object = new Object();
				l__1.sit = toSit;
				l__1.Emo = Emo;
				aEmos.push(l__1);
			};
			Emo = EmoLibrary.GetInst().CreateEmoMovieClip(0, inEmoId.toString());
			Emo.mouseEnabled = false;
			Emo.mouseChildren = false;
			Emo.addEventListener(MouseEvent.ROLL_OVER, tester);
			
			Emo.x = aEmoCoords[fromSit][0];
			Emo.y = aEmoCoords[fromSit][1];
			
			
			
			cont.addChild(Emo);
			Emo.width=6;
			Emo.height=6;
		
			var toX:int = aEmoCoords[toSit][0];
			var toY:int = aEmoCoords[toSit][1];
			
			//Tweener.addTween(Emo, {x:toX, y:toY, time:0.75, transition:"easeOutSine", onComplete:function()
			//{
				clearOld(toSit);
				pushNew();
			//}});
			
			aEmoRef[toSit] = Emo;
			//showTimer[toSit] = 
			if (showActive[toSit] == true) {
				showTimer[toSit].removeEventListener(flash.events.TimerEvent.TIMER, onShowEmo);
				showActive[toSit] = false;
			}
			if (showActive[toSit] != true){
				
				showTimer[toSit] = new flash.utils.Timer(7000, toSit);
				showTimer[toSit].addEventListener(flash.events.TimerEvent.TIMER, onShowEmo);
				showTimer[toSit].start();
				showActive[toSit] = true;
			}
			
			showTimerActive = true;
		}
		
		private function onShowEmo(p__1:flash.events.TimerEvent):void
		{
			//var arr = arguments[0]
			stopUseTimer(p__1.target.repeatCount);
		}
		private function stopUseTimer(p__1:*):void
		{
			if (showTimer[p__1] != null){
					showTimer[p__1].stop();
					showTimer[p__1].removeEventListener(flash.events.TimerEvent.TIMER, onShowEmo);
					showTimer[p__1] = null;
					
					showActive[p__1] = false;
			}
				//wtBtn.setActivity(p__1);				
				showTimerActive = false;
				clearEmoFromSit(p__1)
			
		}
		public function clearOld(p__1:int):void
		{
			var l__2:* = 0;
			var l__3:flash.display.MovieClip;
			
			for (l__2 in aEmos){
				if (aEmos[l__2].sit == (p__1)){
					l__3 = aEmos[l__2].Emo;
					if (l__3){
						for(var s in l__3) {
							
						}
						//l__3.t.removeEventListener(Event.ENTER_FRAME, mover);
						EmoLibrary.GetInst().ReleaseEmoMovieClip(l__3);
						if (cont.contains(l__3)){
							cont.removeChild(l__3);
						}
					}
					l__3 = null;
					aEmos.splice(l__2, 1);
				}
			}
		}
		public function clearEmoFromSit(p__1:int):void
		{
			var l__2:Object;
			if (Tweener.isTweening(aEmoRef[p__1])){
				Tweener.removeTweens(aEmoRef[p__1]);
				clearOld(p__1);
				l__2 = new Object();
				l__2.sit = p__1;
				l__2.Emo = aEmoRef[p__1];
				aEmos.push(l__2);
				aEmoRef[p__1] = null;
			}
			clearOld(p__1);
		}
		public function clearEmo():void
		{
			var l__1:* = undefined;
			var l__2:flash.display.MovieClip;
			for (l__1 in aEmos){
				l__2 = aEmos[l__1].Emo;
				cont.removeChild(l__2);
				l__2 = null;
			}
			aEmos = [];
		}
		public function placeEmo(p__1:int, p__2:int, p__3:Number):void
		{
		}
		public function placeEmo2(Viewer_nHideEmos:Number, inSit:int, inEmoId:Number):void
		{
			showEmptyGift(inSit)
			var tester = undefined;
			tester = function(p__1:flash.events.MouseEvent):void
			{
			};
			if (inEmoId == -1){
				clearOld(inSit);
				return;
			}
			var oEmo:com.script.poker.table.EmoItem = EmoLibrary.GetInst().GetEmo(inEmoId);
			if (oEmo == null){
				return;
			}
			var Emo:flash.display.MovieClip = EmoLibrary.GetInst().CreateEmoMovieClip(0, inEmoId);
			if (Emo == null){
				return;
			}
			if (Viewer_nHideEmos == 1){
				if (oEmo.mbUserFilter){
					return;
				}
			}
			clearOld(inSit);
			Emo.mouseEnabled = false;
			Emo.mouseChildren = false;
			Emo.addEventListener(MouseEvent.ROLL_OVER, tester);
			
			Emo.x = aEmoCoords[inSit][0];
			Emo.y = aEmoCoords[inSit][1];
			var dObj:Object = new Object();
			dObj.sit = inSit;
			dObj.Emo = Emo;
			aEmos.push(dObj);
			cont.addChild(Emo);
		}
		public function EmoClicked(p__1:flash.events.MouseEvent):void
		{
			if (p__1.currentTarget.canFire){
				mt.onEmoPressed(p__1.currentTarget.nSit);
			}
		}
		public function setPhoneIcon(inSit:int):void
		{
			var iPhonePromo = undefined;
			iPhonePromo = function(p__1:flash.events.MouseEvent):void
			{
				mt.iPhonePromo();
			};
			var phone:com.script.poker.table.asset.PhoneIcon = new PhoneIcon();
			phone.x = aEmoCoords[inSit][0];
			phone.y = aEmoCoords[inSit][1];
			phone.useHandCursor = true;
			phone.buttonMode = true;
			phone.mouseEnabled = true;
			phone.mouseChildren = true;
			phone.addEventListener(MouseEvent.CLICK, iPhonePromo);
			var dObj:Object = new Object();
			dObj.sit = inSit;
			dObj.Emo = phone;
			aEmos.push(dObj);
			cont.addChild(phone);
		}
	}
}