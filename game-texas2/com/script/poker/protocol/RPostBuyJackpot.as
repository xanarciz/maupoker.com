// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.protocol
{
	import it.gotoandplay.smartfoxserver.data.Room;
	public class RPostBuyJackpot
	{
		public var type:String;
		public var sit:int;
		public var bjackpot:Number;
		public var hjackpot:Number;
		public function RPostBuyJackpot(p__1:String, p__2:int, p__3:Number, p__4:Number)
		{
			type = p__1;
			sit = p__2;
			bjackpot = p__3;
			hjackpot =p__4;
			trace(hjackpot+"cabo");
		}
	}
}