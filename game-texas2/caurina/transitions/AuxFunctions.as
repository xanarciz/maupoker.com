// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package caurina.transitions
{
	public class AuxFunctions
	{
		public function AuxFunctions()
		{
		}
		public static function numberToR(p__1:Number):Number
		{
			return(((p__1) & 16711680) >> 16);
		}
		public static function numberToG(p__1:Number):Number
		{
			return(((p__1) & 65280) >> 8);
		}
		public static function numberToB(p__1:Number):Number
		{
			return((p__1) & 255);
		}
		public static function isInArray(p__1:String, p__2:Array):Boolean
		{
			var l__3:uint = p__2.length;
			var l__4:uint;
			while(l__4 < l__3){
				if ((p__2[l__4]) == (p__1)){
					return(true);
				}
				l__4++;
			}
			return(false);
		}
		public static function getObjectLength(p__1:Object):uint
		{
			var l__3:String;
			var l__2:uint;
			for (l__3 in p__1){
				l__2++;
			}
			return(l__2);
		}
		public static function concatObjects(... p__1):Object
		{
			var l__3:Object;
			var l__5:String;
			var l__2:Object = {};
			var l__4:int;
			while(l__4 < (p__1.length)){
				l__3 = p__1[l__4];
				for (l__5 in l__3){
					if (l__3[l__5] == null){
						delete l__2[l__5];
					} else {
						l__2[l__5] = l__3[l__5];
					}
				}
				l__4++;
			}
			return(l__2);
		}
	}
}