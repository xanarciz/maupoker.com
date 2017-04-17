// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package fl.controls.listClasses
{
	import fl.core.*;
	import fl.controls.*;
	import flash.display.*;
	import flash.events.*;
	import fl.containers.*;
	public class ImageCell extends fl.controls.listClasses.CellRenderer implements ICellRenderer
	{
		protected var loader:fl.containers.UILoader;
		protected var textOverlay:flash.display.Shape;
		private static var defaultStyles:Object = {imagePadding:1, textOverlayAlpha:0.7};
		public function ImageCell()
		{
			loader = new fl.containers.UILoader();
			loader.addEventListener(flash.events.IOErrorEvent.IO_ERROR, handleErrorEvent, false, 0, true);
			loader.autoLoad = true;
			loader.scaleContent = true;
			addChild(loader);
		}
		override public function get listData():fl.controls.listClasses.ListData
		{
			return(_listData);
		}
		override public function set listData(p__1:fl.controls.listClasses.ListData):void
		{
			var l__2:Object;
			_listData = p__1;
			label = _listData.label;
			l__2 = (_listData as fl.controls.listClasses.TileListData).source;
			if (source != l__2){
				source = l__2;
			}
		}
		public function get source():Object
		{
			return(loader.source);
		}
		public function set source(p__1:Object):void
		{
			loader.source = p__1;
		}
		override protected function configUI():void
		{
			var l__1:flash.display.Graphics;
			super.configUI();
			textOverlay = new flash.display.Shape();
			l__1 = textOverlay.graphics;
			l__1.beginFill(16777215);
			l__1.drawRect(0, 0, 100, 100);
			l__1.endFill();
		}
		override protected function draw():void
		{
			super.draw();
		}
		override protected function drawLayout():void
		{
			var l__1:Number;
			var l__2:Number;
			var l__3:Number;
			var l__4:Number;
			l__1 = (getStyleValue("imagePadding") as Number);
			loader.move(l__1, l__1);
			l__2 = (width - (l__1 * 2));
			l__3 = (height - (l__1 * 2));
			if (!(loader.width == l__2) && !(loader.height == l__3)){
				loader.setSize(l__2, l__3);
			}
			loader.drawNow();
			if ((_label == "") || (_label == null)){
				if (contains(textField)){
					removeChild(textField);
				}
				if (contains(textOverlay)){
					removeChild(textOverlay);
				}
			} else {
				l__4 = (getStyleValue("textPadding") as Number);
				textField.width = Math.min((width - (l__4 * 2)), (textField.textWidth + 5));
				textField.height = (textField.textHeight + 5);
				textField.x = Math.max(l__4, (width / 2 - (textField.width / 2)));
				textField.y = ((height - textField.height) - l__4);
				textOverlay.x = l__1;
				textOverlay.height = (textField.height + (l__4 * 2));
				textOverlay.y = ((height - textOverlay.height) - l__1);
				textOverlay.width = (width - (l__1 * 2));
				textOverlay.alpha = (getStyleValue("textOverlayAlpha") as Number);
				addChild(textOverlay);
				addChild(textField);
			}
			background.width = width;
			background.height = height;
		}
		protected function handleErrorEvent(p__1:flash.events.IOErrorEvent):void
		{
			dispatchEvent(p__1);
		}
		public static function getStyleDefinition():Object
		{
			return(mergeStyles(defaultStyles, fl.controls.listClasses.CellRenderer.getStyleDefinition()));
		}
	}
}