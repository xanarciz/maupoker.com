// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.controls.listClasses
{
	import flash.net.*;
	import fl.controls.listClasses.*;
	import fl.core.UIComponent;
	import fl.controls.BaseButton;
	import fl.controls.LabelButton;
	import flash.display.*;
	import flash.events.*;
	import com.script.poker.protocol.SCreateBucketRoom;
	import com.script.poker.commonUI.events.*;
	import com.script.text.*;
	import com.script.poker.commonUI.asset.*;
	import flash.text.*;
	import com.script.display.*;
	public class FriendSelectorCell extends fl.controls.listClasses.CellRenderer
	{
		private var dimmerSprite:com.script.poker.controls.listClasses.MyFriendsCellDimmer;
		private var tf2:flash.text.TextFormat;
		private var roomDesc:flash.text.TextField;
		public var statusInd:com.script.poker.commonUI.asset.PlayerStatus;
		public var cta:com.script.poker.commonUI.asset.PlayerCTA;
		private var evtObj:flash.display.MovieClip;
		private var title:flash.text.TextField;
		public var statusField:com.script.text.TextBox;
		private var imgURL:String;
		public var ldrPic:com.script.display.SafeImageLoader;
		private var tf:flash.text.TextFormat;
		public var nameField:com.script.text.TextBox;
		private var textCont:flash.display.Sprite;
		public function FriendSelectorCell()
		{
			var l__2:flash.display.DisplayObject;
			setStyle("upSkin", FriendSelectorCellBg);
			setStyle("downSkin", FriendSelectorCellBg);
			setStyle("overSkin", FriendSelectorCellBg);
			setStyle("selectedUpSkin", FriendSelectorCellBg);
			setStyle("selectedDownSkin", FriendSelectorCellBg);
			setStyle("selectedOverSkin", FriendSelectorCellBg);
			setStyle("textOverlayAlpha", 0);
			ldrPic = new SafeImageLoader("../Avatar/default.jpg");
			ldrPic.contentLoaderInfo.addEventListener(Event.COMPLETE, onPicLoadComplete);
			ldrPic.mouseEnabled = false;
			statusInd = new PlayerStatus();
			statusInd.x = 3;
			statusInd.y = 26;
			addChild(statusInd);
			statusInd.mouseEnabled = false;
			statusInd.buttonMode = false;
			statusInd.mouseChildren = false;
			textCont = new Sprite();
			textCont.x = 66;
			textCont.y = 31;
			addChild(textCont);
			title = new TextField();
			title.autoSize = TextFieldAutoSize.CENTER;
			title.antiAliasType = AntiAliasType.ADVANCED;
			title.embedFonts = true;
			title.x = 66;
			title.y = 28;
			title.width = 165;
			title.multiline = false;
			title.wordWrap = true;
			title.selectable = false;
			addChild(title);
			textCont = new Sprite();
			textCont.x = 66;
			textCont.y = 31;
			addChild(textCont);
			nameField = new TextBox(myriadTF, "", 12, 0, "left");
			textCont.addChild(nameField);
			statusField = new TextBox(myriadTF, "", 10, 0, "left");
			statusField.y = 12;
			textCont.addChild(statusField);
			textCont.mouseEnabled = false;
			textCont.useHandCursor = false;
			cta = new PlayerCTA();
			
			cta.ctaLiveInvite["invited"].visible = false;
			cta.ctaLiveInvite["invite"].visible = true;
			cta.addEventListener(MouseEvent.CLICK, ctaFire);
			cta.useHandCursor = true;
			cta.buttonMode = true;
			var l__1:int;
			while(l__1 < cta.numChildren){
				l__2 = cta.getChildAt(l__1);
				l__2.visible = false;
				l__1++;
			}
			cta.x = 185;
			cta.y = 28;
			addChild(cta);
			dimmerSprite = new MyFriendsCellDimmer();
			useHandCursor = false;
			this.mouseChildren = true;
		}
		public function joinFire(event:MouseEvent) : void
        {
		
			
            dispatchEvent(new JoinUserEvent(CommonVEvent.JOIN_USER, data));
            return;
        }// end function

        public function inviteFire(event:MouseEvent) : void
        {
            dispatchEvent(new InviteUserEvent(CommonVEvent.INVITE_USER, data));
            cta.ctaLiveInvite["invited"].visible = true;
            cta.ctaLiveInvite["invite"].visible = false;
            return;
        }// end function
		
		public function ctaFire(p__1:flash.events.MouseEvent):void
		{
			switch(data.playStatus){
				case "lobby":
				{
					break;
				}
				case "shootout":
				{
					break;
				}
				case "join":
				{
					//dispatchEvent(new JoinUserEvent(CommonVEvent.JOIN_USER, data));
					break;
				}
			}
		}
		private function onPicLoadComplete(p__1:flash.events.Event):void
		{
			var l__6:Number = 0;
			var l__2:Number = 38;
			var l__3:Number = 29;
			var l__4:Number = 54;
			var l__5:Number = 54;
			if ((ldrPic.contentLoaderInfo.height > l__5) || (ldrPic.contentLoaderInfo.width > l__4)){
				l__6 = 1 / Math.max(ldrPic.height / l__5, ldrPic.width / l__4);
				ldrPic.scaleY *= l__6;
				ldrPic.scaleX *= l__6;
			}
			ldrPic.x = ((0 - (ldrPic.width >> 1)) + l__2);
			ldrPic.y = ((0 - (ldrPic.height >> 1)) + l__3);
			addChild(ldrPic);
		}
		override protected function drawLayout():void
		{
			var l__2:flash.net.URLRequest;
			var l__3:String;
			this.evtObj = data.evtObj;
			var l__1:Number = (getStyleValue("imagePadding") as Number);
			cta.ctaLiveInvite.useHandCursor = false;
            cta.ctaLiveInvite.buttonMode = false;
            cta.ctaLiveInvite.invited.useHandCursor = false;
            cta.ctaLiveInvite.invited.buttonMode = false;
            cta.ctaLiveInvite.invite.useHandCursor = true;
            cta.ctaLiveInvite.invite.buttonMode = true;
            cta.ctaLiveInvite.invite.addEventListener(MouseEvent.CLICK, inviteFire);
			if (data.label != null){
				nameField.updateText(data.label);
			}
			if (data.source != null){
				l__2 = new URLRequest(data.source);
				if (!(ldrPic.parent == this) || !(imgURL == data.source)){
					ldrPic.load(l__2);
				}
				imgURL = data.source;
			}
			if (data.invited != null)
            {
                if (data.invited == true)
                {
                    cta.ctaLiveInvite["invited"].visible = true;
                    cta.ctaLiveInvite["invite"].visible = false;
                }
                else
                {
                    cta.ctaLiveInvite["invited"].visible = false;
                    cta.ctaLiveInvite["invite"].visible = true;
                }
            }
			if (data.playStatus != null){
				textCont.y = 27;
				statusField.updateText(data.playStatus);
				l__3 = data.playStatus.toLowerCase();
				switch(l__3){
					case "join":
					{
						cta.ctaLiveInvite.visible = false;
                        cta.ctaLiveInvite.y = -21;
                        cta.ctaJoin.y = -11;
						statusInd.psOn.visible = true;
						statusInd.psOff.visible = false;
						cta.ctaJoin.visible = true;
						cta.ctaCards.visible = false;
						cta.ctaInvite.visible = false;
						cta.ctaNotify.visible = false;
						cta.buttonMode = true;
						cta.mouseEnabled = true;
						cta.useHandCursor = true;
						//cta.mouseChildren = true;
						//cta.addEventListener(MouseEvent.CLICK, ctaFire);
						cta.ctaJoin.addEventListener(MouseEvent.CLICK, joinFire);
						if (statusField != null){
							statusField.alpha = 0.7;
						}
						statusField.updateText(data.tableStakes);
						ldrPic.alpha = 1;
						textCont.alpha = 1;
						break;
					}
					case "liveinvite":
                    {
                        cta.ctaLiveInvite.visible = true;
                        cta.ctaLiveInvite.y = -21;
                        cta.ctaJoin.y = 1;
                        statusInd.psOn.visible = true;
                        statusInd.psOff.visible = false;
                        cta.ctaJoin.visible = true;
                        cta.ctaCards.visible = false;
                        cta.ctaInvite.visible = false;
                        cta.ctaNotify.visible = false;
                        cta.ctaJoin.addEventListener(MouseEvent.CLICK, joinFire);
                        if (statusField != null)
                        {
                            statusField.alpha = 0.7;
                        }
                        statusField.updateText(data.tableStakes);
                        ldrPic.alpha = 1;
                        textCont.alpha = 1;
                        break;
                    }
					case "table":
					{
						statusInd.psOn.visible = true;
						statusInd.psOff.visible = false;
						cta.ctaCards.visible = true;
						cta.ctaInvite.visible = false;
						cta.ctaJoin.visible = false;
						cta.ctaNotify.visible = false;
						cta.ctaLiveInvite.visible = false;
						cta.buttonMode = false;
						cta.mouseEnabled = false;
						//cta.mouseChildren = false;
						cta.useHandCursor = false;
						statusField.updateText("At This Table");
						ldrPic.alpha = 0.5;
						textCont.alpha = 0.5;
						cta.removeEventListener(MouseEvent.CLICK, ctaFire);
						break;
					}
					case "shootout":
                    {
                        statusInd.psOn.visible = true;
                        statusInd.psOff.visible = false;
                        cta.ctaCards.visible = false;
                        cta.ctaInvite.visible = false;
                        cta.ctaJoin.visible = false;
                        cta.ctaLiveInvite.visible = false;
                        cta.ctaNotify.visible = false;
                        ldrPic.alpha = 0.5;
                        textCont.alpha = 0.5;
                        statusField.updateText("Shootout");
                        if (statusField != null)
                        {
                            statusField.alpha = 0.7;
                        }
                        break;
                    }
                    case "showdown":
                    {
                        statusInd.psOn.visible = true;
                        statusInd.psOff.visible = false;
                        cta.ctaCards.visible = false;
                        cta.ctaInvite.visible = false;
                        cta.ctaLiveInvite.visible = false;
                        cta.ctaJoin.visible = false;
                        cta.ctaNotify.visible = false;
                        ldrPic.alpha = 0.5;
                        textCont.alpha = 0.5;
                        statusField.updateText("Showdown");
                        if (statusField != null)
                        {
                            statusField.alpha = 0.7;
                        }
                        break;
                    }
                    case "lobby":
                    {
                        statusInd.psOn.visible = true;
                        statusInd.psOff.visible = false;
                        cta.ctaCards.visible = false;
                        cta.ctaInvite.visible = false;
                        cta.ctaLiveInvite.visible = false;
                        cta.ctaLiveInvite.y = -11;
                        cta.ctaJoin.visible = false;
                        cta.ctaNotify.visible = false;
                        ldrPic.alpha = 0.5;
                        textCont.alpha = 0.5;
                        statusField.updateText("Lobby");
                        if (statusField != null)
                        {
                            statusField.alpha = 0.7;
                        }
                        break;
                    }
                    case "lobbyinvite":
                    {
                        statusInd.psOn.visible = true;
                        statusInd.psOff.visible = false;
                        cta.ctaCards.visible = false;
                        cta.ctaInvite.visible = false;
                        cta.ctaLiveInvite.visible = true;
                        cta.ctaLiveInvite.y = -11;
                        cta.ctaJoin.visible = false;
                        cta.ctaNotify.visible = false;
                        ldrPic.alpha = 0.5;
                        textCont.alpha = 0.5;
                        statusField.updateText("Lobby");
                        if (statusField != null)
                        {
                            statusField.alpha = 0.7;
                        }
                        break;
                    }
                    case "notify":
                    {
                        statusInd.psOn.visible = false;
                        statusInd.psOff.visible = true;
                        cta.ctaNotify.visible = true;
                        cta.ctaCards.visible = false;
                        cta.ctaInvite.visible = false;
                        cta.ctaJoin.visible = false;
                        break;
                    }
                    case "invite":
                    {
                        statusInd.psOn.visible = false;
                        statusInd.psOff.visible = true;
                        cta.ctaInvite.visible = true;
                        cta.ctaNotify.visible = false;

                        cta.ctaCards.visible = false;
                        cta.ctaJoin.visible = false;
                        textCont.alpha = 0.5;
                        break;
                    }
					case "otherinvite":
                    {
                        statusInd.psOn.visible = true;
                        statusInd.psOff.visible = false;
                        cta.ctaCards.visible = false;
                        cta.ctaInvite.visible = false;
                        cta.ctaLiveInvite.visible = true;
                        cta.ctaLiveInvite.y = -11;
                        cta.ctaJoin.visible = false;
                        cta.ctaNotify.visible = false;
                        ldrPic.alpha = 0.5;
                        textCont.alpha = 0.5;
                        statusField.updateText(data.tableStakes);
                        if (statusField != null)
                        {
                            statusField.alpha = 0.7;
                        }
                        break;
                    }
                    case "offline":
                    {
                        statusInd.psOn.visible = false;
                        statusInd.psOff.visible = true;
                        cta.ctaCards.visible = false;
                        cta.ctaInvite.visible = false;
                        cta.ctaJoin.visible = false;
                        cta.ctaNotify.visible = false;
                        statusField.updateText("");
                        textCont.alpha = 0.5;
                        break;
                    }
				}
			}
			textField.visible = false;
		}
	}
}