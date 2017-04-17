// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table.asset
{
	import flash.events.Event;
	public class FormatCurrency
	{
		public function FormatCurrency()
		{
		}
		public static function giveMeDollars(p__1:Number):String
		{
			var l__5:Number = 0;
			if (isNaN(p__1)){
				return("0");
			}
			p__1 = Math.round((p__1) * 100) / 100;
			var l__2:String = String(p__1);
			var l__3:* = l__2.split(".");
			if (l__3[1] == undefined){
				l__3[1] = "00";
			}
			if (l__3[1].length == 1){
				l__3[1] = (l__3[1] + "0");
			}
			var l__4:Array = new Array();
			var l__6:Number = l__3[0].length;
			while(l__6 > 0){
				l__5 = Math.max((l__6 - 3), 0);
				l__4.unshift(l__3[0].slice(l__5, l__6));
				l__6 = l__5;
			}
			l__3[0] = l__4.join(",");
			var l__7:String = ("" + l__3.join("."));
			var l__8:String = l__7.substr(0, (l__7.length - 3));
			return(l__8);
		}
	}
}