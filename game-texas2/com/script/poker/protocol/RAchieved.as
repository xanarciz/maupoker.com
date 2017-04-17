// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.protocol
{
	import com.script.poker.UserPresence;
	public class RAchieved
	{
		public var type:String;
		public var sZid:String;
		public var sPicUrl:String;
		public var sPlayerText:String;
		public var nRewardBonus:Number;
		public var sIconUrl:String;
		public var nSit:int;
		public var nPoints:Number;
		public var nAchievmentId:Number;
		public var sAchievmentName:String;
		public function RAchieved(p__1:String, p__2:Object)
		{
			type = p__1;
			nSit = int(p__2.sit);
			sAchievmentName = p__2.achievementName;
			nRewardBonus = Number(p__2.rewardBonus);
			sPicUrl = p__2.picUrl;
			nPoints = Number(p__2.nPoints);
			sPlayerText = p__2.playerText;
			sIconUrl = p__2.iconUrl;
			sZid = p__2.zid;
			nAchievmentId = int(p__2.achievementId);
		}
	}
}