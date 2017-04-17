// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.protocol
{
	import fl.controls.listClasses.ICellRenderer;
	public class RBuddyRequest
	{
		public var zid:String;
		public var name:String;
		public var type:String;
		public var shoutId:int;
		public function RBuddyRequest(p__1:String, p__2:int, p__3:String, p__4:String)
		{
			type = p__1;
			shoutId = p__2;
			zid = p__3;
			name = p__4;
		}
	}
}