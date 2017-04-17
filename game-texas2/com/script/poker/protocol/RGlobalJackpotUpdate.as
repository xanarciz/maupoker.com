// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.protocol
{
	import com.script.poker.lobby.events.view.TableSelectedEvent;
	public class RGlobalJackpotUpdate
	{
		public var gjackpot:Number;
		public var type:String;
		public function RGlobalJackpotUpdate(p__1:String, p__2:Number)
		{
			type = p__1;
			gjackpot = p__2;
		}
	}
}