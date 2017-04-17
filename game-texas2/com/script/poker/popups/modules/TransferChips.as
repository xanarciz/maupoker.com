// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.popups.modules
{
	import flash.events.*;
	import com.script.format.*;
	import com.script.poker.popups.modules.events.*;
	import com.script.poker.table.asset.*;
	import com.script.poker.popups.events.*;
	import flash.display.*;
	import flash.text.TextField;
	public class TransferChips extends flash.display.MovieClip
	{
		public var myriad:Class;
		public var minmaxField:flash.text.TextField;
		public var btnTransCancel:com.script.poker.table.asset.PokerButton;
		private var _min:Number = 0;
		public var btnTransAccept:com.script.poker.table.asset.PokerButton;
		private var _balance:Number = 0;
		private var _max:Number = 0;
		private var _convert:Number = 0;
		public var bgbox:flash.display.MovieClip;
		private var _transfer:Number = 0;
		private var pokerChip:Number = 0;
		public var pipe:*;
		public var warner:flash.text.TextField;
		public var welcomeField:flash.text.TextField;
		public var field:flash.text.TextField;
		public var balanceField:flash.text.TextField;
		public function TransferChips()
		{
		
		}
		public function preflight(p__1:*)
		{
			var l__2:* = p__1.myriad;
			btnTransAccept = new PokerButton(l__2, "large", "Transfer", null, 125, 5);
			btnTransCancel = new PokerButton(l__2, "large", "Cancel", null, 125, 5);
			btnTransAccept.x = 195;
			btnTransCancel.x = 50;
			btnTransAccept.y = 235;
			btnTransCancel.y = 235;
			addChild(btnTransAccept);
			addChild(btnTransCancel);
			initListeners();
			field.restrict = "0-9";
		}
		private function initListeners():void
		{
			btnTransAccept.addEventListener(MouseEvent.CLICK, onTransAccept);
			btnTransCancel.addEventListener(MouseEvent.CLICK, onTransCancel);
			field.addEventListener(FocusEvent.FOCUS_IN, onFieldFocus);
			//field.addEventListener(KeyEvent)
		}
		private function removeListeners():void
		{
			btnTransAccept.removeEventListener(MouseEvent.CLICK, onTransAccept);
			btnTransCancel.removeEventListener(MouseEvent.CLICK, onTransCancel);
			field.removeEventListener(FocusEvent.FOCUS_IN, onFieldFocus);
		}
		private function onFieldFocus(p__1:flash.events.FocusEvent)
		{ 
			field.addEventListener(KeyboardEvent.KEY_UP, catchReturn); 
			//field.addEventListener(KeyboardEvent.KEY_DOWN, convReturn); 
		} 
		public function catchReturn(p__1:flash.events.KeyboardEvent):void
		{
			if ((p__1.charCode) == 13){
				onTransAccept();
			}
			else {
				
				onConvert();
				
			}
		}
		private function onTransAccept(p__1:flash.events.MouseEvent = null):void
		{
			if (validate()){
				field.removeEventListener(KeyboardEvent.KEY_UP, catchReturn);
				//dispatchEvent(new PPVEvent(PPVEvent.TRANS_ACCEPT));
				//dispatchEvent(new PPVEvent(PPVEvent.TRANS_ACCEPT, Number(field.text)));
				dispatchEvent(new TBEvent(TBEvent.TRANS_ACCEPT, 0, Number(field.text)));
			}
		}
		private function onConvert(p__1:flash.events.MouseEvent = null):void
		{
			
			if (_convert > 1) {
			pokerChip = Number(field.text)*Number(_convert);
			
			var l__4:String = StringUtility.StringToMoney(pokerChip);
			minmaxField.text = ("Convert To:\n PokerChip = " + l__4);
			}
		}
		private function onTransCancel(p__1:flash.events.MouseEvent):void
		{
			dispatchEvent(new TBEvent(TBEvent.TRANS_CANCEL));
			//dispatchEvent(new PPVEvent(PPVEvent.TRANS_CANCEL));
		}
		public function set minimum(p__1:Number)
		{
			_min = p__1;
			//renderText();
		}
		public function set maximum(p__1:Number)
		{
			_max = p__1;
			//renderText();			
		}
		public function set balance(p__1:Number)
		{
			_balance = p__1;
			renderText();
		}
		public function set convert(p__1:Number)
		{
			_convert = p__1;
			
			pokerChip=Number(field.text)*Number(_convert)
			renderText();
		}
		private function renderText()
		{
			var l__1:String = StringUtility.StringToMoney(_balance);
			var l__2:String = StringUtility.StringToMoney(_min);
			var l__3:String = StringUtility.StringToMoney(_max);
			var l__4:String = StringUtility.StringToMoney(pokerChip);
			balanceField.text = ("Your Account Balance:\n" + l__1);
			if (_convert > 1) {
			minmaxField.text = ("Convert To:\n PokerChip = " + l__4);
			}
			//minmaxField.text = ((("Minimum Buy In: " + l__2) + "\nMaximum Buy In: ") + l__3);
		}
		public function reset()
		{
			field.text = "";
			warner.text = "";
		}
		public function validate():Boolean
		{
			if ((field.text == "") || isNaN(field.text)){
				warner.text = "Please enter a valid Chip amount!";
				return(false);
			}
			var l__1:Number = Number(field.text);
			if (l__1 < 1){
				warner.text = "Please enter a valid Chip amount!";
				return(false);
			}
			/*if (l__1 > _max){
				warner.text = "That value is above the maximum buy-in.";
				return(false);
			}*/
			if (l__1 < _min){
				warner.text = "That value is below the minimum buy-in.";
				return(false);
			}
			if (l__1 > _balance){
				warner.text = "You do not have enough balance.";
				return(false);
			}
			warner.text = "";
			return(true);
		}
		public function set warning(p__1:String)
		{
			warner.text = p__1;
		}
		public function set transfer(p__1:Number)
		{
			field.text = p__1;
			_transfer = p__1;
		}
		public function setFieldFocus():void
		{
			field.stage.focus = field;
			field.setSelection(0, field.text.length);
		}
	}
}