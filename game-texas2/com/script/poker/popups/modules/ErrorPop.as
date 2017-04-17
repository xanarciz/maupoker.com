// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.popups.modules
{
	import flash.display.*;
	import flash.text.*;
	import com.script.poker.table.asset.*;
	import com.script.poker.popups.events.*;
	import flash.events.*;
	public class ErrorPop extends flash.display.MovieClip
	{
		private var _body:String = "";
		private var passStyle:flash.text.TextFormat;
		public var capt:*;
		public var bgbox:flash.display.MovieClip;
		private var _caption:String;
		private var _header:String = "";
		public var pipe:*;
		public var field:*;
		public var btnSubmitOk:com.script.poker.table.asset.PokerButton;
		public var btnSubmitCancel:com.script.poker.table.asset.PokerButton;
		//public var btnCreateAccept:com.script.poker.table.asset.PokerButton;
		
		public var upper:*;
		public var warning:*;
		private var regStyle:flash.text.TextFormat;
		public function ErrorPop()
		{
		}
		public function preflight(p__1:*)
		{
			var l__2:* = p__1.font1;
			var l__3:* = new l__2();
			var l__4:* = new l__2();
			
			/*upper = l__3.field;
			upper.x = 361;
			upper.y = 275;
			upper.width = 420;
			upper.height = 86;
			addChild(upper);
			warning = l__4.field;
			warning.x = 360;
			warning.y = 336;
			warning.width = 419;
			warning.height = 131;
			addChild(warning);*/
			passStyle = new flash.text.TextFormat();
			passStyle.size = 12;
			passStyle.bold = true;
			regStyle = new flash.text.TextFormat();
			regStyle.size = 12;
			regStyle.bold = true;
			var l__12:* = p__1.myriad;
			btnSubmitOk = new PokerButton(l__12, "large", "Ok", null, 80, 5);
			btnSubmitCancel = new PokerButton(l__12, "large", "Cancel", null, 80, 5);
			btnSubmitOk.x = 376;
			btnSubmitCancel.x = 476;
			btnSubmitOk.y = 506;
			btnSubmitCancel.y = 506;
			addChild(btnSubmitOk);
			addChild(btnSubmitCancel);
			initListeners();
			
			reset();
		}
		
		private function initListeners():void
		{
			btnSubmitOk.addEventListener(MouseEvent.CLICK, onSubmitOk);
			btnSubmitCancel.addEventListener(MouseEvent.CLICK, onSubmitCancel);
		}
		private function onSubmitOk(p__1:flash.events.MouseEvent = null):void
		{	
			dispatchEvent(new PPVEvent(PPVEvent.ENTER_ERROR));
			
		}
		private function onSubmitCancel(p__1:flash.events.MouseEvent = null):void
		{	
			dispatchEvent(new PPVEvent(PPVEvent.CANCEL_ERROR));
			
		}
		public function set header(p__1:String)
		{
			_header = p__1;
			renderText();
		}
		public function set body(p__1:String)
		{
			_body = p__1;
			renderText();
		}
		
		public function set titles(p__1:String)
		{
			upper.text = p__1;
		}
		public function set mess(p__1:String)
		{
			warning.text = p__1;
		}
		
		private function renderText()
		{
			description.htmlText = ((("<b><font size=\'17\'>" + _header) + "</font></b><br>") + _body);
		}
		public function reset()
		{
			upper.text = "";
			warning.text = "";
		}
		
	}
}