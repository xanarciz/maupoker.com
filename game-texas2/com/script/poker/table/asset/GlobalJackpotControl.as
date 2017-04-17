// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table.asset
{
	import flash.display.*;
	import flash.events.*;
	import com.script.poker.table.TableView;
	public class GlobalJackpotControl extends flash.display.MovieClip
	{
		public var whichChecked:com.script.poker.table.asset.CheckBoxJackpot = null;
		public var cbj1:com.script.poker.table.asset.CheckBoxJackpot;
		public var cbj2:com.script.poker.table.asset.CheckBoxJackpot;
		public var cbj3:com.script.poker.table.asset.CheckBoxJackpot;
		
		public function GlobalJackpotControl()
		{
			doSetupCheckBoxes();
		}
		public function doSetupCheckBoxes():void
		{

			cbj1.addEventListener(MouseEvent.CLICK, swapCheck);
			
			cbj2.addEventListener(MouseEvent.CLICK, swapCheck);
			
			cbj3.addEventListener(MouseEvent.CLICK, swapCheck);
		}
		
		
		public function swapCheck(p__1:flash.events.MouseEvent = null):void
		{
			var l__2:com.script.poker.table.asset.CheckBoxJackpot;
			var l__3:Number = 0;
			var l__4:flash.display.MovieClip;
			var l__5:Number = 0;	
			cbj1.init("");
			cbj2.init("");
			cbj3.init("");
			if ((p__1) == null){
				whichChecked = null;
				l__3 = 1;
				while(l__3 < 4){
					
					l__2 = this[("cbj" + l__3)];
					l__2.makeInactive();
					l__3++;
				}
			} else if (p__1.currentTarget.checked == true){
				trace("pass 2");
				l__4 = p__1.currentTarget;
				
				l__4.makeInactive();
				whichChecked = null;
			} else {
				trace("pass 3");
				l__5 = 1;
				l__4 = p__1.currentTarget;
				while(l__5 < 4){
					l__2 = this[("cbj" + l__5)];
					
					if (l__2 != l__4){
						l__2.makeInactive();
					} else {
						whichChecked = l__2;
						l__2.makeActive();
						
						if(l__5 == 1){
							
							cbj1.init("BJackpot1");
							cbj2.init("");
							cbj3.init("");
							
						}if(l__5 == 2){
							cbj2.init("BJackpot2");
							cbj1.init("");
							cbj3.init("");
							
						}if(l__5 == 3){
							cbj3.init("BJackpot3");
							cbj1.init("");
							cbj2.init("");
							
						}
						
					}
					l__5++;
				}
			}
		}
	}
}









