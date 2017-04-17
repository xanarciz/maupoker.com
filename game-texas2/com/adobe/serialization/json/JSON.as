// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.adobe.serialization.json
{
	public class JSON
	{
		public function JSON()
		{
		}
		public static function encode(p__1:Object):String
		{
			var l__2:com.adobe.serialization.json.JSONEncoder = new JSONEncoder(p__1);
			
			return(l__2.getString());
		}
		public static function decode(p__1:String)
		{
			var l__2:com.adobe.serialization.json.JSONDecoder = new JSONDecoder(p__1);
			return(l__2.getValue());

		}
	}
}