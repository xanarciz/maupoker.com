// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.display.Dialog
{
	import flash.geom.*;
	public class DialogButton
	{
		public var button:*;
		public var offset:flash.geom.Point;
		public var action:Number = 0;
		public var owner:*;
		public var eventStack:Object;
		public static const CLOSE:Number = 2;
		public static const STANDARD:Number = 4;
		public static const DISABLE:Number = 3;
		public function DialogButton():void
		{
			eventStack = new Object();
		}
	}
}