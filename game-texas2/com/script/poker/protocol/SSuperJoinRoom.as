// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.protocol
{
	public class SSuperJoinRoom
	{
		public var type:String;
		public var nRoomId:int;
		public var sPassword:String;
		public var jt:String
		public static const nAutoRoom:Number = 1;
		public function SSuperJoinRoom(p__1:int, p__2:String = "", p__3:String = "")
		{
			type = "SSuperJoinRoom";
			nRoomId = p__1;
			sPassword = p__2;
			jt = p__3;
		}
	}
}