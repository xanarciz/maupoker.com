// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.protocol
{
	import fl.controls.listClasses.ICellRenderer;
	public class RInviteSend
	{
		public var zid:String;
		public var uid:String;
		public var label:String;
		public var source:String;
		public var name:String;
		public var type:String;
		public var shoutId:int;
		public var tabid
		public var fromid
		public var tableStakes:int;
		public var game:String;
		public var msg:String
		public function RInviteSend(p__1:String, p__2:String, p__3:String, p__4:String, p__5:int, p__6:int, p__7:int, p__8:String, p__9:String)
		{
			type = p__1;
			//shoutId = p__2;
			//zid = p__2;
			uid = p__2;
			label = p__3;
			source = p__4;
			tableStakes = p__5;
			tabid = p__6;
			fromid = p__7;
			game = p__8;
			msg = p__9;
			//tableStakes = 1;
		}
	}
}