// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.protocol
{
	import com.script.poker.lobby.RoomItem;
	public class SChangePass
	{
		public var type:String;
		public var oldPass:String;
		public var newPass:String;
		public var newPass2:String;
		public function SChangePass(p__1:String, p__2:String, p__3:String, p__4:String)
		{
			type = p__1;
			oldPass = p__2;
			newPass = p__3;
			newPass2 = p__4;
		}
	}
}