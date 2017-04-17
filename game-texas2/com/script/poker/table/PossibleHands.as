// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table
{
	public class PossibleHands
	{
		public function PossibleHands():void
		{
		}
		public static function run(p__1:Array):String
		{
			var l__6:* = undefined;
			var l__7:String;
			var l__8:* = undefined;
			var l__9:int;
			var l__10:Function;
			var l__11:Array;
			var l__12:Array;
			var l__13:* = undefined;
			var l__14:String;
			var l__15:String;
			var l__16:String;
			var l__2:Array = p__1;
			var l__3:Array = [checkRoyalFlush, checkStraightFlush, checkFourOfAKind, checkFullHouse, checkFlush, checkStraight, checkThreeOfAKind, checkTwoPair, checkPair, checkHighCard];
			var l__4:int;
			var l__5:Array = l__2.concat();
			for (l__6 in l__3){
				if (l__4 == 0){
					l__10 = l__3[l__6];
					l__11 = l__2.concat();
					l__12 = l__10(l__11);
					if (l__12[0] != 0){
						l__4 = l__12[0];
						if (l__4 == -1){
							l__4 = 0;
						}
						l__5 = [];
						l__5 = l__12[1].concat();
					}
				}
			}
			l__7 = l__4.toString();
			l__5.sortOn(["used", "rank"], [Array.DESCENDING, (Array.DESCENDING | Array.NUMERIC)]);
			for (l__8 in l__5){
				if (l__8 < 5){
					l__13 = l__5[l__8].rank;
					l__14 = l__13.toString();
					l__15 = "";
					if (l__13 < 10){
						l__15 = "0";
					}
					l__16 = (l__15 + l__14);
					l__7 = (l__7 + l__16);
				}
			}
			l__9 = 0;
			while(l__7.length < 11){
				l__7 = (l__7 + "0");
				l__9++;
			}
			return(l__7);
		}
		public static function checkHighCard(p__1:Array):Array
		{
			var l__4:* = undefined;
			var l__2:* = 2;
			var l__3:Array = p__1.concat();
			for (l__4 in l__3){
				if (l__3[l__4].rank == 1){
					l__3[l__4].rank = 14;
				}
			}
			l__3.sortOn("rank", (Array.DESCENDING | Array.NUMERIC));
			return([-1, l__3]);
		}
		public static function checkPair(p__1:Array):Array
		{
			var l__5:* = undefined;
			var l__6:Object;
			var l__7:* = undefined;
			var l__8:Object;
			var l__2:* = 2;
			var l__3:Array = p__1.concat();
			l__3.sortOn("rank", (Array.DESCENDING | Array.NUMERIC));
			if (l__3.length < l__2){
				return([0]);
			}
			var l__4:Boolean;
			if (l__3.length >= l__2){
				for (l__5 in l__3){
					l__6 = l__3[l__5];
					for (l__7 in l__3){
						l__8 = l__3[l__7];
						if (!(l__5 == l__7) && (l__6.rank == l__8.rank)){
							l__3[l__5].used = 1;
							l__3[l__7].used = 1;
							l__4 = true;
						}
					}
				}
				if (l__4){
					return([1, l__3]);
				}
				return([0]);
			}
		}
		public static function checkTwoPair(p__1:Array):Array
		{
			var l__5:* = undefined;
			var l__6:Boolean;
			var l__7:Boolean;
			var l__8:* = undefined;
			var l__9:Object;
			var l__10:* = undefined;
			var l__11:Object;
			var l__12:* = undefined;
			var l__13:Object;
			var l__14:* = undefined;
			var l__15:Object;
			var l__16 = 0
			var l__2:* = 4;
			var l__3:Array = p__1.concat();
			l__3.sortOn("rank", (Array.DESCENDING | Array.NUMERIC));
			if (l__3.length < l__2){
				return([0]);
			}
			var l__4:Boolean;
			if (l__3.length >= l__2){
				for (l__5 in l__3){
					l__3[l__5].used = 0;
				}
				l__6 = false;
				l__7 = false;
				for (l__8 in l__3){
					l__9 = l__3[l__8];
					for (l__10 in l__3){
						l__11 = l__3[l__10];
						if (!(l__8 == l__10) && (l__9.rank == l__11.rank)){
							if (l__16 <  4 ) {
							l__3[l__8].used = 1;
							l__3[l__10].used = 1;
							l__6 = true;
							l__16 ++;
							
							}
						}
					}
				}
				/*for (l__12 in l__3){
					l__13 = l__3[l__12];
					for (l__14 in l__3){
						l__15 = l__3[l__14];
						if (((!(l__12 == l__14) && (l__13.rank == l__15.rank)) && !(l__13.used == 1)) && !(l__15.used == 1)){
							l__7 = true;
							l__3[l__12].used = 1;
							l__3[l__14].used = 1;
						}
					}
				}
				if (l__6 && l__7){
					return([2, l__3]);
				}
				*/
				if (l__16 == 4) {
					
					return([2, l__3]);
				}
				return([0]);
			}
		}
		public static function checkThreeOfAKind(p__1:Array):Array
		{
			var l__5:* = undefined;
			var l__6:Object;
			var l__7:* = undefined;
			var l__8:Object;
			var l__9:* = undefined;
			var l__10:Object;
			var l__2:* = 3;
			var l__3:Array = p__1.concat();
			l__3.sortOn("rank", (Array.DESCENDING | Array.NUMERIC));
			if (l__3.length < l__2){
				return([0]);
			}
			var l__4:Boolean;
			if (l__3.length >= l__2){
				for (l__5 in l__3){
					l__6 = l__3[l__5];
					for (l__7 in l__3){
						l__8 = l__3[l__7];
						if (!(l__5 == l__7) && (l__6.rank == l__8.rank)){
							for (l__9 in l__3){
								l__10 = l__3[l__9];
								if (((!(l__9 == l__5) && !(l__9 == l__7)) && (l__10.rank == l__6.rank)) && (l__10.rank == l__8.rank)){
									l__4 = true;
									l__3[l__5].used = 1;
									l__3[l__7].used = 1;
									l__3[l__9].used = 1;
								}
							}
						}
					}
				}
				if (l__4){
					return([3, l__3]);
				}
				return([0]);
			}
		}
		public static function checkStraight(p__1:Array):Array
		{
			var l__6:* = undefined;
			var l__7:Object;
			var l__8:* = undefined;
			var l__9:Object;
			var l__10:* = undefined;
			var l__11:Object;
			var l__12:Number;
			var l__2:Array = p__1.concat();
			var l__3:* = 5;
			var l__4:Array = p__1.concat();
			l__4.sortOn("rank", (Array.DESCENDING | Array.NUMERIC));
			if (l__4.length < l__3){
				return([0]);
			}
			var l__5:Boolean;
			if (l__4.length >= l__3){
				for (l__6 in l__4){
					l__7 = l__4[l__6];
					for (l__8 in l__4){
						l__9 = l__4[l__8];
						if (!(l__6 == l__8) && (l__7.rank == l__9.rank)){
							l__4.splice(l__8, 1);
						}
					}
				}
				for (l__10 in l__4){
					if ((l__10 <= Math.abs(5 - l__4.length)) && (l__4.length >= 5)){
						l__11 = l__4[l__10];
						l__12 = l__11.rank;
						if ((((l__4[(l__10 + 1)].rank == (l__12 - 1)) && (l__4[(l__10 + 2)].rank == (l__12 - 2))) && (l__4[(l__10 + 3)].rank == (l__12 - 3))) && (l__4[(l__10 + 4)].rank == (l__12 - 4))){
							l__4[l__10].used = 1;
							l__4[(l__10 + 1)].used = 1;
							l__4[(l__10 + 2)].used = 1;
							l__4[(l__10 + 3)].used = 1;
							l__4[(l__10 + 4)].used = 1;
							l__5 = true;
						}
					}
				}
				if (l__5){
					return([4, l__4]);
				}
				return(checkStraightAceLow(l__2));
			}
		}
		public static function checkStraightAceLow(p__1:Array):Array
		{
			var l__4:* = undefined;
			var l__6:* = undefined;
			var l__7:Object;
			var l__8:* = undefined;
			var l__9:Object;
			var l__10:* = undefined;
			var l__11:Object;
			var l__12:Number;
			var l__2:* = 5;
			var l__3:Array = p__1.concat();
			for (l__4 in l__3){
				if (l__3[l__4].rank == 14){
					l__3[l__4].rank = 1;
				}
			}
			l__3.sortOn("rank", (Array.DESCENDING | Array.NUMERIC));
			if (l__3.length < l__2){
				return([0]);
			}
			var l__5:Boolean;
			if (l__3.length >= l__2){
				for (l__6 in l__3){
					l__7 = l__3[l__6];
					for (l__8 in l__3){
						l__9 = l__3[l__8];
						if (!(l__6 == l__8) && (l__7.rank == l__9.rank)){
							l__3.splice(l__8, 1);
						}
					}
				}
				for (l__10 in l__3){
					if ((l__10 <= Math.abs(5 - l__3.length)) && (l__3.length >= 5)){
						l__11 = l__3[l__10];
						l__12 = l__11.rank;
						if ((((l__3[(l__10 + 1)].rank == (l__12 - 1)) && (l__3[(l__10 + 2)].rank == (l__12 - 2))) && (l__3[(l__10 + 3)].rank == (l__12 - 3))) && (l__3[(l__10 + 4)].rank == (l__12 - 4))){
							l__3[l__10].used = 1;
							l__3[(l__10 + 1)].used = 1;
							l__3[(l__10 + 2)].used = 1;
							l__3[(l__10 + 3)].used = 1;
							l__3[(l__10 + 4)].used = 1;
							l__5 = true;
						}
					}
				}
				if (l__5){
					return([4, l__3]);
				}
				if (!l__5){
					return([0]);
				}
			}
		}
		public static function checkFlush(p__1:Array):Array
		{
			var l__4:* = undefined;
			var l__5:Boolean;
			var l__6:int;
			var l__7:int;
			var l__8:int;
			var l__9:int;
			var l__10:* = undefined;
			var l__11:Object;
			var l__12:* = undefined;
			var l__13:* = undefined;
			var l__14:* = undefined;
			var l__15:* = undefined;
			var l__2:* = 5;
			var l__3:Array = p__1.concat();
			l__3.sortOn("suit", Array.NUMERIC);
			if (l__3.length < l__2){
				return([0]);
			}
			for (l__4 in l__3){
				if (l__3[l__4].rank == 1){
					l__3[l__4].rank = 14;
				}
			}
			l__5 = false;
			l__6 = 0;
			l__7 = 0;
			l__8 = 0;
			l__9 = 0;
			if (l__3.length >= l__2){
				for (l__10 in l__3){
					l__11 = l__3[l__10];
					if (l__11.suit == 0){
						l__6++;
					}
					if (l__11.suit == 1){
						l__7++;
					}
					if (l__11.suit == 2){
						l__8++;
					}
					if (l__11.suit == 3){
						l__9++;
					}
				}
				if (l__6 >= 5){
					for (l__12 in l__3){
						if (l__3[l__12].suit == 0){
							l__3[l__12].used = 1;
						}
					}
				}
				if (l__7 >= 5){
					for (l__13 in l__3){
						if (l__3[l__13].suit == 1){
							l__3[l__13].used = 1;
						}
					}
				}
				if (l__8 >= 5){
					for (l__14 in l__3){
						if (l__3[l__14].suit == 2){
							l__3[l__14].used = 1;
						}
					}
				}
				if (l__9 >= 5){
					for (l__15 in l__3){
						if (l__3[l__15].suit == 3){
							l__3[l__15].used = 1;
						}
					}
				}
				if ((((l__6 >= 5) || (l__7 >= 5)) || (l__8 >= 5)) || (l__9 >= 5)){
					l__5 = true;
				}
				if (l__5){
					return([5, l__3]);
				}
				return([0]);
			}
		}
		public static function checkFullHouse(p__1:Array):Array
		{
			var l__4:Boolean;
			var l__5:Boolean;
			var l__6:* = undefined;
			var l__7:Object;
			var l__8:* = undefined;
			var l__9:Object;
			var l__10:* = undefined;
			var l__11:Object;
			var l__12:* = undefined;
			var l__13:Object;
			var l__14:* = undefined;
			var l__15:Object;
			var l__2:* = 5;
			var l__3:Array = p__1.concat();
			l__3.sortOn("rank", Array.NUMERIC);
			if (l__3.length < l__2){
				return([0]);
			}
			if (l__3.length >= l__2){
				l__4 = false;
				l__5 = false;
				for (l__6 in l__3){
					l__7 = l__3[l__6];
					for (l__8 in l__3){
						l__9 = l__3[l__8];
						if (!(l__6 == l__8) && (l__7.rank == l__9.rank)){
							for (l__10 in l__3){
								l__11 = l__3[l__10];
								if (((!(l__10 == l__6) && !(l__10 == l__8)) && (l__11.rank == l__7.rank)) && (l__11.rank == l__9.rank)){
									l__4 = true;
									l__3[l__6].used = 1;
									l__3[l__8].used = 1;
									l__3[l__10].used = 1;
								}
							}
						}
					}
				}
				for (l__12 in l__3){
					l__13 = l__3[l__12];
					for (l__14 in l__3){
						l__15 = l__3[l__14];
						if (((!(l__12 == l__14) && (l__13.rank == l__15.rank)) && !(l__13.used == 1)) && !(l__15.used == 1)){
							l__5 = true;
							l__3[l__12].used = 1;
							l__3[l__14].used = 1;
						}
					}
				}
				if (l__4 && l__5){
					return([6, l__3]);
				}
				return([0]);
			}
		}
		public static function checkFourOfAKind(p__1:Array):Array
		{
			var l__5:* = undefined;
			var l__6:Object;
			var l__7:* = undefined;
			var l__8:Object;
			var l__9:* = undefined;
			var l__10:Object;
			var l__11:* = undefined;
			var l__12:Object;
			var l__2:* = 4;
			var l__3:Array = p__1.concat();
			l__3.sortOn("rank", Array.NUMERIC);
			if (l__3.length < l__2){
				return([0]);
			}
			var l__4:Boolean;
			if (l__3.length >= l__2){
				for (l__5 in l__3){
					l__6 = l__3[l__5];
					for (l__7 in l__3){
						l__8 = l__3[l__7];
						if (!(l__5 == l__7) && (l__6.rank == l__8.rank)){
							for (l__9 in l__3){
								l__10 = l__3[l__9];
								if (((!(l__9 == l__5) && !(l__9 == l__7)) && (l__10.rank == l__6.rank)) && (l__10.rank == l__8.rank)){
									for (l__11 in l__3){
										l__12 = l__3[l__11];
										if (((((!(l__11 == l__5) && !(l__11 == l__7)) && !(l__11 == l__9)) && (l__12.rank == l__6.rank)) && (l__12.rank == l__8.rank)) && (l__12.rank == l__10.rank)){
											l__4 = true;
											l__3[l__5].used = 1;
											l__3[l__7].used = 1;
											l__3[l__9].used = 1;
											l__3[l__11].used = 1;
										}
									}
								}
							}
						}
					}
				}
				if (l__4){
					return([7, l__3]);
				}
				return([0]);
			}
		}
		public static function checkStraightFlush(p__1:Array):Array
		{
			var l__4:* = undefined;
			var l__6:int;
			var l__7:int;
			var l__8:int;
			var l__9:int;
			var l__10:* = undefined;
			var l__11:Boolean;
			var l__12:Object;
			var l__13:int;
			var l__14:Array;
			var l__15:* = undefined;
			var l__16:* = undefined;
			var l__17:Object;
			var l__18:Number;
			var l__2:* = 5;
			var l__3:Array = p__1.concat();
			for (l__4 in l__3){
				if (l__3[l__4].rank == 14){
					l__3[l__4].rank = 1;
				}
			}
			l__3.sortOn("rank", (Array.DESCENDING | Array.NUMERIC));
			if (l__3.length < l__2){
				return([0]);
			}
			var l__5:Boolean;
			if (l__3.length >= l__2){
				l__6 = 0;
				l__7 = 0;
				l__8 = 0;
				l__9 = 0;
				for (l__10 in l__3){
					l__12 = l__3[l__10];
					if (l__12.suit == 0){
						l__6++;
					}
					if (l__12.suit == 1){
						l__7++;
					}
					if (l__12.suit == 2){
						l__8++;
					}
					if (l__12.suit == 3){
						l__9++;
					}
				}
				l__11 = false;
				if ((((l__6 >= 5) || (l__7 >= 5)) || (l__8 >= 5)) || (l__9 >= 5)){
					l__11 = true;
				}
				if (l__11){
					if (l__6 >= 5){
						l__13 = 0;
					}
					if (l__7 >= 5){
						l__13 = 1;
					}
					if (l__8 >= 5){
						l__13 = 2;
					}
					if (l__9 >= 5){
						l__13 = 3;
					}
					l__14 = new Array();
					for (l__15 in l__3){
						if (l__3[l__15].suit == l__13){
							l__14.push(l__3[l__15]);
						}
					}
					for (l__16 in l__14){
						if ((l__16 <= Math.abs(5 - l__14.length)) && (l__14.length >= 5)){
							l__17 = l__14[l__16];
							l__18 = l__17.rank;
							if ((((l__14[(l__16 + 1)].rank == (l__18 - 1)) && (l__14[(l__16 + 2)].rank == (l__18 - 2))) && (l__14[(l__16 + 3)].rank == (l__18 - 3))) && (l__14[(l__16 + 4)].rank == (l__18 - 4))){
								l__14[l__16].used = 1;
								l__14[(l__16 + 1)].used = 1;
								l__14[(l__16 + 2)].used = 1;
								l__14[(l__16 + 3)].used = 1;
								l__14[(l__16 + 4)].used = 1;
								l__5 = true;
							}
						}
					}
					if (l__5){
						return([8, l__14]);
					}
					return([0]);
				} else {
					return([0]);
				}
			}
		}
		public static function checkStraightFlushAceLow(p__1:Array):Array
		{
		}
		public static function checkRoyalFlush(p__1:Array):Array
		{
			var l__5:* = undefined;
			var l__6:int;
			var l__7:int;
			var l__8:int;
			var l__9:int;
			var l__10:* = undefined;
			var l__11:Boolean;
			var l__12:Object;
			var l__13:int;
			var l__14:Array;
			var l__15:* = undefined;
			var l__16:* = undefined;
			var l__17:Object;
			var l__18:Number;
			var l__2:* = 5;
			var l__3:Array = p__1.concat();
			l__3.sortOn("rank", Array.NUMERIC);
			if (l__3.length < l__2){
				return([0]);
			}
			var l__4:Boolean;
			if (l__3.length >= l__2){
				for (l__5 in l__3){
					if (l__3[l__5].rank == 1){
						l__3[l__5].rank = 14;
					}
				}
				l__6 = 0;
				l__7 = 0;
				l__8 = 0;
				l__9 = 0;
				for (l__10 in l__3){
					l__12 = l__3[l__10];
					if (l__12.suit == 0){
						l__6++;
					}
					if (l__12.suit == 1){
						l__7++;
					}
					if (l__12.suit == 2){
						l__8++;
					}
					if (l__12.suit == 3){
						l__9++;
					}
				}
				l__11 = false;
				if ((((l__6 >= 5) || (l__7 >= 5)) || (l__8 >= 5)) || (l__9 >= 5)){
					l__11 = true;
				}
				if (l__11){
					if (l__6 >= 5){
						l__13 = 0;
					}
					if (l__7 >= 5){
						l__13 = 1;
					}
					if (l__8 >= 5){
						l__13 = 2;
					}
					if (l__9 >= 5){
						l__13 = 3;
					}
					l__14 = new Array();
					for (l__15 in l__3){
						if (l__3[l__15].suit == l__13){
							l__14.push(l__3[l__15]);
						}
					}
					l__14.sortOn("rank", Array.NUMERIC);
					for (l__16 in l__14){
						if ((l__16 <= Math.abs(5 - l__14.length)) && (l__14.length >= 5)){
							l__17 = l__14[l__16];
							l__18 = l__17.rank;
							if (((((l__14[(l__16 + 1)].rank == (l__18 + 1)) && (l__14[(l__16 + 2)].rank == (l__18 + 2))) && (l__14[(l__16 + 3)].rank == (l__18 + 3))) && (l__14[(l__16 + 4)].rank == (l__18 + 4))) && (l__14[(l__16 + 4)].rank == 14)){
								l__14[l__16].used = 1;
								l__14[(l__16 + 1)].used = 1;
								l__14[(l__16 + 2)].used = 1;
								l__14[(l__16 + 3)].used = 1;
								l__14[(l__16 + 4)].used = 1;
								l__4 = true;
							}
						}
					}
					if (l__4){
						return([9, l__14]);
					}
					return([0]);
				} else {
					return([0]);
				}
			}
		}
	}
}