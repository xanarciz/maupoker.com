// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table
{
	import flash.display.MovieClip;
	import com.script.draw.Box;
	import com.script.text.TextBox;
	public class StatusController
	{
		public var mt:com.script.poker.table.TableView;
		public var aCoords:Array;
		private var cont:flash.display.MovieClip;
		public var bubbleArray:Array = new Array();
		private var langs;
		public function StatusController(p__1:com.script.poker.table.TableView, p__2:flash.display.MovieClip)
		{
			mt = p__1;
			cont = p__2;
			aCoords = mt.aChickletCoorData;
			langs = mt.langs;
		}
		public function setPlayerAction(p__1:int, p__2:String, p__3:Number = -1, p__4:String = ""):void
		{
			var l__5:String = p__4;
			switch(p__2){
				case "fold":
				{
					showBubble(p__1, langs.l_fold, -1);
					break;
				}
				case "call":
				{
					showBubble(p__1, langs.l_call, p__3);
					break;
				}
				case "check":
				{
					showBubble(p__1, langs.l_cek, -1);
					break;
				}
				case "allin":
				{
					showBubble(p__1, langs.l_allin, -1);
					break;
				}
				case "raise":
				{
					showBubble(p__1, langs.l_raise, p__3);
					break;
				}
				case "winner":
				{
					showBubble(p__1, langs.l_winner, -1);
					break;
				}
				case "hand":
				{
					showBubble(p__1, "Hand", -1, p__4);
					break;
				}
			}
		}
		public function showBubble(p__1:int, p__2:String, p__3:Number = -1, p__4:String = ""):void
		{
			killBubbleBySit(p__1);
			var l__5:Object = new Object();
			l__5.alphas = [1, 1];
			l__5.ratios = [0, 255];
			l__5.colors = [0, 0];
			var l__6:uint = 12315135;
			var l__7:String = p__2;
			var l__8:Number = 10;
			if ((p__2) == "Hand"){
				l__7 = langs.l_winner;
			}
			var l__9:flash.display.MovieClip = new MovieClip();
			l__9.name = (p__1).toString();
			l__9.x = aCoords[p__1][0];
			l__9.y = (aCoords[p__1][1] + 27);
			l__9.alpha = 1;
			var l__10:com.script.text.TextBox = new TextBox(myriadTF, l__7.toUpperCase(), 12, l__6, "center", 120, true);
			l__10.y = 1;
			l__9.addChild(l__10);
			var l__11:com.script.draw.Box = new Box((l__10.width + 12), 15, l__5, true, true, 15);
			l__9.addChildAt(l__11, 0);
			cont.addChild(l__9);
			var l__12:Object = new Object();
			l__12.bubble = l__9;
			l__12.sit = p__1;
			bubbleArray.push(l__12);
		}
		public function killBubbleBySit(p__1:int)
		{
			var l__2:flash.display.MovieClip = cont.getChildByName((p__1).toString());
			if (l__2 != null){
				cont.removeChild(l__2);
				l__2 = null;
			}
		}
	}
}