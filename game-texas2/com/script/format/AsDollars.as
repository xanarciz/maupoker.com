// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.format
{
	public class AsDollars
	{
		public function AsDollars()
		{
		}
		public static function giveMe(p__1:Number, p__2:Boolean = false, p__3:Boolean = false):String
		{
			var l__7:Number = 0;
			var l__10:String;
			var l__11:String;
			var l__12:Number = 0;
			var l__13:String;
			var l__14:String;
			var l__15:String;
			var l__16:String;
			var l__17:String;
			var l__18:String;
			if (isNaN(p__1)){
				return("0");
			}
			p__1 = Math.round((p__1) * 100) / 100;
			var l__4:String = String(p__1);
			var l__5:* = l__4.split(".");
			if (l__5[1] == undefined){
				l__5[1] = "00";
			}
			if (l__5[1].length == 1){
				l__5[1] = (l__5[1] + "0");
			}
			var l__6:Array = new Array();
			var l__8:Number = l__5[0].length;
			while(l__8 > 0){
				l__7 = Math.max((l__8 - 3), 0);
				l__6.unshift(l__5[0].slice(l__7, l__8));
				l__8 = l__7;
			}
			l__5[0] = l__6.join(",");
			var l__9:String = ("" + l__5.join("."));
			if (p__3){
				l__10 = l__9;
			}
			if (!(p__3)){
				l__10 = l__9.substr(0, (l__9.length - 3));
			}
			if ((p__2) == true){
				if (l__10.length <= 8){
					return(l__10);
				}
				if (l__10.length > 8){
					l__12 = p__1;
					if ((l__12 >= 1000000) && (l__12 < 1000000000)){
						l__13 = l__12.toString();
						l__14 = l__13.substr(0, (l__13.length - 5));
						l__11 = (((("" + l__14.substr(0, l__14.length - 1)) + ".") + l__14.substr(l__14.length - 1, l__14.length)) + " M");
					} else if ((l__12 >= 1000000000) && (l__12 < 1000000000000)){
						l__15 = l__12.toString();
						l__16 = l__15.substr(0, (l__15.length - 8));
						l__11 = (((("" + l__16.substr(0, l__16.length - 1)) + ".") + l__16.substr(l__16.length - 1, l__16.length)) + " B");
					} else if ((l__12 >= 1000000000000) && (l__12 < 1e+015)){
						l__17 = l__12.toString();
						l__18 = l__17.substr(0, (l__17.length - 11));
						l__11 = (((("" + l__18.substr(0, l__18.length - 1)) + ".") + l__18.substr(l__18.length - 1, l__18.length)) + " T");
					}
					l__10 = l__11;
				}
			}
			return(l__10);
		}
	}
}