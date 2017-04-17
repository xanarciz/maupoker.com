// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.protocol
{
	import com.adobe.serialization.json.JSONToken;
	public class RRoomPicked
	{
		public var bucket:int;
		public var type:String;
		public var roomId:int;
		public function RRoomPicked(p__1:String, p__2:int, p__3:int)
		{
			type = p__1;
			roomId = p__2;
			bucket = p__3;
		}
	}
}