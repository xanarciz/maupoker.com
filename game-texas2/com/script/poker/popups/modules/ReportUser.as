// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.popups.modules
{
	import flash.events.*;
	import com.script.poker.popups.modules.events.*;
	import com.script.poker.table.asset.*;
	import flash.display.*;
	import flash.text.*;
	public class ReportUser extends flash.display.MovieClip
	{
		public var sZid:String;
		public var pipe:*;
		public var btnReport:*;
		public var warner:*;
		public var btnCancel:*;
		public var field:*;
		public function ReportUser()
		{
		}
		public function preflight(p__1:*)
		{
			var l__2:* = p__1.myriad;
			var l__3:* = p__1.buttonMedium;
			var l__4:* = p__1.font1;
			var l__5:* = new l__4();
			warner = l__5.field;
			var l__6:* = p__1.input1;
			var l__7:* = new l__6();
			field = l__7.field;
			field.x = 32;
			field.y = 66;
			field.width = 308;
			field.height = 90;
			addChild(field);
			warner.x = 49;
			warner.y = 162;
			warner.width = 275;
			warner.height = 19;
			addChild(warner);
			btnReport = new com.script.poker.table.asset.PokerButton(l__2, "medium", "Report", null, 125, 4);
			btnCancel = new com.script.poker.table.asset.PokerButton(l__2, "medium", "Cancel", null, 125, 4);
			btnReport.x = 195;
			btnCancel.x = 50;
			btnReport.y = 185;
			btnCancel.y = 185;
			addChild(btnReport);
			addChild(btnCancel);
			reset();
			initListeners();
		}
		private function initListeners():void
		{
			btnReport.addEventListener(flash.events.MouseEvent.CLICK, onReport);
			btnCancel.addEventListener(flash.events.MouseEvent.CLICK, onCancel);
			field.addEventListener(flash.events.FocusEvent.FOCUS_IN, onFieldFocus);
		}
		private function removeListeners():void
		{
			btnReport.removeEventListener(flash.events.MouseEvent.CLICK, onReport);
			btnCancel.removeEventListener(flash.events.MouseEvent.CLICK, onCancel);
			field.removeEventListener(flash.events.FocusEvent.FOCUS_IN, onFieldFocus);
		}
		private function onFieldFocus(evt:flash.events.FocusEvent)
		{
			var catchReturn:Function;
			catchReturn = function(p__1:flash.events.KeyboardEvent):void
			{
				if ((p__1.charCode) == 13){
					onReport();
					field.removeEventListener(flash.events.KeyboardEvent.KEY_UP, catchReturn);
				}
			};
			reset();
			field.addEventListener(flash.events.KeyboardEvent.KEY_UP, catchReturn);
		}
		private function onReport(p__1:flash.events.MouseEvent = null):void
		{
			if (validate()){
				dispatchEvent(new com.script.poker.popups.modules.events.RUEvent(com.script.poker.popups.modules.events.RUEvent.REPORTUSER, sZid, field.text));
			}
		}
		private function onCancel(p__1:flash.events.MouseEvent):void
		{
			dispatchEvent(new com.script.poker.popups.modules.events.RUEvent(com.script.poker.popups.modules.events.RUEvent.CANCEL));
		}
		public function reset():void
		{
			field.text = "";
			warner.text = "";
		}
		private function validate():Boolean
		{
			var l__1:* = undefined;
			if (field.text == ""){
				warner.htmlText = "<font color=\'#FF0000\'>Please provide a valid reason!</font>";
				l__1 = new flash.text.TextFormat();
				l__1.align = "center";
				warner.setTextFormat(l__1);
				return(false);
			}
			return(true);
		}
		public function setFieldFocus():void
		{
			field.stage.focus = field;
		}
	}
}