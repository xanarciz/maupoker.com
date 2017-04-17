// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package caurina.transitions
{
	import flash.filters.BitmapFilter;
	public class TweenListObj
	{
		public var hasStarted:Boolean;
		public var onUpdate:Function;
		public var useFrames:Boolean;
		public var count:Number;
		public var onOverwriteParams:Array;
		public var timeStart:Number;
		public var timeComplete:Number;
		public var onStartParams:Array;
		public var onUpdateScope:Object;
		public var rounded:Boolean;
		public var onUpdateParams:Array;
		public var properties:Object;
		public var onComplete:Function;
		public var transitionParams:Object;
		public var updatesSkipped:Number;
		public var onStart:Function;
		public var onOverwriteScope:Object;
		public var skipUpdates:Number;
		public var onStartScope:Object;
		public var scope:Object;
		public var isCaller:Boolean;
		public var timePaused:Number;
		public var transition:Function;
		public var onCompleteParams:Array;
		public var onError:Function;
		public var timesCalled:Number;
		public var onErrorScope:Object;
		public var onOverwrite:Function;
		public var isPaused:Boolean;
		public var waitFrames:Boolean;
		public var onCompleteScope:Object;
		public function TweenListObj(p__1:Object, p__2:Number, p__3:Number, p__4:Boolean, p__5:Function, p__6:Object)
		{
			scope = p__1;
			timeStart = p__2;
			timeComplete = p__3;
			useFrames = p__4;
			transition = p__5;
			transitionParams = p__6;
			properties = new Object();
			isPaused = false;
			timePaused = undefined;
			isCaller = false;
			updatesSkipped = 0;
			timesCalled = 0;
			skipUpdates = 0;
			hasStarted = false;
		}
		public function clone(p__1:Boolean):caurina.transitions.TweenListObj
		{
			var l__3:String;
			var l__2:caurina.transitions.TweenListObj = new TweenListObj(scope, timeStart, timeComplete, useFrames, transition, transitionParams);
			l__2.properties = new Array();
			for (l__3 in properties){
				l__2.properties[l__3] = properties[l__3].clone();
			}
			l__2.skipUpdates = skipUpdates;
			l__2.updatesSkipped = updatesSkipped;
			if (!(p__1)){
				l__2.onStart = onStart;
				l__2.onUpdate = onUpdate;
				l__2.onComplete = onComplete;
				l__2.onOverwrite = onOverwrite;
				l__2.onError = onError;
				l__2.onStartParams = onStartParams;
				l__2.onUpdateParams = onUpdateParams;
				l__2.onCompleteParams = onCompleteParams;
				l__2.onOverwriteParams = onOverwriteParams;
				l__2.onStartScope = onStartScope;
				l__2.onUpdateScope = onUpdateScope;
				l__2.onCompleteScope = onCompleteScope;
				l__2.onOverwriteScope = onOverwriteScope;
				l__2.onErrorScope = onErrorScope;
			}
			l__2.rounded = rounded;
			l__2.isPaused = isPaused;
			l__2.timePaused = timePaused;
			l__2.isCaller = isCaller;
			l__2.count = count;
			l__2.timesCalled = timesCalled;
			l__2.waitFrames = waitFrames;
			l__2.hasStarted = hasStarted;
			return(l__2);
		}
		public function toString():String
		{
			var l__3:String;
			var l__1:* = "\n[TweenListObj ";
			l__1 = (l__1 + ("scope:" + String(scope)));
			l__1 = (l__1 + ", properties:");
			var l__2:* = true;
			for (l__3 in properties){
				if (!l__2){
					l__1 = (l__1 + ",");
				}
				l__1 = (l__1 + ("[name:" + properties[l__3].name));
				l__1 = (l__1 + (",valueStart:" + properties[l__3].valueStart));
				l__1 = (l__1 + (",valueComplete:" + properties[l__3].valueComplete));
				l__1 = (l__1 + "]");
				l__2 = false;
			}
			l__1 = (l__1 + (", timeStart:" + String(timeStart)));
			l__1 = (l__1 + (", timeComplete:" + String(timeComplete)));
			l__1 = (l__1 + (", useFrames:" + String(useFrames)));
			l__1 = (l__1 + (", transition:" + String(transition)));
			l__1 = (l__1 + (", transitionParams:" + String(transitionParams)));
			if (skipUpdates){
				l__1 = (l__1 + (", skipUpdates:" + String(skipUpdates)));
			}
			if (updatesSkipped){
				l__1 = (l__1 + (", updatesSkipped:" + String(updatesSkipped)));
			}
			if (Boolean(onStart)){
				l__1 = (l__1 + (", onStart:" + String(onStart)));
			}
			if (Boolean(onUpdate)){
				l__1 = (l__1 + (", onUpdate:" + String(onUpdate)));
			}
			if (Boolean(onComplete)){
				l__1 = (l__1 + (", onComplete:" + String(onComplete)));
			}
			if (Boolean(onOverwrite)){
				l__1 = (l__1 + (", onOverwrite:" + String(onOverwrite)));
			}
			if (Boolean(onError)){
				l__1 = (l__1 + (", onError:" + String(onError)));
			}
			if (onStartParams){
				l__1 = (l__1 + (", onStartParams:" + String(onStartParams)));
			}
			if (onUpdateParams){
				l__1 = (l__1 + (", onUpdateParams:" + String(onUpdateParams)));
			}
			if (onCompleteParams){
				l__1 = (l__1 + (", onCompleteParams:" + String(onCompleteParams)));
			}
			if (onOverwriteParams){
				l__1 = (l__1 + (", onOverwriteParams:" + String(onOverwriteParams)));
			}
			if (onStartScope){
				l__1 = (l__1 + (", onStartScope:" + String(onStartScope)));
			}
			if (onUpdateScope){
				l__1 = (l__1 + (", onUpdateScope:" + String(onUpdateScope)));
			}
			if (onCompleteScope){
				l__1 = (l__1 + (", onCompleteScope:" + String(onCompleteScope)));
			}
			if (onOverwriteScope){
				l__1 = (l__1 + (", onOverwriteScope:" + String(onOverwriteScope)));
			}
			if (onErrorScope){
				l__1 = (l__1 + (", onErrorScope:" + String(onErrorScope)));
			}
			if (rounded){
				l__1 = (l__1 + (", rounded:" + String(rounded)));
			}
			if (isPaused){
				l__1 = (l__1 + (", isPaused:" + String(isPaused)));
			}
			if (timePaused){
				l__1 = (l__1 + (", timePaused:" + String(timePaused)));
			}
			if (isCaller){
				l__1 = (l__1 + (", isCaller:" + String(isCaller)));
			}
			if (count){
				l__1 = (l__1 + (", count:" + String(count)));
			}
			if (timesCalled){
				l__1 = (l__1 + (", timesCalled:" + String(timesCalled)));
			}
			if (waitFrames){
				l__1 = (l__1 + (", waitFrames:" + String(waitFrames)));
			}
			if (hasStarted){
				l__1 = (l__1 + (", hasStarted:" + String(hasStarted)));
			}
			l__1 = (l__1 + "]\n");
			return(l__1);
		}
		public static function makePropertiesChain(p__1:Object):Object
		{
			var l__3:Object;
			var l__4:Object;
			var l__5:Object;
			var l__6:Number;
			var l__7:Number;
			var l__8:Number;
			var l__2:Object = p__1.base;
			if (l__2){
				l__3 = {};
				if (l__2 is Array){
					l__4 = [];
					l__8 = 0;
					while(l__8 < l__2.length){
						l__4.push(l__2[l__8]);
						l__8++;
					}
				} else {
					l__4 = [l__2];
				}
				l__4.push(p__1);
				l__6 = l__4.length;
				l__7 = 0;
				while(l__7 < l__6){
					if (l__4[l__7]["base"]){
						l__5 = AuxFunctions.concatObjects(makePropertiesChain(l__4[l__7]["base"]), l__4[l__7]);
					} else {
						l__5 = l__4[l__7];
					}
					l__3 = AuxFunctions.concatObjects(l__3, l__5);
					l__7++;
				}
				if (l__3["base"]){
					delete l__3["base"];
				}
				return(l__3);
			} else {
				return(p__1);
			}
		}
	}
}