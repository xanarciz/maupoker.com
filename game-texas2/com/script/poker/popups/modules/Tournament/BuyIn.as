// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.popups.modules.Tournament
{
	import com.script.format.*;
	import flash.display.*;
	import flash.text.*;
	import flash.events.*;
	public class BuyIn extends flash.display.Sprite
	{
		private var _prizes:String;
		private var _total:Number = 0;
		public var mainInfo:flash.text.TextField;
		private var _table:String;
		private var _blind:Number = 0;
		public var subInfo:flash.text.TextField;
		public var _sit:int = -1;
		private var _balance:Number = 0;
		public var pipe:*;
		private var _tournFee:Number = 0;
		private var _players:Number = 0;
		private var _hostFee:Number = 0;
		public function BuyIn()
		{
		}
		public function set sit(p__1:int)
		{
			_sit = p__1;
		}
		public function set tableName(p__1:String)
		{
			_table = p__1;
			updateMain();
		}
		public function set blindInterval(p__1:Number)
		{
			_blind = p__1;
			updateMain();
		}
		public function set prizes(p__1:Array)
		{
			var l__3:* = undefined;
			_prizes = "";
			var l__2:Number = 1;
			for each (l__3 in p__1){
				_prizes = (_prizes + (((com.script.format.StringUtility.GetOrdinal(l__2++) + ": ") + l__3) + "%<br>"));
			}
			updateMain();
		}
		public function set players(p__1:Number)
		{
			_players = p__1;
		}
		public function set tournamentFee(p__1:Number)
		{
			_tournFee = p__1;
			updateSub();
		}
		public function set hostFee(p__1:Number)
		{
			_hostFee = p__1;
			updateSub();
		}
		public function set balance(p__1:Number)
		{
			_balance = p__1;
			updateSub();
		}
		public function get sit()
		{
			return(_sit);
		}
		public function get total()
		{
			var l__1:* = (_hostFee + _tournFee);
			return(l__1);
		}
		public function updateMain()
		{
			mainInfo.htmlText = (((((((("<b><font size=\'10\'>You are buying into table:</font></b><br/><b><font size=\'20\' color=\'#003299\'>\"" + _table) + "\"</font></b><br>") + _players) + " Players Tournament<br>The blind increases every <b>") + _blind) + "</b> minutes.<br><br>Tournament Prizes:<br><b>") + _prizes) + "</b>");
		}
		public function updateSub()
		{
			var l__1:String = com.script.format.StringUtility.StringToMoney(_tournFee);
			var l__2:String = com.script.format.StringUtility.StringToMoney(_hostFee);
			var l__3:String = com.script.format.StringUtility.StringToMoney(total);
			var l__4:String = com.script.format.StringUtility.StringToMoney(_balance);
			subInfo.htmlText = (((((((("<b><font size=\'15\'>Buy-In Details:</font></b><br>Tournament Fee: <b>" + l__1) + "</b><br>Host Fee: <b>$") + l__2) + "</b><br><b><font size=\'13\' color=\'#CC0000\'>Total Fees: $") + l__3) + "</font></b><br><br>Account Balance: <b>$") + l__4) + "</b>");
		}
	}
}