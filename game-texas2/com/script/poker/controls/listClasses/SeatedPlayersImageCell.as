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
	public class SeatedPlayersImageCell extends fl.controls.listClasses.CellRenderer
	{
		private var safeLoader:com.script.display.SafeImageLoader;
		private var tf:flash.text.TextFormat;
		private var _source:Object;
		private var title:flash.text.TextField;
		public function SeatedPlayersImageCell()
		{
			safeLoader = new SafeImageLoader("../images/s1.gif");
			safeLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onSafeLoaderComplete);
			addChild(safeLoader);
			setStyle("upSkin", CustomCellBg);
			setStyle("downSkin", CustomCellBg);
			setStyle("overSkin", CustomCellBg);
			setStyle("selectedUpSkin", CustomCellBg);
			setStyle("selectedDownSkin", CustomCellBg);
			setStyle("selectedOverSkin", CustomCellBg);
			setStyle("textOverlayAlpha", 0);
			title = new TextField();
			title.autoSize = TextFieldAutoSize.CENTER;
			title.antiAliasType = AntiAliasType.ADVANCED;
			title.x = 2;
			title.y = 54;
			title.width = 65;
			title.multiline = true;
			title.wordWrap = true;
			title.selectable = false;
			addChild(title);
			tf = new TextFormat();
			tf.font = "Tahoma";
			tf.color = 0;
			tf.size = 9;
			tf.align = "center";
			useHandCursor = false;
		}
		private function onSafeLoaderComplete(p__1:flash.events.Event):void
		{
			drawNow();
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
			title.text = data.label;
			title.setTextFormat(tf);
			textField.visible = false;
		}
	}
}