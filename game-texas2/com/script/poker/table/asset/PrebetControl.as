// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table.asset
{
	import flash.display.*;
	import flash.events.*;
	public class PrebetControl extends flash.display.MovieClip
	{
		public var whichChecked:com.script.poker.table.asset.CheckBoxButton = null;
		public var cb1:com.script.poker.table.asset.CheckBoxButton;
		public var cb3:com.script.poker.table.asset.CheckBoxButton;
		public var cb4:com.script.poker.table.asset.CheckBoxButton;
		public var cb2:com.script.poker.table.asset.CheckBoxButton;
		public var calltext;
		public var cektext;
		public var cekfoldtext;
		public var foldtext;
		public var raisetext;
		public function PrebetControl()
		{
			doSetupCheckBoxes();
		}
		public function doSetupCheckBoxes():void
		{
			
			
			cb1.init("Check");
			cb2.init("Fold");
			cb3.init("Call Any");
			cb4.init("Check/Fold");
			
			cb1.addEventListener(MouseEvent.CLICK, swapCheck);
			cb2.addEventListener(MouseEvent.CLICK, swapCheck);
			cb3.addEventListener(MouseEvent.CLICK, swapCheck);
			cb4.addEventListener(MouseEvent.CLICK, swapCheck);
		}
		public function changeText():void
		{
			cb1.btn.changeText(cektext);
			cb2.btn.changeText(foldtext);
			cb3.btn.changeText(calltext);
			cb4.btn.changeText(cekfoldtext);
			
		}
		public function swapCheck(p__1:flash.events.MouseEvent = null):void
		{
			
			
			
			var l__2:com.script.poker.table.asset.CheckBoxButton;
			var l__3:Number = 0;
			var l__4:flash.display.MovieClip;
			var l__5:Number = 0;
			
			if ((p__1) == null){
				
				whichChecked = null;
				l__3 = 1;
				while(l__3 < 5){
					
					l__2 = this[("cb" + l__3)];
					l__2.makeInactive();
					l__3++;
				}
				
			//} else if ((l__4 = p__1.currentTarget.checked) == true){
			} else if (p__1.currentTarget.checked == true){
				
				l__4 = p__1.currentTarget;
				
				l__4.makeInactive();
				whichChecked = null;
			} else {
				
				l__5 = 1;
				l__4 = p__1.currentTarget;
				while(l__5 < 5){
					l__2 = this[("cb" + l__5)];
					
					if (l__2 != l__4){
						l__2.makeInactive();
					} else {
						whichChecked = l__2;
						l__2.makeActive();
					}
					l__5++;
				}
			}
		}
	}
}