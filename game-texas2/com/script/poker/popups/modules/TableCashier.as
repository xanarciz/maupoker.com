// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.popups.modules
{
	import flash.events.*;
	import com.script.format.*;
	import com.script.poker.popups.modules.events.*;
	import com.script.poker.table.asset.*;
	import flash.display.*;
	import flash.text.TextField;
	public class TableCashier extends flash.display.MovieClip
	{
		public var myriad:Class;
		public var minmaxField:flash.text.TextField;
		public var btnBuyinCancel:com.script.poker.table.asset.PokerButton;
		private var _min:Number = 0;
		public var btnBuyinAccept:com.script.poker.table.asset.PokerButton;
		private var _balance:Number = 0;
		private var _max:Number = 0;
		private var _fee:Number = 0;
		public var bgbox:flash.display.MovieClip;
		private var _buyin:Number = 0;
		public var pipe:*;
		public var warner:flash.text.TextField;
		private var _sit:int;
		public var welcomeField:flash.text.TextField;
		public var field:flash.text.TextField;
		public var balanceField:flash.text.TextField;
		public var langs;
		public var txtbuyingame;
		public function TableCashier()
		{
		}
		public function preflight(p__1:*)
		{
			var l__2:* = p__1.myriad;
			txtbuyingame.text = langs.l_buyingame;
			btnBuyinAccept = new PokerButton(l__2, "large", langs.l_buy, null, 125, 5);
			btnBuyinCancel = new PokerButton(l__2, "large", langs.l_cancel, null, 125, 5);
			
			btnBuyinAccept.x = 195;
			btnBuyinCancel.x = 50;
			btnBuyinAccept.y = 235;
			btnBuyinCancel.y = 235;
			addChild(btnBuyinAccept);
			addChild(btnBuyinCancel);
			initListeners();
			field.restrict = "0-9";
		}
		private function initListeners():void
		{
			btnBuyinAccept.addEventListener(MouseEvent.CLICK, onBuyinAccept);
			btnBuyinCancel.addEventListener(MouseEvent.CLICK, onBuyinCancel);
			field.addEventListener(FocusEvent.FOCUS_IN, onFieldFocus);
		}
		private function removeListeners():void
		{
			btnBuyinAccept.removeEventListener(MouseEvent.CLICK, onBuyinAccept);
			btnBuyinCancel.removeEventListener(MouseEvent.CLICK, onBuyinCancel);
			field.removeEventListener(FocusEvent.FOCUS_IN, onFieldFocus);
		}
		private function onFieldFocus(p__1:flash.events.FocusEvent)
		{
			field.addEventListener(KeyboardEvent.KEY_UP, catchReturn);
		}
		public function catchReturn(p__1:flash.events.KeyboardEvent):void
		{
			if ((p__1.charCode) == 13){
				onBuyinAccept();
			}
		}
		private function onBuyinAccept(p__1:flash.events.MouseEvent = null):void
		{	
			if (validate()){
				
				field.removeEventListener(KeyboardEvent.KEY_UP, catchReturn);
				dispatchEvent(new TBEvent(TBEvent.BUYIN_ACCEPT, _sit, Number(field.text)));
			}
		}
		private function onBuyinCancel(p__1:flash.events.MouseEvent):void
		{
			dispatchEvent(new TBEvent(TBEvent.BUYIN_CANCEL));
		}
		public function set minimum(p__1:Number)
		{
			_min = p__1;
			renderText();
		}
		public function set maximum(p__1:Number)
		{
			_max = p__1;
			renderText();			
		}
		public function set balance(p__1:Number)
		{
			_balance = p__1;
			renderText();
		}
		public function set buyfee(p__1:Number)
		{
			_fee = p__1;
			renderText();			
		}
		private function renderText()
		{
			var l__1:String = StringUtility.StringToMoney(_balance);
			var l__2:String = StringUtility.StringToMoney(_min);
			var l__3:String = StringUtility.StringToMoney(_max);
			var l__4:String = StringUtility.StringToMoney(_fee);
			balanceField.text = (langs.l_currentbalance+":\n" + l__1);
			if (l__4 <= 0) {
				minmaxField.text = (((langs.l_min+" "+langs.l_buyin+": " + l__2) + "\n"+langs.l_max+" "+langs.l_buyin+": ") + l__3);
			}
			else {
				minmaxField.text = ((((langs.l_tablecost+": " + l__4) + "\n"+langs.l_min+" "+langs.l_buyin+": " + l__2) + "\n"+langs.l_max+" "+langs.l_buyin+": ") + l__3);
			}
		}
		public function reset()
		{
			field.text = "";
			warner.text = "";
		}
		public function validate():Boolean
		{
			if ((field.text == "") || isNaN(field.text)){
				warner.text = "Please enter a valid buy-in amount!";
				return(false);
			}
			var l__1:Number = Number(field.text);
			var l__2:Number = l__1+Number(_fee);
			if (l__1 < 1){
				warner.text = langs.l_validchip;
				return(false);
			}
			if (l__1 > _max){
				warner.text = langs.l_upchip;
				return(false);
			}
			if (l__1 < _min){
				warner.text = langs.l_lowchip;
				return(false);
			}
			if (l__2 > _balance){
				warner.text = langs.l_nochip;
				return(false);
			}
			warner.text = "";
			return(true);
		}
		public function set warning(p__1:String)
		{
			warner.text = p__1;
		}
		public function set buyin(p__1:Number)
		{
			field.text = p__1;
			_buyin = p__1;
		}
		public function set sit(p__1:int):void
		{
			_sit = p__1;
		}
		public function setFieldFocus():void
		{
			field.stage.focus = field;
			field.setSelection(0, field.text.length);
		}
	}
}