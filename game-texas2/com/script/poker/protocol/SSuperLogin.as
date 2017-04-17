// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.protocol
{
	import com.adobe.serialization.json.*;
	import fl.core.UIComponent;
	public class SSuperLogin
	{
		public var pass:String;
		public var userId:String;
		public var zone:String;
		public var props_JSON_ESC:String;
		public function SSuperLogin(p__1:String, p__2:String, p__3:Number, p__4:String, p__5:String, p__6:Number, p__7:String, p__8:String, p__9:Number, p__10:Number, p__11:String, p__12:Number, p__13:Number, p__14:Number, p__15:String, p__16:String, p__17:int)
		{
			userId = p__1;
			pass = p__15;
			zone = p__16;
			var l__18:Object = {user:userId, pic_url:p__2, rank:p__3, network:p__4.substring(0, 100), pic_lrg_url:p__5, sn_id:p__6, profile_url:p__7, tourneyState:p__8, protoVersion:p__9, capabilities:p__10, clientType:p__11, autoRoom:p__12, autoJoin:p__13, lobbyList:p__14, hideGifts:p__17};
			var l__19:* = JSON.encode(l__18);
			props_JSON_ESC = escape(l__19);
		}
	}
}