// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.adobe.utils
{
	import ws.tink.managers.LibraryManager;
	public class IntUtil
	{
		private static var hexChars:String = "0123456789abcdef";
		public function IntUtil()
		{
		}
		public static function rol(p__1:int, p__2:int):int
		{
			return((((((p__1) << (p__2))) | ((((p__1) >>> (((32 - p__2)))))))));
		}
		public static function ror(p__1:int, p__2:int):uint
		{
			var l__3:int = (32 - p__2);
			return((((((p__1) << l__3)) | ((((p__1) >>> (((32 - l__3)))))))));
		}
		public static function toHex(p__1:int, p__2:Boolean = false):String
		{
			var l__4:int;
			var l__5:int;
			var l__3:* = "";
			if (p__2){
				l__4 = 0;
				while(l__4 < 4){
					l__3 = (l__3 + (hexChars.charAt(((p__1) >> ((3 - l__4) * 8 + 4)) & 15) + hexChars.charAt(((p__1) >> ((3 - l__4) * 8)) & 15)));
					l__4++;
				}
			} else {
				l__5 = 0;
				while(l__5 < 4){
					l__3 = (l__3 + (hexChars.charAt(((p__1) >> (l__5 * 8 + 4)) & 15) + hexChars.charAt(((p__1) >> (l__5 * 8)) & 15)));
					l__5++;
				}
			}
			return(l__3);
		}
	}
}