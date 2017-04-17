// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.protocol
{
	import com.script.poker.lobby.events.view.TableSelectedEvent;
	public class RPointsUpdate
	{
		public var points:Number;
		public var deposit:Number;
		public var type:String;
		public var currentpoints:Number;
		public var sitn:Number;
		public function RPointsUpdate(p__1:String, p__2:Number, p__3:Number,p__4:Number,p__5:Number)
		{
			type = p__1;
			points = p__2;
			deposit = p__3;
			currentpoints = p__4;
			sitn = p__5;
		}
	}
}