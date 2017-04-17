// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker
{
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import com.script.io.LoadUrlVars;
	public class PokerStatsManager extends flash.events.EventDispatcher
	{
		private var oDelayedHit:Object = new Object();
		private var pgData:com.script.poker.PokerGlobalData;
		private var xmlStats:XML;
		private var xmlLoader:flash.net.URLLoader = new URLLoader();
		private var delayedHit:Boolean = false;
		private var hit:com.script.io.LoadUrlVars = new LoadUrlVars();
		public var aStats:Array;
		public function PokerStatsManager(p__1:XML)
		{
			aStats = new Array();
			xmlStats = p__1;
			parseConfig(xmlStats);
			addEventListener(StatsEvent.RECORD, hitStatServer);
		}
		public function loadStatsConfig(p__1:String):void
		{
			var l__2:flash.net.URLRequest = new URLRequest(p__1);
			var l__3:flash.net.URLLoader = new URLLoader();
			l__3.addEventListener(Event.COMPLETE, onXMLLoaded);
			l__3.load(l__2);
		}
		public function onXMLLoaded(p__1:flash.events.Event):void
		{
			var l__2:XML = new XML(p__1.target.data);
			parseConfig(l__2);
		}
		public function startPokerStatsManager(p__1:com.script.poker.PokerGlobalData):void
		{
			pgData = p__1;
		}
		public function hitStatServer(p__1:com.script.poker.StatsEvent):void
		{
			var l__2:com.script.io.LoadUrlVars = new LoadUrlVars();
			l__2.loadURL(p__1.url, "", "POST");
		}
		public function record(p__1:String):void
		{
			var l__2:com.script.io.LoadUrlVars = new LoadUrlVars();
			l__2.loadURL(p__1, "", "POST");
		}
		public function rec(controller:*, event:*):void
		{
			var url:String;
			var statHit:com.script.io.LoadUrlVars;
			try {
				url = aStats[controller][event][pgData.sn_id];
				statHit = new LoadUrlVars();
				statHit.loadURL(url, "", "POST");
			} catch (error:*) {
				delayedHit = true;
				oDelayedHit[controller] = event;
			}
		}
		public function parseConfig(p__1:XML):Array
		{
			var l__3:XML;
			var l__4:XMLList;
			var l__5:XML;
			var l__6:XMLList;
			var l__7:XML;
			var l__8:Array;
			var l__9:Array = new Array()
			var l__9:* = undefined;
			var l__10:int;
			var l__11:* = undefined;
			var l__2:XMLList = p__1.children();
			for each (l__3 in l__2){
				if (l__3.name() == "group"){
					if (aStats[l__3.attributes()] == undefined){
						aStats[l__3.attributes()] = new Array();
					}
					l__4 = l__3.children();
					for each (l__5 in l__4){
						aStats[l__3.attributes()][l__5.attributes()] = new Array();
						l__6 = l__5.children();
						for each (l__7 in l__6){
							l__8 = l__7.attribute("snid").split(",");
							l__9 = l__7.attribute("url");
							aStats[l__3.attributes()][l__5.attributes()][int(l__8)] = l__9;
							l__10 = 0;
							while(l__10 < l__8.length){
								aStats[l__3.attributes()][l__5.attributes()][int(l__8[l__10])] = l__9;
								l__10++;
							}
						}
					}
				}
			}
			if (delayedHit){
				delayedHit = false;
				for (l__11 in oDelayedHit){
					rec(l__11, oDelayedHit[l__11]);
				}
			}
		}
	}
}