// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package fl.containers
{
	import flash.net.*;
	import fl.core.*;
	import flash.display.*;
	import flash.events.*;
	import flash.system.*;
	import fl.events.*;
	import flash.utils.*;
	public class UILoader extends fl.core.UIComponent
	{
		protected var loader:flash.display.Loader;
		protected var _autoLoad:Boolean = true;
		protected var _source:Object;
		protected var contentClip:flash.display.Sprite;
		protected var _maintainAspectRatio:Boolean = true;
		protected var contentInited:Boolean = false;
		protected var _scaleContent:Boolean = true;
		private static var defaultStyles:Object = {};
		public function UILoader()
		{
		}
		override public function setSize(p__1:Number, p__2:Number):void
		{
			if ((!_scaleContent) && (_width > 0)){
				return;
			}
			super.setSize(p__1, p__2);
		}
		public function get autoLoad():Boolean
		{
			return(_autoLoad);
		}
		public function set autoLoad(p__1:Boolean):void
		{
			_autoLoad = p__1;
			if (((_autoLoad && (loader == null)) && !(_source == null)) && !(_source == "")){
				load();
			}
		}
		public function get scaleContent():Boolean
		{
			return(_scaleContent);
		}
		public function set scaleContent(p__1:Boolean):void
		{
			if (_scaleContent == p__1){
				return;
			}
			_scaleContent = p__1;
			invalidate(fl.core.InvalidationType.SIZE);
		}
		public function get maintainAspectRatio():Boolean
		{
			return(_maintainAspectRatio);
		}
		public function set maintainAspectRatio(p__1:Boolean):void
		{
			_maintainAspectRatio = p__1;
			invalidate(fl.core.InvalidationType.SIZE);
		}
		public function get bytesLoaded():uint
		{
			return(((loader == null) || (loader.contentLoaderInfo == null)) ? 0 : loader.contentLoaderInfo.bytesLoaded);
		}
		public function get bytesTotal():uint
		{
			return(((loader == null) || (loader.contentLoaderInfo == null)) ? 0 : loader.contentLoaderInfo.bytesTotal);
		}
		public function loadBytes(bytes:flash.utils.ByteArray, context:flash.system.LoaderContext = null):void
		{
			_unload();
			initLoader();
			try {
				loader.loadBytes(bytes, context);
			} catch (error:*) {
				throw error;
			}
		}
		public function get content():flash.display.DisplayObject
		{
			if (loader != null){
				return(loader.content);
			}
			if (contentClip.numChildren){
				return(contentClip.getChildAt(0));
			}
			return(null);
		}
		public function get source():Object
		{
			return(_source);
		}
		public function set source(p__1:Object):void
		{
			if (p__1 == ""){
				return;
			}
			_source = p__1;
			_unload();
			if (_autoLoad && !(_source == null)){
				load();
			}
		}
		public function get percentLoaded():Number
		{
			return(((bytesTotal <= 0) ? 0 : ((bytesLoaded / bytesTotal) * 100)));
		}
		public function load(p__1:flash.net.URLRequest = null, p__2:flash.system.LoaderContext = null):void
		{
			var l__3:flash.display.DisplayObject;
			_unload();
			if (((p__1 == null) || (p__1.url == null)) && ((_source == null) || (_source == ""))){
				return;
			}
			l__3 = getDisplayObjectInstance(source);
			if (l__3 != null){
				contentClip.addChild(l__3);
				contentInited = true;
				invalidate(fl.core.InvalidationType.SIZE);
				return;
			}
			p__1 = p__1;
			if (p__1 == null){
				p__1 = new flash.net.URLRequest(_source.toString());
			}
			if (p__2 == null){
				p__2 = new flash.system.LoaderContext(false, flash.system.ApplicationDomain.currentDomain);
			}
			initLoader();
			loader.contentLoaderInfo.addEventListener(flash.events.IOErrorEvent.IO_ERROR, handleError, false, 0, true);
			loader.contentLoaderInfo.addEventListener(flash.events.SecurityErrorEvent.SECURITY_ERROR, handleError, false, 0, true);
			loader.contentLoaderInfo.addEventListener(flash.events.Event.OPEN, passEvent, false, 0, true);
			loader.contentLoaderInfo.addEventListener(flash.events.ProgressEvent.PROGRESS, passEvent, false, 0, true);
			loader.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, handleComplete, false, 0, true);
			loader.contentLoaderInfo.addEventListener(flash.events.Event.INIT, handleInit, false, 0, true);
			loader.contentLoaderInfo.addEventListener(flash.events.HTTPStatusEvent.HTTP_STATUS, passEvent, false, 0, true);
			loader.load(p__1, p__2);
		}
		public function unload():void
		{
			_source = null;
			_unload(true);
		}
		public function close():void
		{
			try {
				loader.close();
			} catch (error:*) {
				throw error;
			}
		}
		protected function _unload(throwError:Boolean = false):void
		{
			if (loader != null){
				clearLoadEvents();
				contentClip.removeChild(loader);
				try {
					loader.close();
				} catch (e:Error) {
				}
				try {
					loader.unload();
				} catch (e:*) {
					if (throwError){
						throw e;
					}
				}
				loader = null;
				return;
			}
			contentInited = false;
			if (contentClip.numChildren){
				contentClip.removeChildAt(0);
			}
		}
		protected function initLoader():void
		{
			loader = new flash.display.Loader();
			contentClip.addChild(loader);
		}
		protected function handleComplete(p__1:flash.events.Event):void
		{
			clearLoadEvents();
			passEvent(p__1);
		}
		protected function passEvent(p__1:flash.events.Event):void
		{
			dispatchEvent(p__1);
		}
		protected function handleError(p__1:flash.events.Event):void
		{
			passEvent(p__1);
			clearLoadEvents();
			loader.contentLoaderInfo.removeEventListener(flash.events.Event.INIT, handleInit);
		}
		protected function handleInit(p__1:flash.events.Event):void
		{
			loader.contentLoaderInfo.removeEventListener(flash.events.Event.INIT, handleInit);
			contentInited = true;
			passEvent(p__1);
			invalidate(fl.core.InvalidationType.SIZE);
		}
		protected function clearLoadEvents():void
		{
			loader.contentLoaderInfo.removeEventListener(flash.events.IOErrorEvent.IO_ERROR, handleError);
			loader.contentLoaderInfo.removeEventListener(flash.events.SecurityErrorEvent.SECURITY_ERROR, handleError);
			loader.contentLoaderInfo.removeEventListener(flash.events.Event.OPEN, passEvent);
			loader.contentLoaderInfo.removeEventListener(flash.events.ProgressEvent.PROGRESS, passEvent);
			loader.contentLoaderInfo.removeEventListener(flash.events.HTTPStatusEvent.HTTP_STATUS, passEvent);
			loader.contentLoaderInfo.removeEventListener(flash.events.Event.COMPLETE, handleComplete);
		}
		override protected function draw():void
		{
			if (isInvalid(fl.core.InvalidationType.SIZE)){
				drawLayout();
			}
			super.draw();
		}
		protected function drawLayout():void
		{
			var l__1:Boolean;
			var l__2:Number;
			var l__3:Number;
			var l__4:Number;
			var l__5:Number;
			var l__6:flash.display.LoaderInfo;
			if (!contentInited){
				return;
			}
			l__1 = false;
			if (loader){
				l__6 = loader.contentLoaderInfo;
				l__2 = l__6.width;
				l__3 = l__6.height;
			} else {
				l__2 = contentClip.width;
				l__3 = contentClip.height;
			}
			l__4 = _width;
			l__5 = _height;
			if (!_scaleContent){
				_width = contentClip.width;
				_height = contentClip.height;
			} else {
				sizeContent(contentClip, l__2, l__3, _width, _height);
			}
			if (!(l__4 == _width) || !(l__5 == _height)){
				dispatchEvent(new fl.events.ComponentEvent(fl.events.ComponentEvent.RESIZE, true));
			}
		}
		protected function sizeContent(p__1:flash.display.DisplayObject, p__2:Number, p__3:Number, p__4:Number, p__5:Number):void
		{
			var l__6:Number;
			var l__7:Number;
			var l__8:Number;
			var l__9:Number;
			l__6 = p__4;
			l__7 = p__5;
			if (_maintainAspectRatio){
				l__8 = p__4 / p__5;
				l__9 = p__2 / p__3;
				if (l__8 < l__9){
					l__7 = l__6 / l__9;
				} else {
					l__6 = l__7 * l__9;
				}
			}
			p__1.width = l__6;
			p__1.height = l__7;
			p__1.x = (p__4 / 2 - (l__6 / 2));
			p__1.y = (p__5 / 2 - (l__7 / 2));
		}
		override protected function configUI():void
		{
			super.configUI();
			contentClip = new flash.display.Sprite();
			addChild(contentClip);
		}
		public static function getStyleDefinition():Object
		{
			return(defaultStyles);
		}
	}
}