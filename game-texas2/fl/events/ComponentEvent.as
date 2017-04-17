// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package fl.events
{
	import flash.events.*;
	public class ComponentEvent extends flash.events.Event
	{
		public static const HIDE:String = "hide";
		public static const BUTTON_DOWN:String = "buttonDown";
		public static const MOVE:String = "move";
		public static const RESIZE:String = "resize";
		public static const ENTER:String = "enter";
		public static const LABEL_CHANGE:String = "labelChange";
		public static const SHOW:String = "show";
		public function ComponentEvent(p__1:String, p__2:Boolean = false, p__3:Boolean = false)
		{
			super(p__1, p__2, p__3);
		}
		override public function toString():String
		{
			return(formatToString("ComponentEvent", "type", "bubbles", "cancelable"));
		}
		override public function clone():flash.events.Event
		{
			return(new fl.events.ComponentEvent(type, bubbles, cancelable));
		}
	}
}