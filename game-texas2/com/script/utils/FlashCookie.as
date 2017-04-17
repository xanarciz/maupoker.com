// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.utils
{
	import flash.net.SharedObject;
	public class FlashCookie
	{
		private var kbDebugTrace:Boolean = false;
		private var mLocalSO:flash.net.SharedObject;
		public function FlashCookie(p__1:String)
		{
			mLocalSO = SharedObject.getLocal(p__1, "/");
		}
		private function OnStatus(p__1:Object)
		{
			var l__2:* = undefined;
			for (l__2 in p__1){
			}
		}
		public function Save()
		{
			var l__1:* = mLocalSO.flush();
			switch(l__1){
				case "pending":
				{
					break;
				}
				case true:
				{
					break;
				}
				case false:
				{
					break;
				}
			}
		}
		public function SetValue(p__1:*, p__2:*)
		{
			mLocalSO.data[p__1] = p__2;
			Save();
		}
		public function GetValue(p__1:*, p__2:*)
		{
			if (mLocalSO.data[p__1] == undefined){
				return(p__2);
			}
			return(mLocalSO.data[p__1]);
		}
		public function ClearAllValues()
		{
			mLocalSO.clear();
		}
		private function dbTrace(p__1:String)
		{
			if (kbDebugTrace){
			}
		}
	}
}