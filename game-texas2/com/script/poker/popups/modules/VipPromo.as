// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.popups.modules
{
	import flash.events.*;
	import com.script.poker.popups.modules.events.*;
	import flash.display.*;
	import flash.text.*;
	import com.script.poker.table.asset.*;
	public class VipPromo extends flash.display.Sprite
	{
		public var btnEarnPass:*;
		private var fmt:flash.text.TextFormat;
		private var _isVip:Boolean;
		private var _snid:Number = 0;
		private var _isDisplayLobby:Boolean;
		public var pipe:*;
		private var _vipStatusMsg:Number = 0;
		public var btnCashIn:*;
		private var _days:Number = 0;
		public var field1:*;
		public var btnBuyChips:*;
		public function VipPromo()
		{
		}
		public function preflight(p__1:*)
		{
			var l__2:* = p__1.myriad;
			fmt = new flash.text.TextFormat();
			fmt.align = "center";
			var l__3:* = 295;
			btnEarnPass = new com.script.poker.table.asset.PokerButton(l__2, "large", "Earn a Free Pass", null, 200, 4);
			btnEarnPass.x = (l__3 - (btnEarnPass.width >> 2));
			btnEarnPass.y = 250;
			btnEarnPass.addEventListener(flash.events.MouseEvent.CLICK, onEarnPass);
			btnCashIn = new com.script.poker.table.asset.PokerButton(l__2, "large", "Cash In 1 Million Chips", null, 200, 4);
			btnCashIn.x = (l__3 - (btnCashIn.width >> 2));
			btnCashIn.y = 285;
			btnCashIn.addEventListener(flash.events.MouseEvent.CLICK, onCashIn);
			btnBuyChips = new com.script.poker.table.asset.PokerButton(l__2, "large", "Buy a Chip Package", null, 200, 4);
			btnBuyChips.x = (l__3 - (btnBuyChips.width >> 2));
			btnBuyChips.y = 320;
			btnBuyChips.addEventListener(flash.events.MouseEvent.CLICK, onBuyChips);
			var l__4:* = p__1.font1;
			var l__5:* = new l__4();
			field1 = l__5.field;
			field1.x = 200;
			field1.y = 25;
			field1.width = 270;
			field1.height = 250;
			addChild(field1);
			addButtons();
		}
		private function addButtons():void
		{
			addChild(btnEarnPass);
			addChild(btnCashIn);
			addChild(btnBuyChips);
		}
		private function onEarnPass(p__1:flash.events.MouseEvent):void
		{
			dispatchEvent(new com.script.poker.popups.modules.events.VIPEvent(com.script.poker.popups.modules.events.VIPEvent.VIP_EARN_PASS));
		}
		private function onCashIn(p__1:flash.events.MouseEvent):void
		{
			dispatchEvent(new com.script.poker.popups.modules.events.VIPEvent(com.script.poker.popups.modules.events.VIPEvent.VIP_CASH_IN));
		}
		private function onBuyChips(p__1:flash.events.MouseEvent):void
		{
			dispatchEvent(new com.script.poker.popups.modules.events.VIPEvent(com.script.poker.popups.modules.events.VIPEvent.VIP_BUY_CHIPS));
		}
		public function set days(p__1:Number)
		{
			_days = p__1;
		}
		public function set snid(p__1:Number)
		{
			_snid = p__1;
		}
		public function set vipStatusMsg(p__1:Number)
		{
			_vipStatusMsg = p__1;
		}
		public function set isVip(p__1:Boolean)
		{
			_isVip = p__1;
		}
		public function set isDisplayLobby(p__1:Boolean)
		{
			_isDisplayLobby = p__1;
			displayText();
		}
		public function displayText():void
		{
			resetButton();
			var l__1:* = "";
			var l__2:* = "";
			if (_isVip){
				if (_days > 7){
					if (_vipStatusMsg == 0){
						l__1 = (((("Your VIP Pass will remain active for " + _days) + " more day") + getS(_days)) + ".");
					} else {
						l__1 = getVipStatusMessage();
					}
					l__2 = getVipStatusTagMessage(1);
					initButton(1);
				} else if (_days <= 7){
					if (_days > 1){
						l__1 = (((("Your VIP Pass will remain active for " + _days) + " day") + getS(_days)) + ".");
					} else {
						l__1 = "Your VIP Pass will remain active for less than a day.";
					}
					l__2 = getVipStatusTagMessage(2);
					initButton(1);
				}
			} else {
				if (_vipStatusMsg > 0){
					l__1 = getVipStatusMessage();
				} else if (_vipStatusMsg == -5){
					l__1 = "Your friend is at a VIP table. Become a VIP!";
				} else {
					l__1 = "Become a VIP!";
				}
				l__2 = getVipStatusTagMessage(3);
				initButton(1);
			}
			field1.htmlText = (((("<font size=\'20\' color=\'#990000\'><b>" + l__1) + "</b></font><font size=\'14\'><br><br>") + l__2) + "</font>");
			field1.setTextFormat(fmt);
		}
		public function getVipStatusTagMessage(p__1:Number):String
		{
			var l__2:* = "VIPs get exclusive access to the VIP tables, increased daily chip bonuses, and the VIP badge.<br><br>Get more days as a VIP:";
			switch(p__1){
				case 1:
				{
					l__2 = "VIPs get exclusive access to the VIP tables, increased daily chip bonuses, and the VIP badge.<br><br>Get more days as a VIP:";
					break;
				}
				case 2:
				{
					l__2 = "Benefits:<ul><li>Access to our VIP Tables</li><li>20% higher daily-chip bonuses</li><li>and the VIP Bracelet</li></ul>";
					break;
				}
				case 3:
				{
					l__2 = "VIPs get exclusive access to the VIP tables, increased daily chip bonuses, and the VIP badge.<br><br>It\'s easy to earn a VIP pass:";
					break;
				}
			}
			return(l__2);
		}
		public function getVipStatusMessage():String
		{
			var l__1:* = "";
			switch(_vipStatusMsg){
				case 1:
				{
					if (_snid == 1){
						l__1 = (((("Congratulations, with 150+ friends on poker you received a VIP pass. You have " + _days) + " day") + getS(_days)) + " remaining.");
					} else if (_snid == 7){
						l__1 = (((("Congratulations, with 25+ friends on poker you received a VIP pass. You have " + _days) + " day") + getS(_days)) + " remaining.");
					}
					break;
				}
				case 2:
				{
					l__1 = (((("Congratulations, you received a VIP pass from a friend. You have " + _days) + " day") + getS(_days)) + " remaining.");
					break;
				}
				case 3:
				{
					l__1 = (((("Congratulations, by having 5 friends join you qualify for a VIP pass. You have " + _days) + " day") + getS(_days)) + " remaining.");
					break;
				}
				case 4:
				{
					l__1 = (((("Congratulations, you have purchased a VIP pass. You have " + _days) + " day") + getS(_days)) + " remaining.");
					break;
				}
				case 5:
				{
					l__1 = (((("Congratulations, by purchasing chips you qualify for a VIP pass. You have " + _days) + " day") + getS(_days)) + " remaining.");
					break;
				}
				case 6:
				{
					l__1 = "Your VIP pass has expired! Act now to rejoin the ranks of VIPs.";
					break;
				}
			}
			return(l__1);
		}
		public function getS(p__1:Number):String
		{
			if ((p__1) != 1){
				return("s");
			}
			return("");
		}
		public function resetButton():void
		{
			btnEarnPass.visible = true;
			btnEarnPass.changeText("Earn a Free Pass");
			btnCashIn.visible = true;
			btnCashIn.changeText("Cash In 1 Million Chips");
			btnBuyChips.visible = true;
			btnBuyChips.changeText("Buy a Chip Package");
		}
		public function initButton(p__1:Number):void
		{
			if ((p__1) == 1){
				if (_snid == 7){
					btnEarnPass.visible = false;
				}
				if (_snid == 4){
					btnBuyChips.visible = false;
				}
			} else if ((p__1) == 2){
				btnEarnPass.visible = false;
				btnCashIn.changeText("Go to a VIP Table");
				btnBuyChips.changeText("Go to Standard Lobby");
			} else if ((p__1) == 3){
			}
		}
	}
}