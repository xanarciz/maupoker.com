// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.display
{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.system.*;
	public class SafeImageLoader extends flash.display.Loader
	{
		private var request:flash.net.URLRequest;
		private var defaultImageUrl:String = "";
		private var context:flash.system.LoaderContext;
		private static const DOMAIN_WHITELIST:Array = new Array(".cas2.inn");
		private static const DEFAULT_PROFILE_IMAGE_URL:String = "../Avatar/default.jpg";
		public function SafeImageLoader(p__1:String = ""):void
		{
			this.defaultImageUrl = (p__1) ? (p__1) : SafeImageLoader.DEFAULT_PROFILE_IMAGE_URL;
		}
		override public function load(p__1:flash.net.URLRequest, p__2:flash.system.LoaderContext = null):void
		{
			this.unload();
			if (((p__1) == null) || !(p__1.url)){
				this.loadDefaultImage();
				return;
			}
			if ((p__2) == null){
				p__2 = new LoaderContext();
				
			}
			if (checkValidUrl(p__1.url)){
				this.request = p__1;
				this.context = p__2;
				this.addEventListeners();
				super.load(p__1, p__2);
			} else {
				this.loadDefaultImage();
			}
		}
		private function addEventListeners():void
		{
			try {
				this.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onComplete);
				this.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, this.onProgress);
				this.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
				this.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
			} catch (e:Error) {
			}
		}
		private function removeEventListeners():void
		{
			try {
				this.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.onComplete);
				this.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, this.onProgress);
				this.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
				this.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
			} catch (e:Error) {
			}
		}
		private function onProgress(p__1:flash.events.ProgressEvent):void
		{
			if (this.contentLoaderInfo.contentType != null){
				switch(this.contentLoaderInfo.contentType){
					case "image/jpeg":
					{
					}
					case "image/gif":
					{
					}
					case "image/png":
					{
						break;
					}
					case "application/x-shockwave-flash":
					{
					}
					default:
					{
						(p__1).stopImmediatePropagation();
						this.close();
						this.loadDefaultImage();
						break;
					}
				}
			}
		}
		private function onComplete(p__1:flash.events.Event):void
		{
			switch(this.contentLoaderInfo.contentType){
				case "image/jpeg":
				{
				}
				case "image/gif":
				{
				}
				case "image/png":
				{
					this.removeEventListeners();
					break;
				}
				case "application/x-shockwave-flash":
				{
				}
				default:
				{
					(p__1).stopImmediatePropagation();
					this.unload();
					this.loadDefaultImage();
					break;
				}
			}
		}
		private function onIOError(p__1:flash.events.IOErrorEvent):void
		{
			this.loadDefaultImage();
		}
		private function onSecurityError(p__1:flash.events.SecurityErrorEvent):void
		{
			this.loadDefaultImage();
		}
		private function loadDefaultImage():void
		{
			this.removeEventListeners();
			if ((this.request == null) || !(this.request.url == this.defaultImageUrl)){
				this.load(new URLRequest(this.defaultImageUrl), this.context);
			}
		}
		private function checkValidUrl(p__1:String):Boolean
		{
			var l__4:String;
			var l__5:Boolean;
			var l__6:String;
			var l__2:RegExp = /^http:\/\/([\w\.-]+)(\/[^\?]+)$/i;
			var l__3:Object = l__2.exec(p__1);
			/*
			if (l__3 != null){
				l__4 = l__3[1];
				l__5 = false;
				for each (l__6 in SafeImageLoader.DOMAIN_WHITELIST){
					if (l__4.substring(l__4.length - l__6.length) == l__6){
						l__5 = true;
						break;
					}
				}
				return(l__5 ? true : false);
			} else {
				return(false);
			}
			*/
			l__5 = true;
			return(l__5 ? true : false);
		}
	}
}