// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package ws.tink.core
{
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.IOErrorEvent;
	import flash.events.EventDispatcher;
	import flash.display.Loader;
	import flash.display.Sprite;
	import ws.tink.events.*;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.*;
	import flash.system.LoaderContext;
	import flash.system.ApplicationDomain;
	public class Library extends flash.events.EventDispatcher
	{
		private var _name:String;
		private var _bytesLoaded:Number = 0;
		private var _embeddedLoaders:Array;
		private var _runtimeURLs:Array;
		private var _bytesTotal:Number = 0;
		private var _runtimeCompletes:Array;
		private var _embeddedComplete:Boolean;
		private var nRetrySWF:int = 0;
		private var nRetryLimitSWF:int = 2;
		private var nRetryLimitXML:int = 2;
		private var _enterFrameDispatcher:flash.display.Sprite;
		private var _xmlUrls:Array;
		private var nRetryXML:int = 0;
		private var _runtimeLoaders:Array;
		private var _curAsset:int;
		private var _runtimeComplete:Boolean;
		private var _assetUrls:Array;
		public function Library(p__1:String)
		{
			_name = p__1;
			initialize();
		}
		public function get name():String
		{
			return(_name);
		}
		public function get bytesLoaded():Number
		{
			return(_bytesLoaded);
		}
		public function get bytesTotal():Number
		{
			return(_bytesTotal);
		}
		public function get complete():Boolean
		{
			return(_embeddedComplete && _runtimeComplete);
		}
		public function get embeddedComplete():Boolean
		{
			return(_embeddedComplete);
		}
		public function get runtimeComplete():Boolean
		{
			return(_runtimeComplete);
		}
		public function loadSWF(p__1:String):void
		{
			var l__2:flash.display.Loader = new Loader();
			var l__3:flash.system.LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
			l__2.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onLoaderProgress);
			l__2.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaderComplete);
			l__2.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			l__2.load(new URLRequest(p__1), l__3);
			_runtimeLoaders.push(l__2);
			_runtimeCompletes.push(false);
		}
		public function loadXML(p__1:String):void
		{
			var l__2:flash.net.URLLoader = new URLLoader();
			l__2.addEventListener(Event.COMPLETE, onXMLLoaderComplete);
			l__2.load(new URLRequest(p__1));
			_runtimeLoaders.push(l__2);
			_runtimeURLs.push(p__1);
			_runtimeCompletes.push(false);
		}
		public function embedSWF(p__1:Class):void
		{
			var l__2:flash.display.Loader = new Loader();
			l__2.loadBytes((new p__1()) as ByteArray);
			_embeddedLoaders.push(l__2);
		}
		public function loadSWFS(p__1:Array):void
		{
			_runtimeComplete = false;
			var l__2:int = p__1.length;
			var l__3:int;
			while(l__3 < l__2){
				loadSWF((p__1[l__3]) as String);
				l__3++;
			}
		}
		public function loadSWFS_sequential(p__1:Array):void
		{
			_assetUrls = (p__1).concat();
			startSequentialLoad();
		}
		private function loadSWF_seq(p__1:String):void
		{
			var l__2:flash.display.Loader = new Loader();
			var l__3:flash.system.LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
			l__2.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onLoaderProgress_seq);
			l__2.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaderComplete_seq);
			l__2.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler_swf);
			l__2.load(new URLRequest(p__1), l__3);
			_runtimeLoaders.push(l__2);
		}
		public function loadXML_seq(p__1:String):void
		{
			var l__2:flash.net.URLLoader = new URLLoader();
			l__2.addEventListener(Event.COMPLETE, onXMLLoaderComplete_seq);
			l__2.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler_xml);
			l__2.load(new URLRequest(p__1));
			_runtimeLoaders.push(l__2);
			_runtimeURLs.push(p__1);
			_runtimeCompletes.push(false);
		}
		private function startSequentialLoad(p__1:String = ""):void
		{
			_curAsset = 0;
			if ((p__1) == "xml"){
				loadXML_seq(_xmlUrls[_curAsset]);
			} else {
				loadSWF_seq(_assetUrls[_curAsset]);
			}
			
		}
		private function loadNext(p__1:* = ""):void
		{
			_curAsset++;
			if ((p__1) == "xml"){
				if (_curAsset == _xmlUrls.length){
					_runtimeComplete = true;
					dispatchEvent(new LibraryEvent(LibraryEvent.LOAD_COMPLETE, false, false));
				} else {
					loadXML_seq(_xmlUrls[_curAsset]);
				}
			} else if (_curAsset == _assetUrls.length){
				_runtimeComplete = true;
				dispatchEvent(new LibraryEvent(LibraryEvent.LOAD_COMPLETE, false, false));
			} else {
				loadSWF_seq(_assetUrls[_curAsset]);
			}
		}
		public function loadXMLS(... p__1):void
		{
			_runtimeComplete = false;
			var l__2:int = p__1.length;
			var l__3:int;
			while(l__3 < l__2){
				loadXML((p__1[l__3]) as String);
				l__3++;
			}
		}
		public function loadXMLS_sequential(p__1:Array):void
		{
			_xmlUrls = (p__1).concat();
			startSequentialLoad("xml");
		}
		public function embedSWFS(... p__1):void
		{
			var l__2:flash.display.Loader;
			var l__3:Class;
			if (_enterFrameDispatcher.hasEventListener(Event.ENTER_FRAME)){
				_enterFrameDispatcher.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			}
			_embeddedComplete = false;
			var l__4:Number = p__1.length;
			var l__5:int;
			while(l__5 < l__4){
				l__3 = Class(p__1[l__5]);
				l__2 = new Loader();
				l__2.loadBytes((new l__3()) as ByteArray);
				_embeddedLoaders.push(l__2);
				l__5++;
			}
			_enterFrameDispatcher.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		public function getDefinition(p__1:String):Class
		{
			var l__2:flash.display.Loader;
			var l__3:int;
			var l__4:int;
			l__3 = _embeddedLoaders.length;
			l__4 = 0;
			while(l__4 < l__3){
				l__2 = Loader(_embeddedLoaders[l__4]);
				if (l__2.contentLoaderInfo.applicationDomain.hasDefinition(p__1)){
					return(l__2.contentLoaderInfo.applicationDomain.getDefinition(p__1) as Class);
				}
				l__4++;
			}
			l__3 = _runtimeLoaders.length;
			l__4 = 0;
			while(l__4 < l__3){
				l__2 = Loader(_runtimeLoaders[l__4]);
				if (l__2.contentLoaderInfo.applicationDomain.hasDefinition(p__1)){
					return(l__2.contentLoaderInfo.applicationDomain.getDefinition(p__1) as Class);
				}
				l__4++;
			}
			throw new ReferenceError(("ReferenceError: Error #1065: Variable " + p__1) + " is not defined.");
		}
		public function getLoader(p__1:String):flash.display.Loader
		{
			var l__2:flash.display.Loader;
			var l__3:int;
			var l__4:int;
			var l__5:Class;
			l__3 = _embeddedLoaders.length;
			l__4 = 0;
			while(l__4 < l__3){
				l__2 = Loader(_embeddedLoaders[l__4]);
				if (l__2.contentLoaderInfo.applicationDomain.hasDefinition(p__1)){
					return(l__2);
				}
				l__4++;
			}
			l__3 = _runtimeLoaders.length;
			l__4 = 0;
			while(l__4 < l__3){
				l__2 = Loader(_runtimeLoaders[l__4]);
				if (l__2.contentLoaderInfo.applicationDomain.hasDefinition(p__1)){
					return(l__2);
				}
				l__4++;
			}
			throw new ReferenceError(("ReferenceError: Error #1066: Loader for " + p__1) + " is not defined.");
		}
		public function getLoaderByType(className:String):flash.display.Loader
		{
			var loader:flash.display.Loader;
			var numLoaders:int;
			var i:int;
			var tClass:Class;
			numLoaders = _embeddedLoaders.length;
			i = 0;
			while(i < numLoaders){
				loader = Loader(_embeddedLoaders[i]);
				tClass = (loader.contentLoaderInfo.applicationDomain.getDefinition(className) as Class);
				try {
					tClass(loader.content);
					return(loader);
				} catch (err:TypeError) {
				}
				i++;
			}
			numLoaders = _runtimeLoaders.length;
			i = 0;
			while(i < numLoaders){
				loader = Loader(_runtimeLoaders[i]);
				i++;
			}
			i = 0;
			while(i < numLoaders){
			
				loader = Loader(_runtimeLoaders[i]);
				tClass = (loader.contentLoaderInfo.applicationDomain.getDefinition(className) as Class);
				try {
					tClass(loader.content);
					return(loader);
				} catch (err:TypeError) {
				}
				i++;
			}
			throw new ReferenceError(("ReferenceError: Error #1066: Loader for " + className) + " is not defined.");
			
		}
		public function getDefinitionByType(className:String):Class
		{
			var loader:flash.display.Loader;
			var numLoaders:int;
			var i:int;
			var tClass:Class;
			numLoaders = _embeddedLoaders.length;
			i = 0;
			while(i < numLoaders){
				loader = Loader(_embeddedLoaders[i]);
				tClass = (loader.contentLoaderInfo.applicationDomain.getDefinition(className) as Class);
				try {
					tClass(loader.content);
					return(tClass);
				} catch (err:TypeError) {
				}
				i++;
			}
			numLoaders = _runtimeLoaders.length;
			i = 0;
			while(i < numLoaders){
				loader = Loader(_runtimeLoaders[i]);
				i++;
			}
			i = 0;
			while(i < numLoaders){
				loader = Loader(_runtimeLoaders[i]);
				tClass = (loader.contentLoaderInfo.applicationDomain.getDefinition(className) as Class);
				try {
					tClass(loader.content);
					return(tClass);
				} catch (err:TypeError) {
				}
				i++;
			}
			throw new ReferenceError(("ReferenceError: Error #1066: Loader for " + className) + " is not defined.");
		}
		public function getXML(p__1:String)
		{
			var l__2:flash.net.URLLoader;
			var l__3:int;
			var l__4:int;
			l__3 = _runtimeLoaders.length;
			l__4 = 0;
			while(l__4 < l__3){
				l__2 = URLLoader(_runtimeLoaders[l__4]);
				if (_runtimeURLs[l__4] == (p__1)){
					return(l__2);
				}
				l__4++;
			}
			throw new ReferenceError(("ReferenceError: Error #1066: Loader for " + p__1) + " is not defined.");
		}
		public function contains(p__1:String):Boolean
		{
			var l__2:flash.display.Loader;
			var l__3:Number = _embeddedLoaders.length;
			var l__4:int;
			while(l__4 < l__3){
				l__2 = Loader(_embeddedLoaders[l__4]);
				if (l__2.contentLoaderInfo.applicationDomain.hasDefinition(p__1)){
					return(true);
				}
				l__4++;
			}
			return(false);
		}
		public function reset():void
		{
			destroy();
			initialize();
		}
		public function destroy():void
		{
			var l__1:flash.display.Loader;
			var l__2:int;
			var l__3:int;
			if (_enterFrameDispatcher.hasEventListener(Event.ENTER_FRAME)){
				_enterFrameDispatcher.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			}
			l__2 = _runtimeLoaders.length;
			l__3 = 0;
			while(l__3 < l__2){
				l__1 = Loader(_runtimeLoaders[l__3]);
				if (!_runtimeCompletes[l__3]){
					l__1.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onLoaderProgress);
					l__1.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoaderComplete);
					l__1.close();
				} else {
					l__1.unload();
				}
				l__3++;
			}
			l__2 = _embeddedLoaders.length;
			l__3 = 0;
			while(l__3 < l__2){
				l__1 = Loader(_embeddedLoaders[l__3]);
				l__1.unload();
				l__3++;
			}
			_embeddedLoaders = null;
			_runtimeLoaders = null;
			_runtimeCompletes = null;
			_runtimeURLs = null;
			_enterFrameDispatcher = null;
			_name = null;
			_bytesLoaded = undefined;
			_bytesTotal = undefined;
		}
		private function initialize():void
		{
			_embeddedLoaders = new Array();
			_runtimeLoaders = new Array();
			_runtimeCompletes = new Array();
			_runtimeURLs = new Array();
			_assetUrls = new Array();
			_enterFrameDispatcher = new Sprite();
			_bytesLoaded = 0;
			_bytesTotal = 0;
		}
		private function onLoaderProgress_seq(p__1:flash.events.ProgressEvent):void
		{
			
			var l__4:flash.display.Loader;
			var l__2:Number;
			var l__3:Number;
			l__4 = Loader(_runtimeLoaders[_curAsset]);
			l__2 = l__4.contentLoaderInfo.bytesTotal;
			l__3 = l__4.contentLoaderInfo.bytesLoaded;
			dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS, false, false, l__3, l__2));
		}
		private function onLoaderComplete_seq(p__1:flash.events.Event):void
		{
			var l__2:flash.display.Loader = Loader(p__1.target.loader);
			l__2.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onLoaderProgress_seq);
			l__2.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoaderComplete_seq);
			l__2.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler_swf);
			dispatchEvent(new LibraryEvent(LibraryEvent.FILE_COMPLETE, false, false));
			loadNext();
		}
		private function onXMLLoaderComplete_seq(p__1:flash.events.Event):void
		{
			var l__2:flash.net.URLLoader = URLLoader(p__1.target);
			l__2.removeEventListener(Event.COMPLETE, onXMLLoaderComplete);
			l__2.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler_xml);
			dispatchEvent(new LibraryEvent(LibraryEvent.FILE_COMPLETE, false, false));
			loadNext("xml");
		}
		private function onEnterFrame(p__1:flash.events.Event):void
		{
			_enterFrameDispatcher.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			_embeddedComplete = true;
			dispatchEvent(new LibraryEvent(LibraryEvent.EMBED_COMPLETE, false, false));
		}
		private function onLoaderProgress(p__1:flash.events.ProgressEvent):void
		{
			checkLoadersProgress();
		}
		private function onLoaderComplete(p__1:flash.events.Event):void
		{
			var l__2:flash.display.Loader = Loader(p__1.target.loader);
			l__2.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onLoaderProgress);
			l__2.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoaderComplete);
			var l__3:int = _runtimeLoaders.length;
			var l__4:int;
			while(l__4 < l__3){
				if (l__2 == Loader(_runtimeLoaders[l__4])){
					_runtimeCompletes[l__4] = true;
					break;
				}
				l__4++;
			}
			dispatchEvent(new LibraryEvent(LibraryEvent.FILE_COMPLETE, false, false));
			checkLoadersProgress(true);
		}
		private function onXMLLoaderComplete(p__1:flash.events.Event):void
		{
			var l__2:flash.net.URLLoader = URLLoader(p__1.target);
			l__2.removeEventListener(Event.COMPLETE, onXMLLoaderComplete);
			var l__3:int = _runtimeLoaders.length;
			var l__4:int;
			while(l__4 < l__3){
				if (l__2 == URLLoader(_runtimeLoaders[l__4])){
					_runtimeCompletes[l__4] = true;
					break;
				}
				l__4++;
			}
			dispatchEvent(new LibraryEvent(LibraryEvent.FILE_COMPLETE, false, false));
			checkURLLoadersProgress(true);
		}
		private function checkLoadersProgress(p__1:Boolean = false):void
		{
			var l__4:flash.display.Loader;
			var l__2:Number;
			var l__3:Number;
			p__1 = true;
			var l__5:int = _runtimeLoaders.length;
			var l__6:int;
			while(l__6 < l__5){
				l__4 = Loader(_runtimeLoaders[l__6]);
				l__2 = (l__2 + l__4.contentLoaderInfo.bytesTotal);
				l__3 = (l__3 + l__4.contentLoaderInfo.bytesLoaded);
				if (!_runtimeCompletes[l__6]){
					p__1 = false;
				}
				l__6++;
			}
			_bytesLoaded = l__3;
			_bytesTotal = l__2;
			if (p__1){
				_runtimeComplete = true;
				dispatchEvent(new LibraryEvent(LibraryEvent.LOAD_COMPLETE, false, false));
			} else {
				dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS, false, false, l__3, l__2));
			}
		}
		private function checkURLLoadersProgress(p__1:Boolean = false):void
		{
			var l__4:flash.net.URLLoader;
			var l__2:Number;
			var l__3:Number;
			p__1 = true;
			var l__5:int = _runtimeLoaders.length;
			var l__6:int;
			while(l__6 < l__5){
				l__4 = URLLoader(_runtimeLoaders[l__6]);
				l__2 = (l__2 + l__4.bytesTotal);
				l__3 = (l__3 + l__4.bytesLoaded);
				if (!_runtimeCompletes[l__6]){
					p__1 = false;
				}
				l__6++;
			}
			_bytesLoaded = l__3;
			_bytesTotal = l__2;
			if (p__1){
				_runtimeComplete = true;
				dispatchEvent(new LibraryEvent(LibraryEvent.LOAD_COMPLETE, false, false));
			} else {
				dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS, false, false, l__3, l__2));
			}
		}
		private function ioErrorHandler(p__1:flash.events.IOErrorEvent):void
		{
			dispatchEvent(new LibraryEvent(LibraryEvent.LOAD_ERROR, false, false));
		}
		private function ioErrorHandler_swf(p__1:flash.events.IOErrorEvent):void
		{
			var l__2:flash.display.Loader;
			var l__3:flash.system.LoaderContext;
			if ((nRetrySWF < nRetryLimitSWF) && !(_assetUrls[_curAsset] == null)){
				l__2 = _runtimeLoaders[_runtimeLoaders.length - 1];
				l__3 = new LoaderContext(false, ApplicationDomain.currentDomain);
				l__2.load(new URLRequest(_assetUrls[_curAsset]), l__3);
			} else {
				dispatchEvent(new LibraryEvent(LibraryEvent.LOAD_ERROR, false, false));
			}
			nRetrySWF++;
		}
		private function ioErrorHandler_xml(p__1:flash.events.IOErrorEvent):void
		{
			var l__2:flash.net.URLLoader;
			if ((nRetryXML < nRetryLimitXML) && !(_runtimeURLs[_runtimeURLs.length - 1] == null)){
				l__2 = _runtimeLoaders[_runtimeLoaders.length - 1];
				l__2.load(new URLRequest(_runtimeURLs[_runtimeURLs.length - 1]));
			} else {
				dispatchEvent(new LibraryEvent(LibraryEvent.LOAD_ERROR, false, false));
			}
			nRetryXML++;
		}
	}
}