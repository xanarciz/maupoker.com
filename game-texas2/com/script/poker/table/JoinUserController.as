// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.script.poker.table.asset.joinuser.*;
	public class JoinUserController
	{
		public var mt:com.script.poker.table.TableView;
		public var cont:flash.display.MovieClip;
		public var multi:Boolean = false;
		public var joinFriends:com.script.poker.table.asset.joinuser.JoinUserPanel;
		public var joinNetworks:com.script.poker.table.asset.joinuser.JoinUserPanel;
		public var panelCont:flash.display.Sprite;
		public var tnX:int = 522;
		public var tnY:int = 360;
		public var network:String;
		public var btnCont:flash.display.Sprite;
		public function JoinUserController(p__1:com.script.poker.table.TableView, p__2:flash.display.MovieClip):void
		{
			mt = p__1;
			cont = p__2;
			cont.visible = false;
			var l__3:Array = mt.ptModel.viewer.zid.split(":");
			network = l__3[0];
			if (network == "1"){
				multi = true;
			}
			initPanels();
			initListeners();
		}
		private function initPanels():void
		{
			joinFriends = new JoinUserPanel(mt, "friends", "My Friends", 220, 120, "left");
			joinFriends.x = tnX;
			joinFriends.y = tnY;
			cont.addChild(joinFriends);
			if (network == "1"){
				joinNetworks = new JoinUserPanel(mt, "networks", "Networks", 220, 120, "right");
				joinNetworks.x = tnX;
				joinNetworks.y = tnY;
				cont.addChildAt(joinNetworks, 0);
			}
		}
		private function initListeners():void
		{
			if (multi){
				joinFriends.hitSpot.addEventListener(MouseEvent.CLICK, swapPanels);
				joinNetworks.hitSpot.addEventListener(MouseEvent.CLICK, swapPanels);
			}
		}
		public function swapPanels(p__1:flash.events.MouseEvent = null):void
		{
			var l__2:com.script.poker.table.asset.joinuser.JoinUserPanel;
			var l__3:int;
			if ((p__1) != null){
				l__2 = p__1.currentTarget.parent;
				if (cont.getChildIndex(l__2) == 0){
					cont.swapChildrenAt(0, 1);
				}
			}
			if (((p__1) == null) && (network == "1")){
				l__3 = cont.getChildIndex(joinFriends);
				if (l__3 == 0){
					cont.swapChildrenAt(0, 1);
				}
			}
		}
		public function showPanels():void
		{
			var l__1:Boolean = cont.visible;
			cont.visible = !l__1;
		}
		public function closePanels():void
		{
			cont.visible = false;
		}
		public function updateJoinUserList(p__1:String):void
		{
			if ((p__1) == "friends"){
				joinFriends.populate();
			}
			if (((p__1) == "networks") && !(joinNetworks == null)){
				joinNetworks.populate();
			}
		}
		public function leaveTable():void
		{
			cont.removeChild(joinFriends);
			joinFriends = null;
			if (joinNetworks != null){
				cont.removeChild(joinNetworks);
				joinNetworks = null;
			}
		}
	}
}