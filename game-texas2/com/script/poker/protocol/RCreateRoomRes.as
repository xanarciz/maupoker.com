// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.protocol
{
	import fl.controls.Button;
	public class RCreateRoomRes
	{
		public var type:String;
		public var password:String;
		public var roomId:int;
		public var rooms:Array;
		public function RCreateRoomRes(p__1:String, p__2:int, p__3:Array, p__4:String = "")
		{
			type = p__1;
			roomId = p__2;
			password = p__4;
			rooms = p__3;
		}
	}
}