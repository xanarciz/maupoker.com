// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.popups
{
	import flash.events.*;
	import flash.geom.*;
	import com.script.display.Dialog.*;
	import flash.display.*;
	import com.script.poker.popups.events.*;
	public class PopupDialogButton extends com.script.display.Dialog.DialogButton
	{
		public function PopupDialogButton(p__1:*, p__2:flash.geom.Point = null, p__3:Number = 4):void
		{
			button = p__1;
			action = p__3;
			offset = p__2;
			owner = this;
		}
		public function addEvent(classref:*, idref:*, popref:*)
		{
			var DEFunc = function(p__1:*)
			{
				com.script.display.Dialog.DialogEvent.quickThrow(com.script.display.Dialog.DialogEvent[idref], owner);
			};
			var PVFunc = function(p__1:*)
			{
				popref.dispatchEvent(new com.script.poker.popups.events.PPVEvent(com.script.poker.popups.events.PPVEvent[idref]));
			};
			switch(String(classref)){
				case "DialogEvent":
				{
					button.addEventListener(flash.events.MouseEvent.CLICK, DEFunc);
					break;
				}
				case "PPVEvent":
				{
					button.addEventListener(flash.events.MouseEvent.CLICK, PVFunc);
					break;
				}
			}
		}
	}
}