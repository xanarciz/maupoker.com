// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.popups
{
	import flash.events.TimerEvent;
	public class PopupModel
	{
		public var aPopups:Array;
		public function PopupModel()
		{
			aPopups = new Array();
		}
		public function addPopup(p__1:com.script.poker.popups.Popup)
		{
			aPopups.push(p__1);
		}
		public function getPopupByEvent(p__1:String):com.script.poker.popups.Popup
		{
			var l__2:int;
			while(l__2 < aPopups.length){
				if (p__1 == aPopups[l__2].sEventName){
					return(aPopups[l__2]);
				}
				l__2++;
			}
		}
	}
}