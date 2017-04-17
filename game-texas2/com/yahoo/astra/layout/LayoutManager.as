// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.yahoo.astra.layout
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import com.yahoo.astra.layout.events.*;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import flash.text.*;
	public class LayoutManager
	{
		private static var classes:Array = [];
		private static var classToEvents:flash.utils.Dictionary = new Dictionary(true);
		initialize();
		public function LayoutManager()
		{
		}
		private static function initialize():void
		{
			registerInvalidatingEvents(ILayoutContainer, [LayoutEvent.LAYOUT_CHANGE]);
			registerInvalidatingEvents(TextField, [Event.CHANGE]);
		}
		public static function registerInvalidatingEvents(p__1:Class, p__2:Array):void
		{
			var l__3:Array;
			if (classes.indexOf(p__1) >= 0){
				l__3 = classToEvents[p__1];
				p__2 = p__2.concat(l__3);
			} else {
				classes.push(p__1);
			}
			classToEvents[p__1] = p__2;
		}
		public static function hasInvalidatingEvents(p__1:flash.display.DisplayObject):Boolean
		{
			var l__2:Class = (getDefinitionByName(getQualifiedClassName(p__1)) as Class);
			return(classes.indexOf(l__2) >= 0);
		}
		public static function registerContainerChild(p__1:flash.display.DisplayObject):void
		{
			var l__2:Class;
			var l__3:Array;
			var l__4:String;
			for each (l__2 in classes){
				if (p__1 is l__2){
					l__3 = classToEvents[l__2];
					for each (l__4 in l__3){
						p__1.addEventListener(l__4, invalidatingEventHandler, false, 0, true);
					}
				}
			}
		}
		public static function unregisterContainerChild(p__1:flash.display.DisplayObject):void
		{
			var l__2:Class;
			var l__3:Array;
			var l__4:String;
			for each (l__2 in classes){
				if (p__1 is l__2){
					l__3 = classToEvents[l__2];
					for each (l__4 in l__3){
						p__1.removeEventListener(l__4, invalidatingEventHandler);
					}
				}
			}
		}
		public static function resize(p__1:flash.display.DisplayObject, p__2:Number, p__3:Number):void
		{
			p__1.width = p__2;
			p__1.height = p__3;
			invalidateParentLayout(p__1);
		}
		public static function update(p__1:flash.display.DisplayObject, p__2:String, p__3:Object):void
		{
			if (!p__1.hasOwnProperty(p__2)){
				return;
			}
			p__1[p__2] = p__3;
			invalidateParentLayout(p__1);
		}
		public static function invalidateParentLayout(p__1:flash.display.DisplayObject):void
		{
			var l__2:com.yahoo.astra.layout.ILayoutContainer = (p__1.parent as ILayoutContainer);
			if (!l__2){
				return;
			}
			l__2.invalidateLayout();
		}
		private static function invalidatingEventHandler(p__1:flash.events.Event):void
		{
			var l__2:flash.display.DisplayObject = DisplayObject(p__1.currentTarget);
			invalidateParentLayout(l__2);
		}
	}
}