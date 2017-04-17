// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.adobe.serialization.json
{
	import flash.utils.*;
	public class JSONEncoder
	{
		private var jsonString:String;
		public function JSONEncoder(p__1:*)
		{
			jsonString = convertToString(p__1);
		}
		public function getString():String
		{
			return(jsonString);
		}
		private function convertToString(p__1:*):String
		{
			if (p__1 is String){
				return(escapeString(p__1 as String));
			}
			if (p__1 is Number){
				return(isFinite(p__1 as Number) ? p__1.toString() : "null");
			} else if (p__1 is Boolean){
				return(p__1 ? "true" : "false");
			} else {
				if (p__1 is Array){
					return(arrayToString(p__1 as Array));
				}
				if ((p__1 is Object) && !(p__1 == null)){
					return(objectToString(p__1));
				}
			}
			return("null");
		}
		private function escapeString(p__1:String):String
		{
			var l__3:String;
			var l__6:String;
			var l__7:String;
			var l__2:* = "";
			var l__4:Number = p__1.length;
			var l__5:int;
			while(l__5 < l__4){
				l__3 = p__1.charAt(l__5);
				switch(l__3){
					case "\"":
					{
						l__2 = (l__2 + "\\\"");
						break;
					}
					case "\\":
					{
						l__2 = (l__2 + "\\\\");
						break;
					}
					case "\b":
					{
						l__2 = (l__2 + "\\b");
						break;
					}
					case "\f":
					{
						l__2 = (l__2 + "\\f");
						break;
					}
					case "\n":
					{
						l__2 = (l__2 + "\\n");
						break;
					}
					case "\r":
					{
						l__2 = (l__2 + "\\r");
						break;
					}
					case "\t":
					{
						l__2 = (l__2 + "\\t");
						break;
					}
					default:
					{
						if (l__3 < " "){
							l__6 = l__3.charCodeAt(0).toString(16);
							l__7 = (l__6.length == 2) ? "00" : "000";
							l__2 = (l__2 + (("\\u" + l__7) + l__6));
						} else {
							l__2 = (l__2 + l__3);
						}
					}
				}
				l__5++;
			}
			return(("\"" + l__2) + "\"");
		}
		private function arrayToString(p__1:Array):String
		{
			var l__2:* = "";
			var l__3:int;
			while(l__3 < p__1.length){
				if (l__2.length > 0){
					l__2 = (l__2 + ",");
				}
				l__2 = (l__2 + convertToString(p__1[l__3]));
				l__3++;
			}
			return(("[" + l__2) + "]");
		}
		private function objectToString(o:Object):String
		{
			var value:Object;
			var key:String;
			var v:XML;
			var s:String = "";
			var classInfo:XML = describeType(o);
			if (classInfo.@name.toString() == "Object"){
				for (key in o){
					value = o[key];
					if (value is Function){
					} else {
						if (s.length > 0){
							s = (s + ",");
						}
						s = (s + ((escapeString(key) + ":") + convertToString(value)));
					}
				}
			} else {
				for each (v in classInfo..*.((name() == "variable") || (name() == "accessor"))){
					if (s.length > 0){
						s = (s + ",");
					}
					s = (s + ((escapeString(v.@name.toString()) + ":") + convertToString(o[v.@name])));
				}
			}
			return(("{" + s) + "}");
		}
	}
}