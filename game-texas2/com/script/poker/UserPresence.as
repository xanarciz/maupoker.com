// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker
{
	import com.script.poker.table.BuddyInvite;
	public class UserPresence
	{
		public var nRoomId:Number = 0;
		public var sFriendIds:String;
		public var sRelationship:String;
		public var nServerId:String;
		public var sLastName:String;
		public var sPicURL:String;
		public var sZid:String;
		public var sRoomDesc:String;
		public var tableStakes:String;
		public var sFirstName:String;
		public var nGameId:Number = 0;
		public var sNetworkIds:String;
		public function UserPresence(p__1:String, p__2:Number, p__3:String, p__4:Number, p__5:String, p__6:String, p__7:String, p__8:String, p__9:String, p__10:String, p__11:String, p__12:String = "")
		{
			sZid = p__1;
			nGameId = p__2;
			nServerId = p__3;
			nRoomId = p__4;
			sRoomDesc = p__5;
			sFirstName = p__6;
			sLastName = p__7;
			sRelationship = p__8;
			sPicURL = p__9;
			sFriendIds = p__10;
			sNetworkIds = p__11;
			tableStakes = p__12;
		}
	}
}