// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.adobe.serialization.json
{
	public class JSONParseError extends Error
	{
		private var _location:int;
		private var _text:String;
		public function JSONParseError(p__1:String = "", p__2:int = 0, p__3:String = "")
		{
			super(p__1);
			_location = p__2;
			_text = p__3;
		}
		public function get location():int
		{
			return(_location);
		}
		public function get text():String
		{
			return(_text);
		}
	}
}