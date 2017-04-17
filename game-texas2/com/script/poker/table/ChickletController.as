// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table
{
	import com.script.poker.PokerUser;
	import com.script.poker.table.asset.Chicklet;
	public class ChickletController
	{
		public var mt:com.script.poker.table.TableView;
		public function ChickletController(p__1:com.script.poker.table.TableView)
		{
			mt = p__1;
		}
		public function chickletPressed(p__1:int):void
		{
			var l__2:com.script.poker.table.asset.Chicklet = mt[("dp" + p__1)];
		}
		public function chickletRollOver(p__1:int):void
		{
		}
		public function chickletRollOut(p__1:Number):void
		{
		}
		public function playerSat(p__1:com.script.poker.table.asset.Chicklet, p__2:com.script.poker.PokerUser, p__3:Boolean):void
		{
			var l__4:com.script.poker.table.asset.Chicklet = p__1;
			var l__5:com.script.poker.PokerUser = p__2;
			l__4.setPlayerInfo(l__5.sPicURL, l__5.sUserName.split(" ")[0], l__5.nAchievementRank, l__5.nChips, l__5.bIsVip, p__3, l__5.zid);
			l__4.showInfo();
		}
		public function setSeating(p__1:int, p__2:Boolean):void
		{
			var l__3:com.script.poker.table.asset.Chicklet = mt[("dp" + p__1)];
			l__3.isSeated = p__2;
		}
		public function setAlpha(p__1:int, p__2:Number):void
		{
			var l__3:com.script.poker.table.asset.Chicklet = mt[("dp" + p__1)];
			l__3.alpha = p__2;
		}
		public function clearAvailableSits():void
		{
			var l__1:com.script.poker.table.asset.Chicklet;
			var l__2:Number = 0;
			var l__2 = 0;
			while(l__2 < 9){
				l__1 = mt[("dp" + l__2)];
				if (!l__1.isSeated){
					l__1.showLeave();
				}
				l__2++;
			}
		}
		public function clearSit(p__1:int):void
		{
			var l__2:com.script.poker.PokerUser = mt.ptModel.getUserByZid(mt.ptModel.viewer.zid);
			var l__3:com.script.poker.table.asset.Chicklet = mt[("dp" + p__1)];
			l__3.updateChips();
			l__3.updateRank();
			l__3.stopHighlight();
			if (!(l__2 == null) && ((p__1) == l__2.nSit)){
				l__3.showLeave();
			} else {
				l__3.showSit();
			}
		}
		public function showSit(p__1:int):void
		{
			var l__2:com.script.poker.table.asset.Chicklet = mt[("dp" + p__1)];
			l__2.showSit();
		}
		public function showLeave(p__1:int):void
		{
			var l__2:com.script.poker.table.asset.Chicklet = mt[("dp" + p__1)];
			l__2.showLeave();
		}
		public function showAvailableSits():void
		{
			var l__1:com.script.poker.table.asset.Chicklet;
			var l__2:Number = 0;
			while(l__2 < 9){
				l__1 = mt[("dp" + l__2)];
				if (!l__1.isSeated){
					l__1.showSit();
				}
				l__2++;
			}
		}
		public function showTurn(p__1:int):void
		{
			var l__2:com.script.poker.table.asset.Chicklet;
			var l__3:Number = 0;
			while(l__3 < 9){
				l__2 = mt[("dp" + l__3)];
				l__2.stopHighlight();
				l__3++;
			}
			l__2 = mt[("dp" + p__1)];
			l__2.showHighlight();
			lastTurnID = p__1;
		}
		public function stopTurn():void
		{
			var l__1:com.script.poker.table.asset.Chicklet;
			var l__2:Number = 0;
			while(l__2 < 9){
				l__1 = mt[("dp" + l__2)];
				l__1.stopHighlight();
				l__2++;
			}
		}
		public function setPlayerAction(p__1:int, p__2:String, p__3:Number = -1):void
		{
			var l__4:com.script.poker.table.asset.Chicklet = mt[("dp" + p__1)];
		}
		public function resetSitAction(p__1:int):void
		{
			var l__2:com.script.poker.table.asset.Chicklet = mt[("dp" + p__1)];
		}
		public function updateChips(p__1:int, p__2:Number):void
		{
			var l__3:com.script.poker.table.asset.Chicklet = mt[("dp" + p__1)];
			
			l__3.updateChips(p__2);
		}
		public function updateRank(p__1:int, p__2:int):void
		{
			var l__3:com.script.poker.table.asset.Chicklet = mt[("dp" + p__1)];
			l__3.updateRank(p__2);
		}
		public function startClock(p__1:Number, p__2:int, p__3:*):void
		{
			var l__4:com.script.poker.PokerUser = mt.ptModel.getUserByZid(mt.ptModel.viewer.zid);
			var l__5:com.script.poker.table.asset.Chicklet = mt[("dp" + p__2)];
			mt.clock.startCount(p__1, p__2, p__3);
			if (!(l__4 == null) && ((p__2) == l__4.nSit)){
			}
		}
		public function stopClock(p__1:int):void
		{
			if ((p__1) == mt.clock.curSit){
				mt.clock.stopCount();
			}
		}
		public function setVIP(p__1:int, p__2:Boolean):void
		{
			var l__3:com.script.poker.table.asset.Chicklet = mt[("dp" + p__1)];
			l__3.thisVip = p__2;
			
			if (p__2){
				l__3.vipBadge.visible = true;
				//l__3.vipBadge.visible = false;
			} else if (!(p__2)){
				l__3.vipBadge.visible = false;
			}
		}
		public function resetChicklets():void
		{
			var l__2:com.script.poker.table.asset.Chicklet;
			var l__1:int;
			while(l__1 < 9){
				l__2 = mt[("dp" + l__1)];
				l__2.alpha = 1;
				
				l__1++;
			}
		}
		public function setColor(p__1:int, p__2:String):void
		{
			var l__3:com.script.poker.table.asset.Chicklet = mt[("dp" + p__1)];
		}
	}
}