// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.display.Dialog
{
	import flash.geom.*;
	import flash.display.*;
	public class DialogSkin
	{
		public var LeftBand:com.script.display.Dialog.DialogSkinItem;
		public var BottomRightCorner:com.script.display.Dialog.DialogSkinItem;
		public var TopBand:com.script.display.Dialog.DialogSkinItem;
		public var titleItem:*;
		public var bgOpacity:Number = 1;
		public var contentFilterList:Array;
		public var defaultPadding:Number = 10;
		public var RightBand:com.script.display.Dialog.DialogSkinItem;
		public var bodyItem:*;
		public var buttonPadding:Number = 8;
		public var TopLeftCorner:com.script.display.Dialog.DialogSkinItem;
		public var closeButton:*;
		public var bgBitmap:flash.display.BitmapData;
		public var TopRightCorner:com.script.display.Dialog.DialogSkinItem;
		public var filterlist:Array;
		public var bgColor:Number = 16777215;
		public var BottomBand:com.script.display.Dialog.DialogSkinItem;
		public var buttonTemplate:*;
		public var BottomLeftCorner:com.script.display.Dialog.DialogSkinItem;
		public var closeOffset:flash.geom.Point = new flash.geom.Point(15, 15);
		public var hideEffect:Function;
		public var defaultwidth:Number = 300;
		public var showEffect:Function;
		public static const STRETCH:Number = 0;
		public static const TILE:Number = 1;
		public function DialogSkin()
		{
		}
	}
}