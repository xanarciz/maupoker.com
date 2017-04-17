// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.popups.modules
{
	import flash.display.*;
	import flash.text.*;
	import com.script.poker.table.asset.*;
	import com.script.poker.popups.events.*;
	import flash.events.*;
	public class ReportErrorPanel extends flash.display.MovieClip
	{
		private var _body:String = "";
		private var passStyle:flash.text.TextFormat;
		public var capt:*;
		public var bgbox:flash.display.MovieClip;
		private var _caption:String;
		private var _header:String = "";
		public var pipe:*;
		public var field:*;
		public var zid:*;
		public var rep_p:flash.text.TextField;
		public var rep_ket;
		public var btnSubmitReport:com.script.poker.table.asset.PokerButton;
		public var btnCancelReport:com.script.poker.table.asset.PokerButton;
		
		public var description:*;
		private var regStyle:flash.text.TextFormat;
		public function ReportErrorPanel()
		{
		}
		public function preflight(p__1:*)
		{
			var l__2:* = p__1.font1;
			var l__3:* = new l__2();
			var l__4:* = new l__2();
			var l__5:* = p__1.input1;
			var l__6:* = new l__5();
			description = l__3.field;
			description.x = 20;
			description.y = 15;
			description.width = 330;
			description.height = 60;
			addChild(description);
			capt = l__4.field;
			capt.x = 20;
			capt.y = 143;
			capt.width = 330;
			capt.height = 60;
			addChild(capt);
			field = l__6.field;
			field.x = 20;
			field.y = 75;
			field.width = 330;
			field.height = 23;
			//addChild(field);
			passStyle = new flash.text.TextFormat();
			passStyle.size = 12;
			passStyle.bold = true;
			regStyle = new flash.text.TextFormat();
			regStyle.size = 12;
			regStyle.bold = true;
			password = true;
			var l__12:* = p__1.myriad;
			btnSubmitReport = new PokerButton(l__12, "large", "Submit", null, 125, 5);
			btnCancelReport = new PokerButton(l__12, "large", "Cancel", null, 125, 5);
			btnSubmitReport.x = 195;
			btnCancelReport.x = 50;
			btnSubmitReport.y = 235;
			btnCancelReport.y = 235;
			addChild(btnSubmitReport);
			addChild(btnCancelReport);
			initListeners()
			
			reset();
		}
		private function initListeners():void
		{
			
			btnSubmitReport.addEventListener(MouseEvent.CLICK, onSubmitReport);
			btnCancelReport.addEventListener(MouseEvent.CLICK, onCancelReport);
		}
		private function onSubmitReport(p__1:flash.events.MouseEvent = null):void
		{	
			dispatchEvent(new PPVEvent(PPVEvent.ENTER_REPORT));
			
		}
		private function onCancelReport(p__1:flash.events.MouseEvent = null):void
		{	
			
			dispatchEvent(new PPVEvent(PPVEvent.CANCEL_REPORT));
			
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
			} else {
				field.setTextFormat(regStyle);
				field.displayAsPassword = false;
				field.y = 75;
			}
		}
		public function get value()
		{
			return(field.text);
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