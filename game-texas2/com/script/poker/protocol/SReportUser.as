// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.protocol
{
	import com.script.poker.popups.Popup;
	public class SReportUser
	{
		public var type:String;
		public var reporterZid:String;
		public var abuserZid:String;
		public var reporterName:String;
		public function SReportUser(p__1:String, p__2:String, p__3:String, p__4:String)
		{
			type = p__1;
			reporterZid = p__2;
			abuserZid = p__3;
			reporterName = p__4;
		}
	}
}