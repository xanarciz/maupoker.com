// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table.asset.chat
{
	import flash.display.*;
	import flash.events.*;
	public class ChatIcon extends flash.display.MovieClip
	{
		public var ciX:com.script.poker.table.asset.chat.ChatIconX;
		public function ChatIcon():void
		{
			ciX = new ChatIconX();
			addChild(ciX);
			ciX.x = 2;
			ciX.y = 2;
		}
	}
}