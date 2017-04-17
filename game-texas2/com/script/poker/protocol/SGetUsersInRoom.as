// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.protocol
{
	import com.script.poker.popups.modules.events.VIPEvent;
	public class SGetUsersInRoom
	{
		public var type:String;
		public var roomId:int;
		public var userId:String;
		public function SGetUsersInRoom(p__1:String, p__2:String, p__3:int)
		{
			type = p__1;
			userId = p__2;
			roomId = p__3;
		}
	}
}