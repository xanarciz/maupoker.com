// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.protocol
{
	public class SSetUserProps
	{
		public var sn_id:Number = 0;
		public var pic_lrg_url:String;
		public var tourneyState:String;
		public var pic_url:String;
		public var prof_url:String;
		public var firstTimePlaying:Number = 0;
		public var protoVersion:Number = 0;
		public var type:String;
		public var rank:Number = 0;
		public var clientType:String;
		public var network:String;
		public var capabilities:Number = 0;
		public function SSetUserProps(p__1:String, p__2:String, p__3:Number, p__4:String, p__5:String, p__6:Number, p__7:String, p__8:String, p__9:Number, p__10:Number, p__11:String, p__12:Number)
		{
			type = p__1;
			pic_url = p__2;
			rank = p__3;
			network = p__4;
			pic_lrg_url = p__5;
			sn_id = p__6;
			prof_url = p__7;
			tourneyState = p__8;
			protoVersion = p__9;
			capabilities = p__10;
			clientType = p__11;
			firstTimePlaying = p__12;
		}
	}
}