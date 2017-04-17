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
	public class GiftLibrary extends flash.display.MovieClip
	{
		private var mbSwfGiftAssetsLoaded:Boolean = false;
		private var maCatOrder:* = new Array();
		private var maAllGifts:* = new Array();
		private var msDefaultCategory:String = null;
		private var maPreloadImageGiftUrls:Array = new Array();
		private var mSwfManifest:ws.tink.core.Library = null;
		private var maAllCats:* = new Array();
		private var maPreloadAnimatedGiftUrls:Array = new Array();
		private static const knIMAGE_SIZE_60x60:* = 1;
		private static var mSingletonInst:com.script.poker.table.GiftLibrary = null;
		private static const knIMAGE_SIZE_40x40:* = 0;
		private static const knIMAGE_SIZE_100x100:* = 2;
		private static var mbHasLoadedAllGiftInfo:Boolean = false;
		public function GiftLibrary(p__1:GiftLibrary_SingletonLockingClass)
		{
			if (mSingletonInst || ((p__1) == null)){
				throw new Error("GiftLibrary class cannot be instantiated");
			}
			mSingletonInst = this;
		}
		private function Preloading_PushGiftUrl(p__1:String, p__2:String):void
		{
			var l__3:com.script.poker.table.GiftItem = GetGift(p__2);
			if (!l__3){
				return;
			}
			if (!(l__3.msPicAs3Url == null) && (l__3.msPicAs3Url.lastIndexOf(".swf") >= 0)){
				Preloading_PushAnimatedGiftUrl(l__3.msPicAs3Url, p__2);
			} else {
				Preloading_PushImageGiftUrl(l__3.msPicAs3Url, p__2);
			}
		}
		private function Preloading_PushAnimatedGiftUrl(p__1:String, p__2:String)
		{
			if (!((p__1) == null) && !((p__1) == "")){
				maPreloadAnimatedGiftUrls.push(p__1);
			}
		}
		private function Preloading_PushImageGiftUrl(p__1:String, p__2:String)
		{
			var l__3:com.script.poker.table.GiftItem = GetGift(p__2);
			if (!l__3){
				return;
			}
			if (!((p__1) == null) && !((p__1) == "")){
				l__3.msPreloadedPicUrl = p__1;
			}
		}
		private function Preloading_Execute()
		{
			LoadSwfManifest(maPreloadAnimatedGiftUrls);
			LoadNonSwfImages(maPreloadImageGiftUrls);
		}
		private function LoadNonSwfImages(p__1:Array):void
		{
			var l__2:* = 0;
			var l__3:com.script.poker.table.GiftItemInst;
			for (l__2 in maAllGifts){
				if (maAllGifts[l__2].msPreloadedPicUrl){
					l__3 = new GiftItemInst(maAllGifts[l__2].msPreloadedPicUrl, maAllGifts[l__2]);
					ReleaseGiftMovieClip(l__3);
				}
			}
		}
		private function LoadSwfManifest(p__1:Array):void
		{
			if (!((p__1) == null) && ((p__1.length) > 0)){
				mSwfManifest = LibraryManager.libraryManager.createLibrary("GiftManifest");
				mSwfManifest.addEventListener(LibraryEvent.LOAD_COMPLETE, OnGiftManifestLoaded);
				mSwfManifest.addEventListener(ProgressEvent.PROGRESS, OnGiftManifestProgress);
				mSwfManifest.addEventListener(LibraryEvent.FILE_COMPLETE, updateProgressIndicator);
				mSwfManifest.addEventListener(LibraryEvent.LOAD_ERROR, onLoadError);
				mSwfManifest.loadSWFS_sequential(p__1);
			}
		}
		private function OnGiftManifestLoaded(p__1:ws.tink.events.LibraryEvent):void
		{
			mbSwfGiftAssetsLoaded = true;
		}
		private function OnGiftManifestProgress(p__1:flash.events.ProgressEvent):void
		{
		}
		private function updateProgressIndicator(p__1:ws.tink.events.LibraryEvent):void
		{
		}
		private function onLoadError(p__1:ws.tink.events.LibraryEvent):void
		{
		}
		public function GetIsSwfGiftAssetsLoaded():Boolean
		{
			return(mbSwfGiftAssetsLoaded);
		}
		public function GetClassDefinition(p__1:com.script.poker.table.GiftItem):Class
		{
			if (mbSwfGiftAssetsLoaded){
				return(mSwfManifest.getDefinition(p__1.msClassDef) as Class);
			}
			return(null);
		}
		public function HasLoadedAllGiftInfo():Boolean
		{
			return(mbHasLoadedAllGiftInfo);
		}
		public function GetDefaultCategory():String
		{
			return(msDefaultCategory);
		}
		public function GetGift(p__1:String):com.script.poker.table.GiftItem
		{
			if (!maAllGifts[p__1]){
				return(null);
			}
			return(maAllGifts[p__1]);
		}
		public function GetAllCategories():Array
		{
			return(maAllCats);
		}
		public function GetGiftCategory(p__1:String):com.script.poker.table.GiftCategory
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
		public function GetGiftArrayForCategory(p__1:String):Array
		{
			var l__5:* = undefined;
			var l__2:Array = new Array();
			var l__3:com.script.poker.table.GiftCategory = maAllCats[p__1];
			if (l__3 == null){
				return(l__2);
			}
			var l__4 = 0;
			while(l__4 < l__3.maGiftsInCat.length){
				l__5 = l__3.maGiftsInCat[l__4];
				if (!maAllGifts[l__5]){
				} else {
					l__2.push(maAllGifts[l__5]);
				}
				l__4++;
			}
			return(l__2);
		}
		public function AddGiftInfoList(p__1:*)
		{
			var l__3:* = undefined;
			var l__4:com.script.poker.table.GiftItem;
			var l__2 = 0;
			while(l__2 < (p__1.length)){
				l__3 = p__1[l__2].id;
				if (!maAllGifts[l__3]){
					maAllGifts[l__3] = new GiftItem();
				}
				l__4 = (maAllGifts[l__3] as GiftItem);
				if (p__1[l__2].id){
					l__4.mnId = p__1[l__2].id;
				}
				l__4.mbUserFilter = (p__1[l__2].userFilter) ? true : false;
				
				if (p__1[l__2].picLargeUrl){
					l__4.msPicLargeUrl = p__1[l__2].picLargeUrl;
				}
				if (p__1[l__2].picMediumUrl){
					l__4.msPicMediumUrl = p__1[l__2].picMediumUrl;
				}
				if (p__1[l__2].picSmallUrl){
					l__4.msPicSmallUrl = p__1[l__2].picSmallUrl;
				}
				if (p__1[l__2].picAs3Url){
					l__4.msPicAs3Url = p__1[l__2].picAs3Url;
				}
				if (p__1[l__2].as3Classname){
					l__4.msClassDef = p__1[l__2].as3Classname;
				}
				if (p__1[l__2].name){
					l__4.msName = p__1[l__2].name;
				}
				if (p__1[l__2].actionText){
					l__4.msActionText = p__1[l__2].actionText;
				}
				if (p__1[l__2].clientData){
					l__4.msClientData = p__1[l__2].clientData;
				}
				Preloading_PushGiftUrl(l__4.msPicAs3Url, l__3);
				l__2++;
			}
			mbHasLoadedAllGiftInfo = true;
			Preloading_Execute();
		}
		public function AddCategoryList(p__1:Array)
		{
			var l__3:* = undefined;
			var l__4:com.script.poker.table.GiftCategory;
			maCatOrder = new Array();
			var l__2 = 0;
			
			while(l__2 < (p__1.length)){
				l__3 = p__1[l__2].id;
				if (!maAllCats[l__3]){
					maAllCats[l__3] = new GiftCategory();
				}
				l__4 = (maAllCats[l__3] as GiftCategory);
				if (p__1[l__2].id){
					l__4.mnId = p__1[l__2].id;
				}
				l__4.msName = (p__1[l__2].name) ? (p__1[l__2].name) : "name unkown";
				
				maCatOrder.push(l__4.mnId);
				
				l__2++;
			}
		}
		public function AddGiftPriceList(p__1:String, p__2:*)
		{
			var l__5:* = undefined;
			var l__6:com.script.poker.table.GiftItem;
			if (msDefaultCategory == null){
				msDefaultCategory = p__1;
			}
			if (!maAllCats[p__1]){
				maAllCats[p__1] = new GiftCategory();
			}
			var l__3:com.script.poker.table.GiftCategory = maAllCats[p__1];
			l__3.maGiftsInCat = new Array();
			var l__4 = 0;
			while(l__4 < (p__2.length)){
				l__5 = p__2[l__4].id;
				l__3.maGiftsInCat.push(l__5);
				if (!maAllGifts[l__5]){
					maAllGifts[l__5] = new GiftItem();
				}
				l__6 = (maAllGifts[l__5] as GiftItem);
				if (p__2[l__4].id){
					l__6.mnId = p__2[l__4].id;
				}
				l__6.mnPrice = (p__2[l__4].price) ? (p__2[l__4].price) : 0;
				l__6.mbGreyOut = (p__2[l__4].greyOut) ? true : false;
				l__4++;
			}
		}
		public function ReleaseGiftMovieClip(p__1:flash.display.MovieClip)
		{
			if ((p__1) == null){
				return;
			}
			var l__2:com.script.poker.table.GiftItemInst = ((p__1) as GiftItemInst);
			if (l__2 == null){
				return;
			}
			if (l__2.moGift){
				l__2.Sleep();
				l__2.moGift.maCachedInst_Free.push(l__2);
			} else {
				l__2.Release();
			}
		}
		public function CreateGiftMovieClip(p__1:Number, p__2:String):flash.display.MovieClip
		{
			if (!maAllGifts[p__2]){
				return(null);
			}
			var l__3:com.script.poker.table.GiftItem = GetGift(p__2);
			var l__4 = 0;
			
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
			var l__5:com.script.poker.table.GiftItemInst = GetImageFromCache(l__4, p__2);
			return(l__5 as MovieClip);
		}
		public function DEBUG_traceAll()
		{
		}
		function DEBUG_traceAllGifts()
		{
			var l__1:* = undefined;
			return;
		}
		function DEBUG_traceAllCats()
		{
			var l__1:* = undefined;
			return;
		}
		function DEBUG_traceGift(p__1:*)
		{
		}
		public static function GetInst()
		{
			var l__1:com.script.poker.table.GiftLibrary;
			if (!mSingletonInst){
				l__1 = new GiftLibrary(new GiftLibrary_SingletonLockingClass());
			}
			return(mSingletonInst);
		}
		public static function GetImageFromCache(p__1:String, p__2:String):com.script.poker.table.GiftItemInst
		{
			var l__5:com.script.poker.table.GiftItemInst;
			var l__3:com.script.poker.table.GiftItem = GiftLibrary.GetInst().GetGift(p__2);
			if (!l__3){
				return(null);
			}
			if (l__3.maCachedInst_Free.length > 0){
				l__5 = l__3.maCachedInst_Free.pop();
				l__5.Wake();
				return(l__5);
			}
			var l__4:com.script.poker.table.GiftItemInst = new GiftItemInst(p__1, l__3);
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

class GiftLibrary_SingletonLockingClass
{
	function GiftLibrary_SingletonLockingClass()
	{
	}
}
