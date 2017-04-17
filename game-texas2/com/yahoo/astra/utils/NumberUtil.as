// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.yahoo.astra.utils
{
	public class NumberUtil
	{
		public function NumberUtil()
		{
		}
		public static function roundToNearest(p__1:Number, p__2:Number = 1):Number
		{
			if (p__2 == 0){
				return(p__1);
			}
			var l__3:Number = Math.round(NumberUtil.roundToPrecision(p__1 / p__2, 10)) * p__2;
			return(NumberUtil.roundToPrecision(l__3, 10));
		}
		public static function roundUpToNearest(p__1:Number, p__2:Number = 1):Number
		{
			if (p__2 == 0){
				return(p__1);
			}
			return(Math.ceil(NumberUtil.roundToPrecision(p__1 / p__2, 10)) * p__2);
		}
		public static function roundDownToNearest(p__1:Number, p__2:Number = 1):Number
		{
			if (p__2 == 0){
				return(p__1);
			}
			return(Math.floor(NumberUtil.roundToPrecision(p__1 / p__2, 10)) * p__2);
		}
		public static function roundToPrecision(p__1:Number, p__2:int = 0):Number
		{
			var l__3:Number = Math.pow(10, p__2);
			return(Math.round(l__3 * p__1) / l__3);
		}
		public static function fuzzyEquals(p__1:Number, p__2:Number, p__3:int = 5):Boolean
		{
			var l__4:Number = (p__1 - p__2);
			var l__5:Number = Math.pow(10, -p__3);
			return(((l__4 < l__5) && (l__4 > (-l__5))));
		}
	}
}