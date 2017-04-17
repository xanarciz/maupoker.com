// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.controls.listClasses
{
	import fl.controls.listClasses.*;
	import fl.core.UIComponent;
	import fl.controls.BaseButton;
	import fl.controls.LabelButton;
	import flash.display.InteractiveObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.net.*;
	import flash.text.*;
	import com.script.display.*;
	public class MyFriendsImageCell extends fl.controls.listClasses.CellRenderer
	{
		private var safeLoader:com.script.display.SafeImageLoader;
		private var tf2:flash.text.TextFormat;
		private var roomDesc:flash.text.TextField;
		private var tf:flash.text.TextFormat;
		private var dimmerSprite:com.script.poker.controls.listClasses.MyFriendsCellDimmer;
		private var title:flash.text.TextField;
		private var _source:Object;
		public function MyFriendsImageCell()
		{
			safeLoader = new SafeImageLoader("../Avatar/default.jpg");
			safeLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onSafeLoaderComplete);
			addChild(safeLoader);
			setStyle("upSkin", CustomCellBg);
			setStyle("downSkin", CustomCellBg);
			setStyle("overSkin", CustomCellBgOver);
			setStyle("selectedUpSkin", CustomCellBgSelected);
			setStyle("selectedDownSkin", CustomCellBgSelected);
			setStyle("selectedOverSkin", CustomCellBgOver);
			setStyle("textOverlayAlpha", 0);
			title = new TextField();
			title.autoSize = TextFieldAutoSize.CENTER;
			title.antiAliasType = AntiAliasType.ADVANCED;
			title.x = 4;
			title.y = 54;
			title.width = 65;
			title.multiline = true;
			title.wordWrap = true;
			title.selectable = false;
			addChild(title);
			roomDesc = new TextField();
			roomDesc.autoSize = TextFieldAutoSize.CENTER;
			roomDesc.antiAliasType = AntiAliasType.ADVANCED;
			roomDesc.x = title.x;
			roomDesc.y = ((title.y + title.height) + 20);
			roomDesc.width = 65;
			roomDesc.multiline = true;
			roomDesc.wordWrap = true;
			roomDesc.selectable = false;
			addChild(roomDesc);
			tf = new TextFormat();
			tf.font = "Tahoma";
			tf.color = 0;
			tf.size = 9;
			tf.bold = true;
			tf.align = "center";
			tf2 = new TextFormat();
			tf2.bold = false;
			tf2.font = "Tahoma";
			tf2.color = 0;
			tf2.size = 9;
			tf2.align = "center";
			dimmerSprite = new MyFriendsCellDimmer();
			useHandCursor = true;
		}
		private function onSafeLoaderComplete(p__1:flash.events.Event):void
		{
			drawLayout();
		}
		public function get source():Object
		{
			return(this._source);
		}
		public function set source(p__1:Object):void
		{
			if (!(p__1)){
				p__1 = "../Avatar/default.jpg";
			}
			if (this._source != (p__1)){
				this._source = p__1;
				safeLoader.load(((p__1) is String) ? (new URLRequest(p__1)) : (p__1));
			}
		}
		override protected function drawLayout():void
		{
			if (data.source == null){
				data.source = "../Avatar/default.jpg";
			}
			if (data.source != null){
				this.source = data.source;
			}
			var l__1:Number = (getStyleValue("imagePadding") as Number);
			safeLoader.x = 10;
			safeLoader.y = 5;
			safeLoader.mouseEnabled = false;
			safeLoader.width = 50;
			safeLoader.height = 50;
			if (data.label != null){
				title.text = data.label;
				title.setTextFormat(tf);
				title.autoSize = TextFieldAutoSize.CENTER;
			}
			if (data.playStatus != "Texas room"){
				useHandCursor = true;
				tf.italic = false;
				title.setTextFormat(tf);
				useHandCursor = true;
				if (data.playStatus != null){
					roomDesc.text = data.playStatus;
					roomDesc.autoSize = TextFieldAutoSize.CENTER;
					roomDesc.y = (title.y + title.height);
				}
				setStyle("overSkin", CustomCellBgOver);
				setStyle("selectedUpSkin", CustomCellBgSelected);
				setStyle("selectedDownSkin", CustomCellBgSelected);
				setStyle("selectedOverSkin", CustomCellBgOver);
				if (dimmerSprite.parent != null){
					dimmerSprite.parent.removeChild(dimmerSprite);
				}
			} else {
				roomDesc.text = "Texas room";
				roomDesc.autoSize = TextFieldAutoSize.CENTER;
				roomDesc.y = (title.y + title.height);
				if (dimmerSprite.parent == null){
					addChild(dimmerSprite);
				}
				setStyle("overSkin", CustomCellBg);
				setStyle("selectedUpSkin", CustomCellBg);
				setStyle("selectedDownSkin", CustomCellBg);
				setStyle("selectedOverSkin", CustomCellBg);
				useHandCursor = false;
				dimmerSprite.mouseEnabled = false;
				dimmerSprite.buttonMode = false;
				tf.italic = true;
				title.setTextFormat(tf);
			}
			roomDesc.setTextFormat(tf2);
			textField.visible = false;
		}
	}
}