// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table.asset.chips
{
	import flash.display.*;
	import flash.events.*;
	public class ChipCalc extends flash.display.Sprite
	{
		public static var denominations:Array = [1000000000000, 100000000000, 25000000000, 10000000000, 1000000000, 500000000, 100000000, 25000000, 10000000, 5000000, 1000000, 100000, 50000, 25000, 10000, 5000, 1000, 500, 100, 25, 10, 5, 1];
		public function ChipCalc()
		{
		}
		public static function quantity(p__1:Number):Array
		{
			var l__5:Number = 0;
			var l__2:Number = p__1;
			var l__3:Array = new Array();
			var l__4:Number = 0;
			
			while(l__4 < denominations.length){
				l__5 = Math.floor(l__2 / denominations[l__4]);
				l__3.push(l__5);
				l__2 = (l__2 - (l__5 * denominations[l__4]));
				l__4++;
			}
			return(l__3);
		}
	}
}