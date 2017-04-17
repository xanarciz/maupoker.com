// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.protocol
{
	import com.script.poker.events.PopupEvent;
	public class RLogKO
	{
		public var type:String;
		public var message:String;
		public var success:Boolean;
		public var cancelable:Boolean;
		public function RLogKO(p__1:String, p__2:Boolean, p__3:String, p__4:Boolean)
		{
			type = p__1;
			success = p__2;
			message = p__3;
			cancelable = p__4;
		}
	}
}