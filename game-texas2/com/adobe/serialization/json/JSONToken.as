// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.adobe.serialization.json
{
	public class JSONToken
	{
		private var _value:Object;
		private var _type:int;
		public function JSONToken(p__1:int = -1, p__2:Object = null)
		{
			_type = p__1;
			_value = p__2;
		}
		public function get type():int
		{
			return(_type);
		}
		public function set type(p__1:int):void
		{
			_type = p__1;
		}
		public function get value():Object
		{
			return(_value);
		}
		public function set value(p__1:Object):void
		{
			_value = p__1;
		}
	}
}