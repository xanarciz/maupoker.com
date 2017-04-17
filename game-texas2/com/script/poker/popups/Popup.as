// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.popups
{
	import flash.display.DisplayObject;
	import com.script.poker.popups.modules.events.DSGBuyEvent;
	public class Popup
	{
		public var bHasModule:Boolean;
		public var moduleType:String;
		public var moduleRef:flash.display.DisplayObject;
		public var xmlDefinition:XML;
		public var sType:String;
		public var sEventName:String;
		public var aControllers:Array;
		public var sModuleClass:String;
		public var popupRef:Object;
		public function Popup(p__1:XML)
		{
			xmlDefinition = p__1;
		}
	}
}