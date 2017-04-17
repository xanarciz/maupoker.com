// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.ProgressEvent;
	import flash.events.EventDispatcher;
	import ws.tink.managers.*;
	import ws.tink.core.Library;
	import ws.tink.events.LibraryEvent;
	public class EmoLibrary extends flash.display.MovieClip
	{
		private var mbSwfEmoAssetsLoaded:Boolean = false;
		private var maCatOrder:* = new Array();
		private var maAllEmo:* = new Array();
		private var msDefaultCategory:String = null;
		private var maPreloadImageEmoUrls:Array = new Array();
		private var mSwfManifest:ws.tink.core.Library = null;
		private var maAllCats:* = new Array();
		private var maPreloadAnimatedEmoUrls:Array = new Array();
		private static const knIMAGE_SIZE_60x60:* = 1;
		private static var mSingletonInst:com.script.poker.table.EmoLibrary = null;
		private static const knIMAGE_SIZE_40x40:* = 0;
		private static const knIMAGE_SIZE_100x100:* = 2;
		private static var mbHasLoadedAllEmoInfo:Boolean = false;
		public function EmoLibrary(p__1:EmoLibrary_SingletonLockingClass)
		{
			if (mSingletonInst || ((p__1) == null)){
				throw new Error("EmoLibrary class cannot be instantiated");
			}
			mSingletonInst = this;
		}
		private function Preloading_PushEmoUrl(p__1:String, p__2:String):void
		{
			var l__3:com.script.poker.table.EmoItem = GetEmo(p__2);
			if (!l__3){
				return;
			}
			if (!(l__3.msPicAs3Url == null) && (l__3.msPicAs3Url.lastIndexOf(".swf") >= 0)){
				Preloading_PushAnimatedEmoUrl(l__3.msPicAs3Url, p__2);
			} else {
				Preloading_PushImageEmoUrl(l__3.msPicAs3Url, p__2);
			}
		}
		private function Preloading_PushAnimatedEmoUrl(p__1:String, p__2:String)
		{
			if (!((p__1) == null) && !((p__1) == "")){
				maPreloadAnimatedEmoUrls.push(p__1);
			}
		}
		private function Preloading_PushImageEmoUrl(p__1:String, p__2:String)
		{
			var l__3:com.script.poker.table.EmoItem = GetEmo(p__2);
			if (!l__3){
				return;
			}
			if (!((p__1) == null) && !((p__1) == "")){
				l__3.msPreloadedPicUrl = p__1;
			}
		}
		private function Preloading_Execute()
		{
			LoadSwfManifest(maPreloadAnimatedEmoUrls);
			LoadNonSwfImages(maPreloadImageEmoUrls);
		}
		private function LoadNonSwfImages(p__1:Array):void
		{
			var l__2:* = undefined;
			var l__3:com.script.poker.table.EmoItemInst;
			for (l__2 in maAllEmo){
				if (maAllEmo[l__2].msPreloadedPicUrl){
					l__3 = new EmoItemInst(maAllEmo[l__2].msPreloadedPicUrl, maAllEmo[l__2]);
					ReleaseEmoMovieClip(l__3);
				}
			}
		}
		private function LoadSwfManifest(p__1:Array):void
		{
			if (!((p__1) == null) && ((p__1.length) > 0)){
				
				mSwfManifest = LibraryManager.libraryManager.createLibrary("EmoManifest");
				mSwfManifest.addEventListener(LibraryEvent.LOAD_COMPLETE, OnEmoManifestLoaded);
				mSwfManifest.addEventListener(ProgressEvent.PROGRESS, OnEmoManifestProgress);
				mSwfManifest.addEventListener(LibraryEvent.FILE_COMPLETE, updateProgressIndicator);
				mSwfManifest.addEventListener(LibraryEvent.LOAD_ERROR, onLoadError);
				mSwfManifest.loadSWFS_sequential(p__1);
			}
		}
		private function OnEmoManifestLoaded(p__1:ws.tink.events.LibraryEvent):void
		{
			mbSwfEmoAssetsLoaded = true;
		}
		private function OnEmoManifestProgress(p__1:flash.events.ProgressEvent):void
		{
		}
		private function updateProgressIndicator(p__1:ws.tink.events.LibraryEvent):void
		{
		}
		private function onLoadError(p__1:ws.tink.events.LibraryEvent):void
		{
			trace("error load")
		}
		public function GetIsSwfEmoAssetsLoaded():Boolean
		{
			return(mbSwfEmoAssetsLoaded);
		}
		public function GetClassDefinition(p__1:com.script.poker.table.EmoItem):Class
		{
			if (mbSwfEmoAssetsLoaded){
				return(mSwfManifest.getDefinition(p__1.msClassDef) as Class);
			}
			return(null);
		}
		public function HasLoadedAllEmoInfo():Boolean
		{
			return(mbHasLoadedAllEmoInfo);
		}
		public function GetDefaultCategory():String
		{
			return(msDefaultCategory);
		}
		public function GetEmo(p__1:String):com.script.poker.table.EmoItem
		{
			if (!maAllEmo[p__1]){
				return(null);
			}
			return(maAllEmo[p__1]);
		}
		public function GetAllCategories():Array
		{
			return(maAllCats);
		}
		public function GetEmoCategory(p__1:String):com.script.poker.table.EmoCategory
		{
			if (!maAllCats[p__1]){
				return(null);
			}
			
			
			return(maAllCats[p__1]);
		}
		public function GetCategoryOrder():Array
		{
			return(maCatOrder);
		}
		public function GetEmoArrayForCategory(p__1:String):Array
		{
			var l__5:* = undefined;
			var l__2:Array = new Array();
			var l__3:com.script.poker.table.EmoCategory = maAllCats[p__1];
			if (l__3 == null){
				return(l__2);
			}
			var l__4:* = 0;
			while(l__4 < l__3.maEmoInCat.length){
				l__5 = l__3.maEmoInCat[l__4];
				if (!maAllEmo[l__5]){
				} else {
					l__2.push(maAllEmo[l__5]);
				}
				l__4++;
			}
			return(l__2);
		}
		public function AddEmoInfoList(p__1:*)
		{
			var l__3:* = undefined;
			var l__4:com.script.poker.table.EmoItem;
			var l__2 = 0;
			while(l__2 < (p__1[0].length)){
				l__3 = p__1[0][l__2].id;
				if (!maAllEmo[l__3]){
					maAllEmo[l__3] = new EmoItem();
				}
				l__4 = (maAllEmo[l__3] as EmoItem);
				if (p__1[0][l__2].id){
					l__4.mnId = p__1[0][l__2].id;
				}
				l__4.mbUserFilter = (p__1[0][l__2].userFilter) ? true : false;
				if (p__1[0][l__2].picLargeUrl){
					l__4.msPicLargeUrl = p__1[0][l__2].picLargeUrl;
				}
				if (p__1[0][l__2].picMediumUrl){
					l__4.msPicMediumUrl = p__1[0][l__2].picMediumUrl;
				}
				if (p__1[0][l__2].picSmallUrl){
					l__4.msPicSmallUrl = p__1[0][l__2].picSmallUrl;
				}
				if (p__1[0][l__2].picAs3Url){
					l__4.msPicAs3Url = p__1[0][l__2].picAs3Url;
				}
				if (p__1[0][l__2].as3Classname){
					l__4.msClassDef = p__1[0][l__2].as3Classname;
				}
				if (p__1[0][l__2].name){
					l__4.msName = p__1[0][l__2].name;
				}
				if (p__1[0][l__2].actionText){
					l__4.msActionText = p__1[0][l__2].actionText;
				}
				if (p__1[0][l__2].clientData){
					l__4.msClientData = p__1[0][l__2].clientData;
				}
				Preloading_PushEmoUrl(l__4.msPicAs3Url, l__3);
				l__2++;
			}
			mbHasLoadedAllEmoInfo = true;
			Preloading_Execute();
		}
		public function AddCategoryList(p__1:Array)
		{
			var l__3:* = undefined;
			var l__4:com.script.poker.table.EmoCategory;
			maCatOrder = new Array();
			var l__2 = 0;
			while(l__2 < (p__1.length)){
				l__3 = p__1[l__2].id;
				if (!maAllCats[l__3]){
					maAllCats[l__3] = new EmoCategory();
				}
				l__4 = (maAllCats[l__3] as EmoCategory);
				if (p__1[l__2].id){
					l__4.mnId = p__1[l__2].id;
				}
				l__4.msName = (p__1[l__2].name) ? (p__1[l__2].name) : "name unkown";
				
				maCatOrder.push(l__4.mnId);
				l__2++;
			}
		}
		public function AddEmoPriceList(p__1:String, p__2:*)
		{

			var l__5:* = undefined;
			var l__6:com.script.poker.table.EmoItem;
			if (msDefaultCategory == null){
				msDefaultCategory = p__1;
			}
			if (!maAllCats[p__1]){
				maAllCats[p__1] = new EmoCategory();
			}

			var l__3:com.script.poker.table.EmoCategory = maAllCats[p__1];
			l__3.maEmoInCat = new Array();
			var l__4 = 0;

			while(l__4 < (p__2.length)){
				l__5 = p__2[l__4].id;
				l__3.maEmoInCat.push(l__5);
				if (!maAllEmo[l__5]){
					maAllEmo[l__5] = new EmoItem();
				}
				l__6 = (maAllEmo[l__5] as EmoItem);
				if (p__2[l__4].id){
					l__6.mnId = p__2[l__4].id;
				}
				l__6.mnPrice = (p__2[l__4].price) ? (p__2[l__4].price) : 0;
				l__6.mbGreyOut = (p__2[l__4].greyOut) ? true : false;
				l__4++;
			}
		}
		public function ReleaseEmoMovieClip(p__1:flash.display.MovieClip)
		{
			if ((p__1) == null){
				return;
			}
			var l__2:com.script.poker.table.EmoItemInst = ((p__1) as EmoItemInst);
			if (l__2 == null){
				return;
			}
			if (l__2.moEmo){
				l__2.Sleep();
				l__2.moEmo.maCachedInst_Free.push(l__2);
			} else {
				l__2.Release();
			}
		}
		public function CreateEmoMovieClip(p__1:Number, p__2:String):flash.display.MovieClip
		{
			
			if (!maAllEmo[p__2]){
				return(null);
			}
			var l__3:com.script.poker.table.EmoItem = GetEmo(p__2);
			var l__4:*;

			switch(p__1){
				case knIMAGE_SIZE_40x40:
				{
					if (!(l__3.msPicAs3Url == null) && !(l__3.msPicAs3Url == "")){
						l__4 = l__3.msPicAs3Url;
					} else {
						l__4 = l__3.msPicSmallUrl;
					}
					break;
				}
				case knIMAGE_SIZE_60x60:
				{
					l__4 = l__3.msPicMediumUrl;
					break;
				}
				case knIMAGE_SIZE_100x100:
				{
					l__4 = l__3.msPicLargeUrl;
					break;
				}
				default:
				{
					break;
				}
			}
			if (l__4 == null){
				return(null);
			}
			var l__5:com.script.poker.table.EmoItemInst = GetImageFromCache(l__4, p__2);
			return(l__5 as MovieClip);
		}
		public function DEBUG_traceAll()
		{
		}
		function DEBUG_traceAllEmo()
		{
			var l__1:* = undefined;
			return;
		}
		function DEBUG_traceAllCats()
		{
			var l__1:* = undefined;
			return;
		}
		function DEBUG_traceEmo(p__1:*)
		{
		}
		public static function GetInst()
		{
			var l__1:com.script.poker.table.EmoLibrary;
			if (!mSingletonInst){
				l__1 = new EmoLibrary(new EmoLibrary_SingletonLockingClass());
			}
			return(mSingletonInst);
		}
		public static function GetImageFromCache(p__1:String, p__2:String):com.script.poker.table.EmoItemInst
		{
			var l__5:com.script.poker.table.EmoItemInst;
			var l__3:com.script.poker.table.EmoItem = EmoLibrary.GetInst().GetEmo(p__2);
			if (!l__3){
				return(null);
			}
			/*if (l__3.maCachedInst_Free.length > 0){
				l__5 = l__3.maCachedInst_Free.pop();
				l__5.Wake();
				return(l__5);
			}*/
			var l__4:com.script.poker.table.EmoItemInst = new EmoItemInst(p__1, l__3);
			return(l__4);
		}
	}
}

	import com.script.poker.table.*;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.ProgressEvent;
	import flash.events.EventDispatcher;
	import ws.tink.managers.*;
	import ws.tink.core.Library;
	import ws.tink.events.LibraryEvent;

class EmoLibrary_SingletonLockingClass
{
	function EmoLibrary_SingletonLockingClass()
	{
	}
}
