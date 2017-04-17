// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package ws.tink.events
{
	import flash.events.*;
	public class LibraryEvent extends flash.events.Event
	{
		public static var LOAD_COMPLETE:String = "loadComplete";
		public static var EMBED_COMPLETE:String = "embedComplete";
		public static var FILE_COMPLETE:String = "fileComplete";
		public static var LOAD_ERROR:String = "loadError";
		public function LibraryEvent(p__1:String, p__2:Boolean = false, p__3:Boolean = false)
		{
			super(p__1, p__2, p__3);
		}
		override public function clone():flash.events.Event
		{
			return(new LibraryEvent(type, bubbles, cancelable));
		}
	}
}