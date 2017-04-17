// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.protocol
{
	import it.gotoandplay.smartfoxserver.handlers.IMessageHandler;
	public class RReplayPots
	{
		public var type:String;
		public var numPots:Number;
		public var pots:Array;
		public function RReplayPots(p__1:String, p__2:Number, p__3:Array)
		{
			type = p__1;
			numPots = p__2;
			pots = p__3;
		}
	}
}