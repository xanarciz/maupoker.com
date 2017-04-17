// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.protocol
{
	import com.script.poker.table.events.TCEvent;
	public class RGetUsersInRoom
	{
		public var type:String;
		public var userList:Array;
		public function RGetUsersInRoom(p__1:String, p__2:Array)
		{
			type = p__1;
			userList = p__2;
		}
	}
}