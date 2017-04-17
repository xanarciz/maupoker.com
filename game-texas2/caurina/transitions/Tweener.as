// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package caurina.transitions
{
	import flash.display.*;
	import flash.events.Event;
	import com.script.poker.table.asset.PlayerRollover;
	import flash.utils.*;
	public class Tweener
	{
		private static var _timeScale:Number = 1;
		private static var _currentTimeFrame:Number;
		private static var _specialPropertySplitterList:Object;
		private static var _engineExists:Boolean = false;
		private static var _specialPropertyModifierList:Object;
		private static var _currentTime:Number;
		private static var _tweenList:Array;
		private static var _specialPropertyList:Object;
		private static var _transitionList:Object;
		private static var _inited:Boolean = false;
		private static var __tweener_controller__:flash.display.MovieClip;
		public function Tweener()
		{
		}
		public static function addTween(p__1:Object = null, p__2:Object = null):Boolean
		{
			var l__3:Number;
			var l__4:Number;
			var l__5:String;
			var l__6:Array;
			var l__13:Function;
			var l__14:Object;
			var l__15:caurina.transitions.TweenListObj;
			var l__16:Number;
			var l__17:Array;
			var l__18:Array;
			var l__19:Array;
			var l__20:String;
			if (!Boolean(p__1)){
				return(false);
			}
			if ((p__1) is Array){
				l__6 = (p__1).concat();
			} else {
				l__6 = [p__1];
			}
			var l__7:Object = TweenListObj.makePropertiesChain(p__2);
			if (!_inited){
				init();
			}
			if ((!_engineExists) || (!Boolean(__tweener_controller__))){
				startEngine();
			}
			var l__8:Number = isNaN(l__7.time) ? 0 : l__7.time;
			var l__9:Number = isNaN(l__7.delay) ? 0 : l__7.delay;
			var l__10:Array = new Array();
			var l__11:Object = {time:true, delay:true, useFrames:true, skipUpdates:true, transition:true, transitionParams:true, onStart:true, onUpdate:true, onComplete:true, onOverwrite:true, onError:true, rounded:true, onStartParams:true, onUpdateParams:true, onCompleteParams:true, onOverwriteParams:true, onStartScope:true, onUpdateScope:true, onCompleteScope:true, onOverwriteScope:true, onErrorScope:true};
			var l__12:Object = new Object();
			for (l__5 in l__7){
				if (!l__11[l__5]){
					if (_specialPropertySplitterList[l__5]){
						l__17 = _specialPropertySplitterList[l__5].splitValues(l__7[l__5], _specialPropertySplitterList[l__5].parameters);
						l__3 = 0;
						while(l__3 < l__17.length){
							if (_specialPropertySplitterList[l__17[l__3].name]){
								l__18 = _specialPropertySplitterList[l__17[l__3].name].splitValues(l__17[l__3].value, _specialPropertySplitterList[l__17[l__3].name].parameters);
								l__4 = 0;
								while(l__4 < l__18.length){
									l__10[l__18[l__4].name] = {valueStart:undefined, valueComplete:l__18[l__4].value, arrayIndex:l__18[l__4].arrayIndex, isSpecialProperty:false};
									l__4++;
								}
							} else {
								l__10[l__17[l__3].name] = {valueStart:undefined, valueComplete:l__17[l__3].value, arrayIndex:l__17[l__3].arrayIndex, isSpecialProperty:false};
							}
							l__3++;
						}
					} else if (_specialPropertyModifierList[l__5] != undefined){
						l__19 = _specialPropertyModifierList[l__5].modifyValues(l__7[l__5]);
						l__3 = 0;
						while(l__3 < l__19.length){
							l__12[l__19[l__3].name] = {modifierParameters:l__19[l__3].parameters, modifierFunction:_specialPropertyModifierList[l__5].getValue};
							l__3++;
						}
					} else {
						l__10[l__5] = {valueStart:undefined, valueComplete:l__7[l__5]};
					}
				}
			}
			for (l__5 in l__10){
				if (_specialPropertyList[l__5] != undefined){
					l__10[l__5].isSpecialProperty = true;
				} else if (l__6[0][l__5] == undefined){
					printError(((("The property \'" + l__5) + "\' doesn\'t seem to be a normal object property of ") + String(l__6[0])) + " or a registered special property.");
				}
			}
			for (l__5 in l__12){
				if (l__10[l__5] != undefined){
					l__10[l__5].modifierParameters = l__12[l__5].modifierParameters;
					l__10[l__5].modifierFunction = l__12[l__5].modifierFunction;
				}
			}
			if ((typeof l__7.transition) == "string"){
				l__20 = l__7.transition.toLowerCase();
				l__13 = _transitionList[l__20];
			} else {
				l__13 = l__7.transition;
			}
			if (!Boolean(l__13)){
				l__13 = _transitionList["easeoutexpo"];
			}
			l__3 = 0;
			while(l__3 < l__6.length){
				l__14 = new Object();
				for (l__5 in l__10){
					l__14[l__5] = new PropertyInfoObj(l__10[l__5].valueStart, l__10[l__5].valueComplete, l__10[l__5].valueComplete, l__10[l__5].arrayIndex, {}, l__10[l__5].isSpecialProperty, l__10[l__5].modifierFunction, l__10[l__5].modifierParameters);
				}
				if (l__7.useFrames == true){
					l__15 = new TweenListObj(l__6[l__3], (_currentTimeFrame + (l__9 / _timeScale)), (_currentTimeFrame + ((l__9 + l__8) / _timeScale)), true, l__13, l__7.transitionParams);
				} else {
					l__15 = new TweenListObj(l__6[l__3], (_currentTime + ((l__9 * 1000) / _timeScale)), (_currentTime + ((l__9 * 1000 + (l__8 * 1000)) / _timeScale)), false, l__13, l__7.transitionParams);
				}
				l__15.properties = l__14;
				l__15.onStart = l__7.onStart;
				l__15.onUpdate = l__7.onUpdate;
				l__15.onComplete = l__7.onComplete;
				l__15.onOverwrite = l__7.onOverwrite;
				l__15.onError = l__7.onError;
				l__15.onStartParams = l__7.onStartParams;
				l__15.onUpdateParams = l__7.onUpdateParams;
				l__15.onCompleteParams = l__7.onCompleteParams;
				l__15.onOverwriteParams = l__7.onOverwriteParams;
				l__15.onStartScope = l__7.onStartScope;
				l__15.onUpdateScope = l__7.onUpdateScope;
				l__15.onCompleteScope = l__7.onCompleteScope;
				l__15.onOverwriteScope = l__7.onOverwriteScope;
				l__15.onErrorScope = l__7.onErrorScope;
				l__15.rounded = l__7.rounded;
				l__15.skipUpdates = l__7.skipUpdates;
				removeTweensByTime(l__15.scope, l__15.properties, l__15.timeStart, l__15.timeComplete);
				_tweenList.push(l__15);
				if ((l__8 == 0) && (l__9 == 0)){
					l__16 = _tweenList.length - 1;
					updateTweenByIndex(l__16);
					removeTweenByIndex(l__16);
				}
				l__3++;
			}
			return(true);
		}
		public static function addCaller(p__1:Object = null, p__2:Object = null):Boolean
		{
			var l__3:Number;
			var l__4:Array;
			var l__8:Function;
			var l__9:caurina.transitions.TweenListObj;
			var l__10:Number;
			var l__11:String;
			if (!Boolean(p__1)){
				return(false);
			}
			if ((p__1) is Array){
				l__4 = (p__1).concat();
			} else {
				l__4 = [p__1];
			}
			var l__5:Object = p__2;
			if (!_inited){
				init();
			}
			if ((!_engineExists) || (!Boolean(__tweener_controller__))){
				startEngine();
			}
			var l__6:Number = isNaN(l__5.time) ? 0 : l__5.time;
			var l__7:Number = isNaN(l__5.delay) ? 0 : l__5.delay;
			if ((typeof l__5.transition) == "string"){
				l__11 = l__5.transition.toLowerCase();
				l__8 = _transitionList[l__11];
			} else {
				l__8 = l__5.transition;
			}
			if (!Boolean(l__8)){
				l__8 = _transitionList["easeoutexpo"];
			}
			l__3 = 0;
			while(l__3 < l__4.length){
				if (l__5.useFrames == true){
					l__9 = new TweenListObj(l__4[l__3], (_currentTimeFrame + (l__7 / _timeScale)), (_currentTimeFrame + ((l__7 + l__6) / _timeScale)), true, l__8, l__5.transitionParams);
				} else {
					l__9 = new TweenListObj(l__4[l__3], (_currentTime + ((l__7 * 1000) / _timeScale)), (_currentTime + ((l__7 * 1000 + (l__6 * 1000)) / _timeScale)), false, l__8, l__5.transitionParams);
				}
				l__9.properties = null;
				l__9.onStart = l__5.onStart;
				l__9.onUpdate = l__5.onUpdate;
				l__9.onComplete = l__5.onComplete;
				l__9.onOverwrite = l__5.onOverwrite;
				l__9.onStartParams = l__5.onStartParams;
				l__9.onUpdateParams = l__5.onUpdateParams;
				l__9.onCompleteParams = l__5.onCompleteParams;
				l__9.onOverwriteParams = l__5.onOverwriteParams;
				l__9.onStartScope = l__5.onStartScope;
				l__9.onUpdateScope = l__5.onUpdateScope;
				l__9.onCompleteScope = l__5.onCompleteScope;
				l__9.onOverwriteScope = l__5.onOverwriteScope;
				l__9.onErrorScope = l__5.onErrorScope;
				l__9.isCaller = true;
				l__9.count = l__5.count;
				l__9.waitFrames = l__5.waitFrames;
				_tweenList.push(l__9);
				if ((l__6 == 0) && (l__7 == 0)){
					l__10 = _tweenList.length - 1;
					updateTweenByIndex(l__10);
					removeTweenByIndex(l__10);
				}
				l__3++;
			}
			return(true);
		}
		public static function removeTweensByTime(p_scope:Object, p_properties:Object, p_timeStart:Number, p_timeComplete:Number):Boolean
		{
			var removedLocally:Boolean;
			var i:uint;
			var pName:String;
			var eventScope:Object;
			var removed:Boolean;
			var tl:uint = _tweenList.length;
			i = 0;
			while(i < tl){
				if (Boolean(_tweenList[i]) && (p_scope == _tweenList[i].scope)){
					if ((p_timeComplete > _tweenList[i].timeStart) && (p_timeStart < _tweenList[i].timeComplete)){
						removedLocally = false;
						for (pName in _tweenList[i].properties){
							if (Boolean(p_properties[pName])){
								if (Boolean(_tweenList[i].onOverwrite)){
									eventScope = Boolean(_tweenList[i].onOverwriteScope) ? _tweenList[i].onOverwriteScope : _tweenList[i].scope;
									try {
										_tweenList[i].onOverwrite.apply(eventScope, _tweenList[i].onOverwriteParams);
									} catch (e:Error) {
										handleError(_tweenList[i], e, "onOverwrite");
									}
								}
								_tweenList[i].properties[pName] = undefined;
								delete _tweenList[i].properties[pName];
								removedLocally = true;
								removed = true;
							}
						}
						if (removedLocally){
							if (AuxFunctions.getObjectLength(_tweenList[i].properties) == 0){
								removeTweenByIndex(i);
							}
						}
					}
				}
				i++;
			}
			return(removed);
		}
		public static function removeTweens(p__1:Object, ... p__2):Boolean
		{
			var l__4:uint;
			var l__3:Array = new Array();
			l__4 = 0;
			while(l__4 < (p__2.length)){
				if ((typeof (p__2[l__4]) == "string") && (!AuxFunctions.isInArray(p__2[l__4], l__3))){
					l__3.push(p__2[l__4]);
				}
				l__4++;
			}
			return(affectTweens(removeTweenByIndex, p__1, l__3));
		}
		public static function removeAllTweens():Boolean
		{
			var l__2:uint;
			if (!Boolean(_tweenList)){
				return(false);
			}
			var l__1:Boolean;
			l__2 = 0;
			while(l__2 < _tweenList.length){
				removeTweenByIndex(l__2);
				l__1 = true;
				l__2++;
			}
			return(l__1);
		}
		public static function pauseTweens(p__1:Object, ... p__2):Boolean
		{
			var l__4:uint;
			var l__3:Array = new Array();
			l__4 = 0;
			while(l__4 < (p__2.length)){
				if ((typeof (p__2[l__4]) == "string") && (!AuxFunctions.isInArray(p__2[l__4], l__3))){
					l__3.push(p__2[l__4]);
				}
				l__4++;
			}
			return(affectTweens(pauseTweenByIndex, p__1, l__3));
		}
		public static function pauseAllTweens():Boolean
		{
			var l__2:uint;
			if (!Boolean(_tweenList)){
				return(false);
			}
			var l__1:Boolean;
			l__2 = 0;
			while(l__2 < _tweenList.length){
				pauseTweenByIndex(l__2);
				l__1 = true;
				l__2++;
			}
			return(l__1);
		}
		public static function resumeTweens(p__1:Object, ... p__2):Boolean
		{
			var l__4:uint;
			var l__3:Array = new Array();
			l__4 = 0;
			while(l__4 < (p__2.length)){
				if ((typeof (p__2[l__4]) == "string") && (!AuxFunctions.isInArray(p__2[l__4], l__3))){
					l__3.push(p__2[l__4]);
				}
				l__4++;
			}
			return(affectTweens(resumeTweenByIndex, p__1, l__3));
		}
		public static function resumeAllTweens():Boolean
		{
			var l__2:uint;
			if (!Boolean(_tweenList)){
				return(false);
			}
			var l__1:Boolean;
			l__2 = 0;
			while(l__2 < _tweenList.length){
				resumeTweenByIndex(l__2);
				l__1 = true;
				l__2++;
			}
			return(l__1);
		}
		private static function affectTweens(p__1:Function, p__2:Object, p__3:Array):Boolean
		{
			var l__5:uint;
			var l__6:Array;
			var l__7:uint;
			var l__8:uint;
			var l__9:uint;
			var l__4:Boolean;
			if (!Boolean(_tweenList)){
				return(false);
			}
			l__5 = 0;
			while(l__5 < _tweenList.length){
				if (_tweenList[l__5] && (_tweenList[l__5].scope == (p__2))){
					if ((p__3.length) == 0){
						p__1(l__5);
						l__4 = true;
					} else {
						l__6 = new Array();
						l__7 = 0;
						while(l__7 < (p__3.length)){
							if (Boolean(_tweenList[l__5].properties[p__3[l__7]])){
								l__6.push(p__3[l__7]);
							}
							l__7++;
						}
						if (l__6.length > 0){
							l__8 = AuxFunctions.getObjectLength(_tweenList[l__5].properties);
							if (l__8 == l__6.length){
								p__1(l__5);
								l__4 = true;
							} else {
								l__9 = splitTweens(l__5, l__6);
								p__1(l__9);
								l__4 = true;
							}
						}
					}
				}
				l__5++;
			}
			return(l__4);
		}
		public static function splitTweens(p__1:Number, p__2:Array):uint
		{
			var l__5:uint;
			var l__6:String;
			var l__7:Boolean;
			var l__3:caurina.transitions.TweenListObj = _tweenList[p__1];
			var l__4:caurina.transitions.TweenListObj = l__3.clone(false);
			l__5 = 0;
			while(l__5 < (p__2.length)){
				l__6 = p__2[l__5];
				if (Boolean(l__3.properties[l__6])){
					l__3.properties[l__6] = undefined;
					delete l__3.properties[l__6];
				}
				l__5++;
			}
			for (l__6 in l__4.properties){
				l__7 = false;
				l__5 = 0;
				while(l__5 < (p__2.length)){
					if ((p__2[l__5]) == l__6){
						l__7 = true;
						break;
					}
					l__5++;
				}
				if (!l__7){
					l__4.properties[l__6] = undefined;
					delete l__4.properties[l__6];
				}
			}
			_tweenList.push(l__4);
			return(_tweenList.length - 1);
		}
		private static function updateTweens():Boolean
		{
			var l__1:int;
			if (_tweenList.length == 0){
				return(false);
			}
			l__1 = 0;
			while(l__1 < _tweenList.length){
				if ((_tweenList[l__1] == undefined) || (!_tweenList[l__1].isPaused)){
					if (!updateTweenByIndex(l__1)){
						removeTweenByIndex(l__1);
					}
					if (_tweenList[l__1] == null){
						removeTweenByIndex(l__1, true);
						l__1--;
					}
				}
				l__1++;
			}
			return(true);
		}
		public static function removeTweenByIndex(p__1:Number, p__2:Boolean = false):Boolean
		{
			_tweenList[p__1] = null;
			if (p__2){
				_tweenList.splice(p__1, 1);
			}
			return(true);
		}
		public static function pauseTweenByIndex(p__1:Number):Boolean
		{
			var l__2:caurina.transitions.TweenListObj = _tweenList[p__1];
			if ((l__2 == null) || l__2.isPaused){
				return(false);
			}
			l__2.timePaused = getCurrentTweeningTime(l__2);
			l__2.isPaused = true;
			return(true);
		}
		public static function resumeTweenByIndex(p__1:Number):Boolean
		{
			var l__2:caurina.transitions.TweenListObj = _tweenList[p__1];
			if ((l__2 == null) || (!l__2.isPaused)){
				return(false);
			}
			var l__3:Number = getCurrentTweeningTime(l__2);
			l__2.timeStart = (l__2.timeStart + (l__3 - l__2.timePaused));
			l__2.timeComplete = (l__2.timeComplete + (l__3 - l__2.timePaused));
			l__2.timePaused = undefined;
			l__2.isPaused = false;
			return(true);
		}
		private static function updateTweenByIndex(i:Number):Boolean
		{
			var tTweening:caurina.transitions.TweenListObj;
			var mustUpdate:Boolean;
			var nv:Number;
			var t:Number;
			var b:Number;
			var c:Number;
			var d:Number;
			var pName:String;
			var eventScope:Object;
			var tScope:Object;
			var tProperty:Object;
			var pv:Number;
			tTweening = _tweenList[i];
			if ((tTweening == null) || (!Boolean(tTweening.scope))){
				return(false);
			}
			var isOver:Boolean;
			var cTime:Number = getCurrentTweeningTime(tTweening);
			if (cTime >= tTweening.timeStart){
				tScope = tTweening.scope;
				if (tTweening.isCaller){
					do {
						t = ((tTweening.timeComplete - tTweening.timeStart) / tTweening.count) * (tTweening.timesCalled + 1);
						b = tTweening.timeStart;
						c = (tTweening.timeComplete - tTweening.timeStart);
						d = (tTweening.timeComplete - tTweening.timeStart);
						nv = tTweening.transition(t, b, c, d);
						if (cTime >= nv){
							if (Boolean(tTweening.onUpdate)){
								eventScope = Boolean(tTweening.onUpdateScope) ? tTweening.onUpdateScope : tScope;
								try {
									tTweening.onUpdate.apply(eventScope, tTweening.onUpdateParams);
								} catch (e:Error) {
									handleError(tTweening, e, "onUpdate");
								}
							}
							tTweening.timesCalled++;
							if (tTweening.timesCalled >= tTweening.count){
								isOver = true;
								break;
							}
							if (tTweening.waitFrames){
								break;
							}
						}
					} while (cTime >= nv)
				} else {
					mustUpdate = ((tTweening.skipUpdates < 1) || (!tTweening.skipUpdates)) || (tTweening.updatesSkipped >= tTweening.skipUpdates);
					if (cTime >= tTweening.timeComplete){
						isOver = true;
						mustUpdate = true;
					}
					if (!tTweening.hasStarted){
						if (Boolean(tTweening.onStart)){
							eventScope = Boolean(tTweening.onStartScope) ? tTweening.onStartScope : tScope;
							try {
								tTweening.onStart.apply(eventScope, tTweening.onStartParams);
							} catch (e:Error) {
								handleError(tTweening, e, "onStart");
							}
						}
						for (pName in tTweening.properties){
							if (tTweening.properties[pName].isSpecialProperty){
								if (Boolean(_specialPropertyList[pName].preProcess)){
									tTweening.properties[pName].valueComplete = _specialPropertyList[pName].preProcess(tScope, _specialPropertyList[pName].parameters, tTweening.properties[pName].originalValueComplete, tTweening.properties[pName].extra);
								}
								pv = _specialPropertyList[pName].getValue(tScope, _specialPropertyList[pName].parameters, tTweening.properties[pName].extra);
							} else {
								pv = tScope[pName];
							}
							tTweening.properties[pName].valueStart = isNaN(pv) ? tTweening.properties[pName].valueComplete : pv;
						}
						mustUpdate = true;
						tTweening.hasStarted = true;
					}
					if (mustUpdate){
						for (pName in tTweening.properties){
							tProperty = tTweening.properties[pName];
							if (isOver){
								nv = tProperty.valueComplete;
							} else if (tProperty.hasModifier){
								t = (cTime - tTweening.timeStart);
								d = (tTweening.timeComplete - tTweening.timeStart);
								nv = tTweening.transition(t, 0, 1, d, tTweening.transitionParams);
								nv = tProperty.modifierFunction(tProperty.valueStart, tProperty.valueComplete, nv, tProperty.modifierParameters);
							} else {
								t = (cTime - tTweening.timeStart);
								b = tProperty.valueStart;
								c = (tProperty.valueComplete - tProperty.valueStart);
								d = (tTweening.timeComplete - tTweening.timeStart);
								nv = tTweening.transition(t, b, c, d, tTweening.transitionParams);
							}
							if (tTweening.rounded){
								nv = Math.round(nv);
							}
							if (tProperty.isSpecialProperty){
								_specialPropertyList[pName].setValue(tScope, nv, _specialPropertyList[pName].parameters, tTweening.properties[pName].extra);
							} else {
								tScope[pName] = nv;
							}
						}
						tTweening.updatesSkipped = 0;
						if (Boolean(tTweening.onUpdate)){
							eventScope = Boolean(tTweening.onUpdateScope) ? tTweening.onUpdateScope : tScope;
							try {
								tTweening.onUpdate.apply(eventScope, tTweening.onUpdateParams);
							} catch (e:Error) {
								handleError(tTweening, e, "onUpdate");
							}
						}
					} else {
						tTweening.updatesSkipped++;
					}
				}
				if (isOver && Boolean(tTweening.onComplete)){
					eventScope = Boolean(tTweening.onCompleteScope) ? tTweening.onCompleteScope : tScope;
					try {
						tTweening.onComplete.apply(eventScope, tTweening.onCompleteParams);
					} catch (e:Error) {
						handleError(tTweening, e, "onComplete");
					}
				}
				return(!isOver);
			}
			return(true);
		}
		public static function init(... p__1):void
		{
			_inited = true;
			_transitionList = new Object();
			Equations.init();
			_specialPropertyList = new Object();
			_specialPropertyModifierList = new Object();
			_specialPropertySplitterList = new Object();
		}
		public static function registerTransition(p__1:String, p__2:Function):void
		{
			if (!_inited){
				init();
			}
			_transitionList[p__1] = p__2;
		}
		public static function registerSpecialProperty(p__1:String, p__2:Function, p__3:Function, p__4:Array = null, p__5:Function = null):void
		{
			if (!_inited){
				init();
			}
			var l__6:caurina.transitions.SpecialProperty = new SpecialProperty(p__2, p__3, p__4, p__5);
			_specialPropertyList[p__1] = l__6;
		}
		public static function registerSpecialPropertyModifier(p__1:String, p__2:Function, p__3:Function):void
		{
			if (!_inited){
				init();
			}
			var l__4:caurina.transitions.SpecialPropertyModifier = new SpecialPropertyModifier(p__2, p__3);
			_specialPropertyModifierList[p__1] = l__4;
		}
		public static function registerSpecialPropertySplitter(p__1:String, p__2:Function, p__3:Array = null):void
		{
			if (!_inited){
				init();
			}
			var l__4:caurina.transitions.SpecialPropertySplitter = new SpecialPropertySplitter(p__2, p__3);
			_specialPropertySplitterList[p__1] = l__4;
		}
		private static function startEngine():void
		{
			_engineExists = true;
			_tweenList = new Array();
			__tweener_controller__ = new MovieClip();
			__tweener_controller__.addEventListener(Event.ENTER_FRAME, Tweener.onEnterFrame);
			_currentTimeFrame = 0;
			updateTime();
		}
		private static function stopEngine():void
		{
			_engineExists = false;
			_tweenList = null;
			_currentTime = 0;
			_currentTimeFrame = 0;
			__tweener_controller__.removeEventListener(Event.ENTER_FRAME, Tweener.onEnterFrame);
			__tweener_controller__ = null;
		}
		public static function updateTime():void
		{
			_currentTime = getTimer();
		}
		public static function updateFrame():void
		{
			_currentTimeFrame++;
		}
		public static function onEnterFrame(p__1:flash.events.Event):void
		{
			updateTime();
			updateFrame();
			var l__2:Boolean;
			l__2 = updateTweens();
			if (!l__2){
				stopEngine();
			}
		}
		public static function setTimeScale(p__1:Number):void
		{
			var l__2:Number;
			var l__3:Number;
			if (isNaN(p__1)){
				p__1 = 1;
			}
			if ((p__1) < 1e-005){
				p__1 = 1e-005;
			}
			if ((p__1) != _timeScale){
				if (_tweenList != null){
					l__2 = 0;
					while(l__2 < _tweenList.length){
						l__3 = getCurrentTweeningTime(_tweenList[l__2]);
						_tweenList[l__2].timeStart = (l__3 - (((l__3 - _tweenList[l__2].timeStart) * _timeScale) / (p__1)));
						_tweenList[l__2].timeComplete = (l__3 - (((l__3 - _tweenList[l__2].timeComplete) * _timeScale) / (p__1)));
						if (_tweenList[l__2].timePaused != undefined){
							_tweenList[l__2].timePaused = (l__3 - (((l__3 - _tweenList[l__2].timePaused) * _timeScale) / (p__1)));
						}
						l__2++;
					}
				}
				_timeScale = p__1;
			}
		}
		public static function isTweening(p__1:Object):Boolean
		{
			var l__2:uint;
			if (!Boolean(_tweenList)){
				return(false);
			}
			l__2 = 0;
			while(l__2 < _tweenList.length){
				if (Boolean(_tweenList[l__2]) && (_tweenList[l__2].scope == (p__1))){
					return(true);
				}
				l__2++;
			}
			return(false);
		}
		public static function getTweens(p__1:Object):Array
		{
			var l__2:uint;
			var l__3:String;
			if (!Boolean(_tweenList)){
				return([]);
			}
			var l__4:Array = new Array();
			l__2 = 0;
			while(l__2 < _tweenList.length){
				if (Boolean(_tweenList[l__2]) && (_tweenList[l__2].scope == (p__1))){
					for (l__3 in _tweenList[l__2].properties){
						l__4.push(l__3);
					}
				}
				l__2++;
			}
			return(l__4);
		}
		public static function getTweenCount(p__1:Object):Number
		{
			var l__2:uint;
			if (!Boolean(_tweenList)){
				return(0);
			}
			var l__3:Number;
			l__2 = 0;
			while(l__2 < _tweenList.length){
				if (Boolean(_tweenList[l__2]) && (_tweenList[l__2].scope == (p__1))){
					l__3 = (l__3 + AuxFunctions.getObjectLength(_tweenList[l__2].properties));
				}
				l__2++;
			}
			return(l__3);
		}
		private static function handleError(pTweening:caurina.transitions.TweenListObj, pError:Error, pCallBackName:String):void
		{
			var eventScope:Object;
			if (Boolean(pTweening.onError) && (pTweening.onError is Function)){
				eventScope = Boolean(pTweening.onErrorScope) ? pTweening.onErrorScope : pTweening.scope;
				try {
					pTweening.onError.apply(eventScope, [pTweening.scope, pError]);
				} catch (metaError:Error) {
					printError((((String(pTweening.scope) + " raised an error while executing the \'onError\' handler. Original error:\n ") + pError.getStackTrace()) + "\nonError error: ") + metaError.getStackTrace());
				}
			} else if (!Boolean(pTweening.onError)){
				printError((((String(pTweening.scope) + " raised an error while executing the \'") + pCallBackName) + "\'handler. \n") + pError.getStackTrace());
			}
		}
		public static function getCurrentTweeningTime(p__1:Object):Number
		{
			return((p__1.useFrames) ? _currentTimeFrame : _currentTime);
		}
		public static function getVersion():String
		{
			return("AS3 1.31.71");
		}
		public static function printError(p__1:String):void
		{
		}
	}
}