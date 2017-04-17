// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.protocol
{
	import com.script.poker.popups.modules.events.TPEvent;
	public class SJoinRoom
	{
		public var type:String;
		public var nRoomId:String;
		public var sPassword:String;
		public function SJoinRoom(p__1:String="", p__2:String = "")
		{
			type = "SJoinRoom";
			nRoomId = p__1;
			sPassword = p__2;
		} 
	}
}