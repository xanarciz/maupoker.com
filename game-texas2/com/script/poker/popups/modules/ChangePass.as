// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.popups.modules
{
	import flash.display.*;
	import flash.text.*;
	import com.script.poker.table.asset.*;
	import com.script.poker.popups.events.*;
	import flash.events.*;
	public class ChangePass extends flash.display.MovieClip
	{
		private var _body:String = "";
		private var passStyle:flash.text.TextFormat;
		private var passStyle2:flash.text.TextFormat;
		private var passStyle3:flash.text.TextFormat;
		public var capt:*;
		public var bgbox:flash.display.MovieClip;
		private var _caption:String;
		private var _header:String = "";
		public var pipe:*;
		public var field:*;
		public var field2:*;
		public var field3:*;
		public var btnSubmitPass:com.script.poker.table.asset.PokerButton;
		//public var btnCreateAccept:com.script.poker.table.asset.PokerButton;
		public var txtold:flash.text.TextField;
		public var txtnew:flash.text.TextField;
		public var txtrenew:flash.text.TextField;
		public var langs;
		
		public var description:*;
		private var regStyle:flash.text.TextFormat;
		public function SingleInputGenericPanel()
		{
		}
		public function preflight(p__1:*)
		{
			txtold.text = langs.l_oldpass
			txtnew.text = langs.l_newpass
			txtrenew.text = langs.l_retypepass
			var l__2:* = p__1.font1;
			var l__3:* = new l__2();
			var l__4:* = new l__2();
			var l__5:* = p__1.input1;
			var l__6:* = new l__5();
			var l__7:* = p__1.input1;
			var l__8:* = new l__7();
			var l__9:* = p__1.input1;
			var l__10:* = new l__9();
			description = l__3.field;
			description.x = 20;
			description.y = 15;
			description.width = 330;
			description.height = 60;
			addChild(description);
			capt = l__4.field;
			capt.x = 20;
			capt.y = 180;
			capt.width = 330;
			capt.height = 60;
			addChild(capt);
			field = l__6.field;
			field.x = 119;
			field.y = 73;
			field.width = 240;
			field.height = 23;
			addChild(field);
			field2 = l__8.field;
			field2.x = 119;
			field2.y = 118;
			field2.width = 240;
			field2.height = 23;
			addChild(field2);
			field3 = l__10.field;
			field3.x = 119;
			field3.y = 148;
			field3.width = 240;
			field3.height = 23;
			addChild(field3);
			passStyle = new flash.text.TextFormat();
			passStyle.size = 12;
			passStyle.bold = true;
			passStyle2 = new flash.text.TextFormat();
			passStyle2.size = 12;
			passStyle2.bold = true;
			passStyle3 = new flash.text.TextFormat();
			passStyle3.size = 12;
			passStyle3.bold = true;
			regStyle = new flash.text.TextFormat();
			regStyle.size = 12;
			regStyle.bold = true;
			password = true;
			var l__12:* = p__1.myriad;
			btnSubmitPass = new PokerButton(l__12, "large", "Submit", null, 125, 5);
			//btnCreateCancel = new PokerButton(l__12, "large", "Cancel", null, 125, 5);
			btnSubmitPass.x = 195;
			//btnCreateCancel.x = 50;
			btnSubmitPass.y = 235;
			//btnCreateCancel.y = 235;
			addChild(btnSubmitPass);
			//addChild(btnCreateCancel);
			initListeners()
			
			reset();
		}
		private function initListeners():void
		{
			btnSubmitPass.addEventListener(MouseEvent.CLICK, onSubmitPass);
			//btnCreateCancel.addEventListener(MouseEvent.CLICK, onCreateCancel);
		}
		private function onSubmitPass(p__1:flash.events.MouseEvent = null):void
		{	
			dispatchEvent(new PPVEvent(PPVEvent.ENTER_CHANGEPASS));
			
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
		public function set caption(p__1:String)
		{
			capt.text = p__1;
		}
		public function set multiline(p__1:Boolean)
		{
			if (!(p__1)){
				field.height = 23;
				bgbox.height = 23;
			} else {
				field.height = 69;
				bgbox.height = 69;
			}
			capt.y = (field.y + field.height);
		}
		public function set password(p__1:Boolean)
		{
			if (p__1){
				field.setTextFormat(passStyle);
				field.displayAsPassword = true;
				field.y = 73;
				
				field2.setTextFormat(passStyle2);
				field2.displayAsPassword = true;
				field2.y = 118;
				
				field3.setTextFormat(passStyle3);
				field3.displayAsPassword = true;
				field3.y = 148;
			} else {
				field.setTextFormat(regStyle);
				field.displayAsPassword = false;
				field.y = 75;
			}
		}
		public function get value()
		{
			var valObj = {}
			valObj.old = field.text;
			valObj.news = field2.text;
			valObj.news2 = field3.text;
			//return(field.text);
			return(valObj);
		}
		private function renderText()
		{
			description.htmlText = ((("<b><font size=\'17\'>" + _header) + "</font></b><br>") + _body);
		}
		public function reset()
		{
			field.text = "";
			description.text = "";
			capt.text = "";
		}
		public function setFieldFocus():void
		{
			field.stage.focus = field;
		}
	}
}