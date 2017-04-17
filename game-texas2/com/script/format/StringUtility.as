// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.format
{
	import com.script.poker.PokerUser;
	public class StringUtility
	{
		public function StringUtility()
		{
		}
		public static function GetOrdinal(p__1:Number):String
		{
			var l__3:* = undefined;
			var l__4:* = undefined;
			var l__5:* = undefined;
			var l__2:String = String(p__1);
			if (l__2.length < 1){
				l__3 = l__2.charAt(0);
			} else {
				l__3 = l__2.charAt(l__2.length - 1);
				l__4 = (l__2.charAt(l__2.length - 2) + l__3);
			}
			switch(l__3){
				case "1":
				{
					l__5 = "st";
					break;
				}
				case "2":
				{
					l__5 = "nd";
					break;
				}
				case "3":
				{
					l__5 = "rd";
					break;
				}
				default:
				{
					l__5 = "th";
				}
			}
			switch(l__4){
				case "11":
				{
				}
				case "12":
				{
				}
				case "13":
				{
					l__5 = "th";
					break;
				}
			}
			return(p__1 + l__5);
		}
		public static function LimitString(p__1:Number, p__2:String, p__3:String)
		{
			var l__4:String;
			if ((p__2.length) > (p__1)){
				l__4 = (p__2).substring(0, p__1);
				return(l__4 + p__3);
			}
			return(p__2);
		}
		public static function TrunkateByWord(p__1:Number = 10, p__2:String = null, p__3:String = "...")
		{
			var l__4:Array = (p__2).split(" ");
			if (l__4.length <= 1){
				return(LimitString(p__1, p__2, p__3));
			}
			var l__5:Number = -1;
			var l__6:* = -1;
			l__5 = (p__2).indexOf(" ", (l__5 + 1));
			while(l__5 >= 0){
				if (l__5 <= (p__1)){
					l__6 = l__5;
				} else {
					break;
				}
				l__5 = (p__2).indexOf(" ", (l__5 + 1));
			}
			if (l__6 < 0){
				return(LimitString(p__1, p__2, p__3));
			}
			var l__7:* = "";
			var l__8:* = "";
			var l__9:*;
			while(l__9 < l__4.length){
				l__7 = (l__7 + l__4[l__9]);
				if (l__7.length > (p__1)){
					if (l__8 != ""){
						return(l__8);
					}
					return(LimitString(p__1, p__2, p__3));
				}
				l__7 = (l__7 + " ");
				l__8 = l__7;
				l__9++;
			}
			return(LimitString(p__1, p__2, p__3));
		}
		public static function StringToMoney(p__1:Number, p__2:Boolean = false, p__3:int = 4, p__4:Boolean = true, p__5:Number = 1):String
		{
			var l__9:Number = 0;
			var l__13:String;
			var l__14:String;
			var l__15:Number = 0;
			var l__16:String;
			var l__17:String;
			var l__18:* = undefined;
			var l__19:* = undefined;
			var l__20:String;
			var l__21:String;
			var l__22:String;
			var l__23:String;
			var l__24:String;
			var l__25:String;
			if (isNaN(p__1)){
				return("0");
			}
			p__1 = Math.round((p__1) * 100) / 100;
			var l__6:String = String(p__1);
			var l__7:* = l__6.split(".");
			if (l__7[1] == undefined){
				l__7[1] = "00";
			}
			if (l__7[1].length == 1){
				l__7[1] = (l__7[1] + "0");
			}
			var l__8:Array = new Array();
			var l__10:Number = l__7[0].length;
			while(l__10 > 0){
				l__9 = Math.max((l__10 - 3), 0);
				l__8.unshift(l__7[0].slice(l__9, l__10));
				l__10 = l__9;
			}
			l__7[0] = l__8.join(",");
			var l__11:String = l__7.join(".");
			var l__12:String = l__11.substr(0, (l__11.length - 3));
			if ((p__2) == true){
				if (l__12.length < (p__3 + 1)){
					return(l__12);
				}
				l__13 = (p__4) ? " " : "";
				if (l__12.length > (p__3)){
					l__15 = p__1;
					if ((l__15 >= 1000) && (l__15 < 1000000)){
						l__16 = l__15.toString();
						l__17 = l__16.substr(0, (l__16.length - 2));
						l__18 = l__17.substr(0, l__17.length - 1);
						l__19 = l__17.substr(l__17.length - 1, l__17.length);
						if (l__19 == "0"){
							l__14 = l__18;
						} else {
							l__14 = ((l__18 + ".") + l__19);
						}
						l__14 = (l__14 + l__13);
						switch(p__5){
							case 0:
							{
								break;
							}
							case 1:
							{
								l__14 = (l__14 + "K");
								break;
							}
							case 3:
							{
								l__14 = (l__14 + "K");
								break;
							}
							default:
							{
								l__14 = (l__14 + "K");
								break;
							}
						}
					} else if ((l__15 >= 1000000) && (l__15 < 1000000000)){
						l__20 = l__15.toString();
						l__21 = l__20.substr(0, (l__20.length - 5));
						l__14 = ((l__21.substr(0, l__21.length - 1) + ".") + l__21.substr(l__21.length - 1, l__21.length));
						l__14 = (l__14 + l__13);
						switch(p__5){
							case 0:
							{
								break;
							}
							case 1:
							{
								l__14 = (l__14 + "M");
								break;
							}
							case 3:
							{
								l__14 = (l__14 + "Mil");
								break;
							}
							default:
							{
								l__14 = (l__14 + "Million");
								break;
							}
						}
					} else if ((l__15 >= 1000000000) && (l__15 < 1000000000000)){
						l__22 = l__15.toString();
						l__23 = l__22.substr(0, (l__22.length - 8));
						l__14 = ((l__23.substr(0, l__23.length - 1) + ".") + l__23.substr(l__23.length - 1, l__23.length));
						l__14 = (l__14 + l__13);
						switch(p__5){
							case 0:
							{
								break;
							}
							case 1:
							{
								l__14 = (l__14 + "B");
								break;
							}
							case 3:
							{
								l__14 = (l__14 + "Bil");
								break;
							}
							default:
							{
								l__14 = (l__14 + "Billion");
								break;
							}
						}
					} else if ((l__15 >= 1000000000000) && (l__15 < 1e+015)){
						l__24 = l__15.toString();
						l__25 = l__24.substr(0, (l__24.length - 11));
						l__14 = ((l__25.substr(0, l__25.length - 1) + ".") + l__25.substr(l__25.length - 1, l__25.length));
						l__14 = (l__14 + l__13);
						switch(p__5){
							case 0:
							{
								break;
							}
							case 1:
							{
								l__14 = (l__14 + "T");
								break;
							}
							case 3:
							{
								l__14 = (l__14 + "Tril");
								break;
							}
							default:
							{
								l__14 = (l__14 + "Trillion");
								break;
							}
						}
					}
					l__12 = l__14;
				}
			}
			return(l__12);
		}
		public static function FormatString(p__1:String, ... p__2):String
		{
			var l__6:Array;
			var l__3:String = String(p__1);
			var l__4:Array = new Array();
			var l__5:int;
			l__5 = 0;
			while(l__5 < (p__2.length)){
				l__4.push(p__2[l__5]);
				l__5++;
			}
			l__5 = 0;
			while(l__5 < l__4.length){
				if ((p__1).indexOf(l__4[l__5].sText) != -1){
					l__6 = l__3.split(l__4[l__5].sText);
					l__3 = l__6.join(l__4[l__5].nVar);
				}
				l__5++;
			}
			return(l__3);
		}
		public static function formatHtmlString(p__1:String, ... p__2):String
		{
			var l__6:Array;
			var l__7:uint;
			var l__8:String;
			var l__3:String = String(p__1);
			var l__4:Array = new Array();
			var l__5:int;
			l__5 = 0;
			while(l__5 < (p__2.length)){
				l__4.push(p__2[l__5]);
				l__5++;
			}
			l__5 = 0;
			while(l__5 < l__4.length){
				if ((p__1).indexOf(l__4[l__5].sText) != -1){
					l__6 = l__3.split(l__4[l__5].sText);
					if (l__4[l__5].nSit != null){
						l__7 = getUserColor(l__4[l__5].nSit);
						l__8 = (((("<font face=\"Verdana Bold\" color=\"#" + l__7.toString(16)) + "\">") + l__4[l__5].nVar) + "</font>");
						l__3 = l__6.join(l__8);
					} else {
						l__3 = l__6.join(l__4[l__5].nVar);
					}
				}
				l__5++;
			}
			return(l__3);
		}
		public static function addFontTag(p__1:String, p__2:String, p__3:Number = 0):String
		{
			var l__4:String;
			l__4 = (((((("<font face=\"" + p__2) + "\" color=\"#") + (p__3).toString(16)) + "\" >") + p__1) + "</font>");
			return(l__4);
		}
				public static function getUserColor(p__1:int):uint
		{
		
			var l__2:uint;
			switch(p__1){
				case 0:
				{
					l__2 = 8388608;
					break;
				}
				case 1:
				{
					l__2 = 25600;
					break;
				}
				case 2:
				{
					l__2 = 14933589;
					break;
				}
				case 3:
				{
					l__2 = 9055202;
					break;
				}
				case 4:
				{
					l__2 = 255;
					break;
				}
				case 5:
				{
					l__2 = 3329330;
					break;
				}
				case 6:
				{
					l__2 = 13789470;
					break;
				}
				case 7:
				{
					l__2 = 13047896;
					break;
				}
				case 8:
				{
					l__2 = 6525114;
					break;
				}
				case 9:
				{
					l__2 = 10399988;
					break;
				}
				case -1:
				{
					l__2 = 15252668;
					break;
				}
			}
			return(l__2);
		}
		public static function getCardSuit(p__1:String):Number
		{
			if ((p__1) == "d"){
				return(0);
			}
			if ((p__1) == "h"){
				return(1);
			}
			if ((p__1) == "c"){
				return(2);
			}
			if ((p__1) == "s"){
				return(3);
			}
			return(-1);
		}
		public static function getCardVal(p__1:String):String
		{
			if (((p__1).substr(0, 1) == "0") && !((p__1).substr(1, 1) == "1")){
				return((p__1).substr(1, 2));
			}
			if ((p__1) == "10"){
				return("10");
			}
			if ((p__1) == "11"){
				return("J");
			}
			if ((p__1) == "12"){
				return("Q");
			}
			if ((p__1) == "13"){
				return("K");
			}
			if ((p__1) == "01"){
				return("A");
			}
			if ((p__1) == "14"){
				return("A");
			}
			return("");
		}
		public static function getCardVal2(p__1:String):Number
		{
			if ((p__1) == "A"){
				return(14);
			}
			if ((p__1) == "T"){
				return(10);
			}
			if ((p__1) == "J"){
				return(11);
			}
			if ((p__1) == "Q"){
				return(12);
			}
			if ((p__1) == "K"){
				return(13);
			}
			return(Number(p__1));
		}
	}
}