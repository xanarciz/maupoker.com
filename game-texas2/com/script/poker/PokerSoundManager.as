// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker
{
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Timer;
	import com.script.io.LoadUrlVars;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
		import flash.media.SoundMixer;
	public class PokerSoundManager extends flash.events.EventDispatcher
	{
		public var playingSound:flash.media.Sound = new Sound();
		private var soundLoader:com.script.io.LoadUrlVars;
		private var preloadRandomIndex:int = 0;
		private var preloadHandler:String = "";
		private var xmlLoader:flash.net.URLLoader;
		private var bMute:Boolean = false;
		private var timerSequence:int = 0;
		public var aSound:Array;
		public var handlerMap:Array = new Array();
		private var playingHandler:String = "";
		private var preloadIndex:int = 0;
		public var soundList:XMLList;
		public var sc:flash.media.SoundChannel;
		public var sc2:flash.media.SoundChannel;
		public var soundLoadLength:int = 0;
		public var randomArray:Array = new Array();
		public var urlSoundMap:Array;
		public var snd:flash.media.Sound;
		private var bPreloadRandom:Boolean = false;
		public var aRandomSound:Array;
		private var playTimer:flash.utils.Timer = new Timer(0, 0);
		private var tSound:flash.media.Sound;
		public function PokerSoundManager(p__1:XML)
		{
			aSound = new Array();
			soundLoader = new LoadUrlVars();
			urlSoundMap = new Array();
			parse(p__1);
		}
		public function parse(p__1:XML):Array
		{
			var l__2:XML;
			soundList = p__1.children();
			for each (l__2 in soundList){
				handlerMap.push(l__2.attribute("handler"));
				if (urlSoundMap[l__2.attribute("handler")] == undefined){
					urlSoundMap[l__2.attribute("handler")] = new Array();
				}
				if (l__2.attribute("random")){
					urlSoundMap[l__2.attribute("handler")] = l__2.attribute("asset").split(",");
				} else {
					urlSoundMap[l__2.attribute("handler")].push(l__2.attribute("asset"));
				}
			}
			preloadSound();
		}
		public function preloadSound():void
		{
			if (preloadIndex < handlerMap.length){
				preloadHandler = handlerMap[preloadIndex];
				if (urlSoundMap[preloadHandler].length > 1){
					bPreloadRandom = true;
				} else {
					bPreloadRandom = false;
				}
				fetchSound(urlSoundMap[preloadHandler]);
			}
		}
		public function fetchSound(p__1:Array):void
		{
			tSound = new Sound();
			tSound.addEventListener(Event.COMPLETE, soundCache);
			if (bPreloadRandom){
				tSound.load(new URLRequest(p__1[preloadRandomIndex]));
			} else {
				tSound.load(new URLRequest(p__1[0]));
			}
		}
		public function soundCache(p__1:flash.events.Event):void
		{
			tSound.removeEventListener(Event.COMPLETE, soundCache);
			if (aSound[preloadHandler] == undefined){
				aSound[preloadHandler] = new Array();
			}
			aSound[preloadHandler].push(p__1.target as Sound);
			if (bPreloadRandom && ((preloadRandomIndex + 1) < urlSoundMap[preloadHandler].length)){
				preloadRandomIndex++;
				fetchSound(urlSoundMap[preloadHandler]);
			} else {
				preloadRandomIndex = 0;
				preloadIndex++;
				preloadSound();
			}
		}
		public function soundLoaded(p__1:flash.events.Event):void
		{
			playingSound = (p__1.target as Sound);
			sc = playingSound.play();
		}
		public function playSound(p__1:String):void
		{
			var l__3:flash.media.SoundTransform;
			var l__2:int = Math.random() * 1000;
			playingHandler = p__1;
			
			if ((aSound[p__1] == undefined) || (aSound[p__1] == null)){
				return;
			}
			if (aSound[p__1].length > 1){
				l__2 = (l__2 % aSound[p__1].length);
			} else {
				l__2 = 0;
			}
			if ((aSound[p__1][l__2] == null) || (aSound[p__1][l__2] == undefined)){
				
				snd.addEventListener(Event.COMPLETE, streamSound);
				snd.load(new URLRequest(urlSoundMap[evt.handler][l__2]));
			} else {
				
				playingSound = (aSound[p__1][l__2] as Sound);
				
				sc = playingSound.play();
				
				l__3 = new SoundTransform();
				
				if (sc == null) {
					return;
				}
				if (((p__1 == "sndTurnStart") || (p__1 == "PlayRemindSound")) || (p__1 == "playHurrySound")){
					l__3.volume = 0.1;
				} else {
					l__3.volume = 1;
				}
				
				if (bMute){
					l__3.volume = 0;
				}
				
				sc.soundTransform = l__3;
			}
		}
		public function streamSound(p__1:flash.events.Event):void
		{
			playingSound = (p__1.target as Sound);
			sc = playingSound.play();
		}
		public function directSoundPlay(p__1:String):void
		{
			playingHandler = p__1;
			playingSound = (aSound[p__1][0] as Sound);
			sc = playingSound.play();
		}
		public function stopSound():void
		{
			if (sc != null){
				sc.stop();
				
			}
		}
		public function stopSound_YourTurn(p__1:flash.events.Event):void
		{
			if (sc != null){
				sc.stop();
				trace("babbbbbb");
			}
			playTimer.removeEventListener(TimerEvent.TIMER, yourTurnSequence);
			timerSequence = 0;
		}
		public function Sound_Super():void
		{
			SoundMixer.stopAll();
			var mySound: Sound = new superr();
			sc2 = mySound.play();
		}
		public function Sound_Royal():void
		{
			SoundMixer.stopAll();
			var mySound: Sound = new royal();
			sc2 = mySound.play();
		}
		public function Sound_Str():void
		{
			SoundMixer.stopAll();
			var mySound: Sound = new straight();
			sc2 = mySound.play();
		}
		
		public function Sound_Fourk():void
		{
			SoundMixer.stopAll();
			var mySound: Sound = new fourkind();
			sc2 = mySound.play();
		}
		public function muteSound(p__1:Boolean):void
		{
			var l__2:flash.media.SoundTransform = new SoundTransform();
			var l__3:flash.media.SoundTransform = new SoundTransform();
			bMute = p__1;
			if (bMute){
				l__2.volume = 0;
				l__3.volume = 0;
			} else if (((playingHandler == "sndTurnStart") || (playingHandler == "PlayRemindSound")) || (playingHandler == "playHurrySound")){
				l__2.volume = 0.1;
				l__3.volume = 0.1;
			} else {
				l__2.volume = 1;
				l__3.volume = 1;
			}
			if (sc != null){
				
				sc.soundTransform = l__2;
				
			}
			if (sc2 != null){
				
				sc2.soundTransform = l__3;
				
			}
			
		}
	}
}