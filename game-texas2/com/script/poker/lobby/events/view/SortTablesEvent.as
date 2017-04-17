// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.lobby.events.view
{
	import flash.events.*;
	import com.script.poker.lobby.events.*;
	public class SortTablesEvent extends com.script.poker.lobby.events.LVEvent
	{
		public var dataField:String = "";
		public var sortDescending:Boolean = false;
		public static const SORT_TABLES:String = "sort_tables";
		public function SortTablesEvent(p__1:String, p__2:String, p__3:Boolean = false)
		{
			super(p__1);
			this.dataField = p__2;
			this.sortDescending = p__3;
		}
		override public function clone():flash.events.Event
		{
			return(new SortTablesEvent(this.type, dataField, sortDescending));
		}
		override public function toString():String
		{
			return(formatToString("SortTablesEvent", "type", "bubbles", "cancelable", "eventPhase", "dataField", "sortDescending"));
		}
	}
}