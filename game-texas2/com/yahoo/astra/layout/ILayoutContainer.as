// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.yahoo.astra.layout
{
	import flash.events.*;
	import com.yahoo.astra.layout.modes.*;
	public interface ILayoutContainer extends IEventDispatcher
	{
		function get contentWidth():Number;
		function get contentHeight():Number;
		function get layoutMode():com.yahoo.astra.layout.modes.ILayoutMode;
		function set layoutMode(p__1:com.yahoo.astra.layout.modes.ILayoutMode):void;
		function invalidateLayout():void;
		function validateLayout():void;
	}
}