// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script
{
	import com.script.poker.table.asset.Chicklet;
	public class User
	{
		public var uid:int;
		public var zid:String;
		public var sn_id:int;
		public function User(p__1:String)
		{
			zid = p__1;
			var l__2:Array = zid.split(":");
			sn_id = int(l__2[0]);
			uid = int(l__2[1]);
		}
	}
}