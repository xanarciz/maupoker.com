﻿// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.protocol
{
	import com.script.poker.table.events.view.TVESitPressed;
	public class RRaise
	{
		public var type:String;
		public var sit:int;
		public var chips:Number;
		public var bet:Number;
		public function RRaise(p__1:String, p__2:int, p__3:Number, p__4:Number)
		{
			type = p__1;
			sit = p__2;
			bet = p__3;
			chips = p__4;
		}
	}
}