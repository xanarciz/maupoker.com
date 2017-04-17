// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package fl.core
{
	import flash.display.*;
	import flash.events.*;
	import fl.managers.*;
	import flash.system.*;
	import fl.events.*;
	import flash.utils.*;
	import flash.text.*;
	public class UIComponent extends flash.display.Sprite
	{
		protected var _enabled:Boolean = true;
		private var _mouseFocusEnabled:Boolean = true;
		protected var startHeight:Number;
		protected var _height:Number;
		protected var _oldIMEMode:String = null;
		protected var startWidth:Number;
		public var focusTarget:fl.managers.IFocusManagerComponent;
		protected var errorCaught:Boolean = false;
		protected var uiFocusRect:flash.display.DisplayObject;
		protected var _width:Number;
		public var version:String = "3.0.0.15";
		protected var isFocused:Boolean = false;
		protected var callLaterMethods:flash.utils.Dictionary;
		private var _focusEnabled:Boolean = true;
		private var tempText:flash.text.TextField;
		protected var invalidateFlag:Boolean = false;
		protected var _inspector:Boolean = false;
		protected var sharedStyles:Object;
		protected var invalidHash:Object;
		protected var isLivePreview:Boolean = false;
		protected var _imeMode:String = null;
		protected var instanceStyles:Object;
		protected var _x:Number;
		protected var _y:Number;
		public static var inCallLaterPhase:Boolean = false;
		private static var defaultStyles:Object = {focusRectSkin:"focusRectSkin", focusRectPadding:2, textFormat:new flash.text.TextFormat("_sans", 11, 0, false, false, false, "", "", flash.text.TextFormatAlign.LEFT, 0, 0, 0, 0), disabledTextFormat:new flash.text.TextFormat("_sans", 11, 10066329, false, false, false, "", "", flash.text.TextFormatAlign.LEFT, 0, 0, 0, 0), defaultTextFormat:new flash.text.TextFormat("_sans", 11, 0, false, false, false, "", "", flash.text.TextFormatAlign.LEFT, 0, 0, 0, 0), defaultDisabledTextFormat:new flash.text.TextFormat("_sans", 11, 10066329, false, false, false, "", "", flash.text.TextFormatAlign.LEFT, 0, 0, 0, 0)};
		public static var createAccessibilityImplementation:Function;
		private static var focusManagers:flash.utils.Dictionary = new flash.utils.Dictionary(false);
		public function UIComponent()
		{
			instanceStyles = {};
			sharedStyles = {};
			invalidHash = {};
			callLaterMethods = new flash.utils.Dictionary();
			fl.managers.StyleManager.registerInstance(this);
			configUI();
			invalidate(fl.core.InvalidationType.ALL);
			tabEnabled = this is fl.managers.IFocusManagerComponent;
			focusRect = false;
			if (tabEnabled){
				addEventListener(flash.events.FocusEvent.FOCUS_IN, focusInHandler);
				addEventListener(flash.events.FocusEvent.FOCUS_OUT, focusOutHandler);
				addEventListener(flash.events.KeyboardEvent.KEY_DOWN, keyDownHandler);
				addEventListener(flash.events.KeyboardEvent.KEY_UP, keyUpHandler);
			}
			initializeFocusManager();
			addEventListener(flash.events.Event.ENTER_FRAME, hookAccessibility, false, 0, true);
		}
		public function get componentInspectorSetting():Boolean
		{
			return(_inspector);
		}
		public function set componentInspectorSetting(p__1:Boolean):void
		{
			_inspector = p__1;
			if (_inspector){
				beforeComponentParameters();
			} else {
				afterComponentParameters();
			}
		}
		protected function beforeComponentParameters():void
		{
		}
		protected function afterComponentParameters():void
		{
		}
		public function get enabled():Boolean
		{
			return(_enabled);
		}
		public function set enabled(p__1:Boolean):void
		{
			if (p__1 == _enabled){
				return;
			}
			_enabled = p__1;
			invalidate(fl.core.InvalidationType.STATE);
		}
		public function setSize(p__1:Number, p__2:Number):void
		{
			_width = p__1;
			_height = p__2;
			invalidate(fl.core.InvalidationType.SIZE);
			dispatchEvent(new fl.events.ComponentEvent(fl.events.ComponentEvent.RESIZE, false));
		}
		override public function get width():Number
		{
			return(_width);
		}
		override public function set width(p__1:Number):void
		{
			if (_width == p__1){
				return;
			}
			setSize(p__1, height);
		}
		override public function get height():Number
		{
			return(_height);
		}
		override public function set height(p__1:Number):void
		{
			if (_height == p__1){
				return;
			}
			setSize(width, p__1);
		}
		public function setStyle(p__1:String, p__2:Object):void
		{
			if ((instanceStyles[p__1] === p__2) && !(p__2 is flash.text.TextFormat)){
				return;
			}
			instanceStyles[p__1] = p__2;
			invalidate(fl.core.InvalidationType.STYLES);
		}
		public function clearStyle(p__1:String):void
		{
			setStyle(p__1, null);
		}
		public function getStyle(p__1:String):Object
		{
			return(instanceStyles[p__1]);
		}
		public function move(p__1:Number, p__2:Number):void
		{
			_x = p__1;
			_y = p__2;
			super.x = Math.round(p__1);
			super.y = Math.round(p__2);
			dispatchEvent(new fl.events.ComponentEvent(fl.events.ComponentEvent.MOVE));
		}
		override public function get x():Number
		{
			return(isNaN(_x) ? super.x : _x);
		}
		override public function set x(p__1:Number):void
		{
			move(p__1, _y);
		}
		override public function get y():Number
		{
			return(isNaN(_y) ? super.y : _y);
		}
		override public function set y(p__1:Number):void
		{
			move(_x, p__1);
		}
		override public function get scaleX():Number
		{
			return(width / startWidth);
		}
		override public function set scaleX(p__1:Number):void
		{
			setSize(startWidth * p__1, height);
		}
		override public function get scaleY():Number
		{
			return(height / startHeight);
		}
		override public function set scaleY(p__1:Number):void
		{
			setSize(width, startHeight * p__1);
		}
		protected function getScaleY():Number
		{
			return(super.scaleY);
		}
		protected function setScaleY(p__1:Number):void
		{
			super.scaleY = p__1;
		}
		protected function getScaleX():Number
		{
			return(super.scaleX);
		}
		protected function setScaleX(p__1:Number):void
		{
			super.scaleX = p__1;
		}
		override public function get visible():Boolean
		{
			return(super.visible);
		}
		override public function set visible(p__1:Boolean):void
		{
			var l__2:String;
			if (super.visible == p__1){
				return;
			}
			super.visible = p__1;
			l__2 = p__1 ? fl.events.ComponentEvent.SHOW : fl.events.ComponentEvent.HIDE;
			dispatchEvent(new fl.events.ComponentEvent(l__2, true));
		}
		public function validateNow():void
		{
			invalidate(fl.core.InvalidationType.ALL, false);
			draw();
		}
		public function invalidate(p__1:String = "all", p__2:Boolean = true):void
		{
			invalidHash[p__1] = true;
			if (p__2){
				this.callLater(draw);
			}
		}
		public function setSharedStyle(p__1:String, p__2:Object):void
		{
			if ((sharedStyles[p__1] === p__2) && !(p__2 is flash.text.TextFormat)){
				return;
			}
			sharedStyles[p__1] = p__2;
			if (instanceStyles[p__1] == null){
				invalidate(fl.core.InvalidationType.STYLES);
			}
		}
		public function get focusEnabled():Boolean
		{
			return(_focusEnabled);
		}
		public function set focusEnabled(p__1:Boolean):void
		{
			_focusEnabled = p__1;
		}
		public function get mouseFocusEnabled():Boolean
		{
			return(_mouseFocusEnabled);
		}
		public function set mouseFocusEnabled(p__1:Boolean):void
		{
			_mouseFocusEnabled = p__1;
		}
		public function get focusManager():fl.managers.IFocusManager
		{
			var l__1:flash.display.DisplayObject;
			l__1 = this;
			while(l__1){
				if (fl.core.UIComponent.focusManagers[l__1] != null){
					return(fl.managers.IFocusManager(fl.core.UIComponent.focusManagers[l__1]));
				}
				l__1 = l__1.parent;
			}
			return(null);
		}
		public function set focusManager(p__1:fl.managers.IFocusManager):void
		{
			fl.core.UIComponent.focusManagers[this] = p__1;
		}
		public function drawFocus(p__1:Boolean):void
		{
			var l__2:Number;
			isFocused = p__1;
			if (!(uiFocusRect == null) && contains(uiFocusRect)){
				removeChild(uiFocusRect);
				uiFocusRect = null;
			}
			if (p__1){
				uiFocusRect = (getDisplayObjectInstance(getStyleValue("focusRectSkin")) as flash.display.Sprite);
				if (uiFocusRect == null){
					return;
				}
				l__2 = Number(getStyleValue("focusRectPadding"));
				uiFocusRect.x = -l__2;
				uiFocusRect.y = -l__2;
				uiFocusRect.width = (width + (l__2 * 2));
				uiFocusRect.height = (height + (l__2 * 2));
				addChildAt(uiFocusRect, 0);
			}
		}
		public function setFocus():void
		{
			if (stage){
				stage.focus = this;
			}
		}
		public function getFocus():flash.display.InteractiveObject
		{
			if (stage){
				return(stage.focus);
			}
			return(null);
		}
		protected function setIMEMode(enabled:Boolean)
		{
			if (_imeMode != null){
				if (enabled){
					flash.system.IME.enabled = true;
					_oldIMEMode = flash.system.IME.conversionMode;
					try {
						if ((!errorCaught) && !(flash.system.IME.conversionMode == flash.system.IMEConversionMode.UNKNOWN)){
							flash.system.IME.conversionMode = _imeMode;
						}
						errorCaught = false;
					} catch (e:Error) {
						errorCaught = true;
						throw new Error("IME mode not supported: " + _imeMode);
					}
				} else {
					if (!(flash.system.IME.conversionMode == flash.system.IMEConversionMode.UNKNOWN) && !(_oldIMEMode == flash.system.IMEConversionMode.UNKNOWN)){
						flash.system.IME.conversionMode = _oldIMEMode;
					}
					flash.system.IME.enabled = false;
				}
			}
		}
		public function drawNow():void
		{
			draw();
		}
		protected function configUI():void
		{
			var l__1:Number;
			var l__2:Number;
			var l__3:Number;
			isLivePreview = checkLivePreview();
			l__1 = rotation;
			rotation = 0;
			l__2 = super.width;
			l__3 = super.height;
			super.scaleY = 1;
			super.scaleX = 1;
			setSize(l__2, l__3);
			move(super.x, super.y);
			rotation = l__1;
			startWidth = l__2;
			startHeight = l__3;
			if (numChildren > 0){
				removeChildAt(0);
			}
		}
		protected function checkLivePreview():Boolean
		{
			var className:String;
			if (parent == null){
				return(false);
			}
			try {
				className = flash.utils.getQualifiedClassName(parent);
			} catch (e:Error) {
			}
			return(className == "fl.livepreview::LivePreviewParent");
		}
		protected function isInvalid(p__1:String, ... p__2):Boolean
		{
			if (invalidHash[p__1] || invalidHash[fl.core.InvalidationType.ALL]){
				return(true);
			}
			while(p__2.length > 0){
				if (invalidHash[p__2.AS3::pop()]){
					return(true);
				}
			}
			return(false);
		}
		protected function validate():void
		{
			invalidHash = {};
		}
		protected function draw():void
		{
			if (isInvalid(fl.core.InvalidationType.SIZE, fl.core.InvalidationType.STYLES)){
				if (isFocused && focusManager.showFocusIndicator){
					drawFocus(true);
				}
			}
			validate();
		}
		protected function getDisplayObjectInstance(skin:Object):flash.display.DisplayObject
		{
			var classDef:Object;
			classDef = null;
			if (skin is Class){
				return((new skin()) as flash.display.DisplayObject);
			}
			if (skin is flash.display.DisplayObject){
				(skin as flash.display.DisplayObject).x = 0;
				(skin as flash.display.DisplayObject).y = 0;
				return(skin as flash.display.DisplayObject);
			}
			try {
				classDef = flash.utils.getDefinitionByName(skin.toString());
			} catch (e:Error) {
				try {
					classDef = (loaderInfo.applicationDomain.getDefinition(skin.toString()) as Object);
				} catch (e:Error) {
				}
			}
			if (classDef == null){
				return(null);
			}
			return((new classDef()) as flash.display.DisplayObject);
		}
		protected function getStyleValue(p__1:String):Object
		{
			return((instanceStyles[p__1] == null) ? sharedStyles[p__1] : instanceStyles[p__1]);
		}
		protected function copyStylesToChild(p__1:fl.core.UIComponent, p__2:Object):void
		{
			var l__3:String;
			for (l__3 in p__2){
				p__1.setStyle(l__3, getStyleValue(p__2[l__3]));
			}
		}
		protected function callLater(p__1:Function):void
		{
			if (inCallLaterPhase){
				return;
			}
			callLaterMethods[p__1] = true;
			if (stage != null){
				stage.addEventListener(flash.events.Event.RENDER, callLaterDispatcher, false, 0, true);
				stage.invalidate();
			} else {
				addEventListener(flash.events.Event.ADDED_TO_STAGE, callLaterDispatcher, false, 0, true);
			}
		}
		private function callLaterDispatcher(p__1:flash.events.Event):void
		{
			var l__2:flash.utils.Dictionary;
			var l__3:Object;
			if (p__1.type == flash.events.Event.ADDED_TO_STAGE){
				removeEventListener(flash.events.Event.ADDED_TO_STAGE, callLaterDispatcher);
				stage.addEventListener(flash.events.Event.RENDER, callLaterDispatcher, false, 0, true);
				stage.invalidate();
				return;
			}
			p__1.target.removeEventListener(flash.events.Event.RENDER, callLaterDispatcher);
			if (stage == null){
				addEventListener(flash.events.Event.ADDED_TO_STAGE, callLaterDispatcher, false, 0, true);
				return;
			}
			inCallLaterPhase = true;
			l__2 = callLaterMethods;
			for (l__3 in l__2){
				l__3();
				delete l__2[l__3];
			}
			inCallLaterPhase = false;
		}
		private function initializeFocusManager():void
		{
			if (stage == null){
				addEventListener(flash.events.Event.ADDED_TO_STAGE, addedHandler, false, 0, true);
			} else {
				createFocusManager();
			}
		}
		private function addedHandler(p__1:flash.events.Event):void
		{
			removeEventListener("addedToStage", addedHandler);
			initializeFocusManager();
		}
		protected function createFocusManager():void
		{
			if (focusManagers[stage] == null){
				focusManagers[stage] = new fl.managers.FocusManager(stage);
			}
		}
		protected function isOurFocus(p__1:flash.display.DisplayObject):Boolean
		{
			return(p__1 == this);
		}
		protected function focusInHandler(p__1:flash.events.FocusEvent):void
		{
			var l__2:fl.managers.IFocusManager;
			if (isOurFocus(p__1.target as flash.display.DisplayObject)){
				l__2 = focusManager;
				if (l__2 && l__2.showFocusIndicator){
					drawFocus(true);
					isFocused = true;
				}
			}
		}
		protected function focusOutHandler(p__1:flash.events.FocusEvent):void
		{
			if (isOurFocus(p__1.target as flash.display.DisplayObject)){
				drawFocus(false);
				isFocused = false;
			}
		}
		protected function keyDownHandler(p__1:flash.events.KeyboardEvent):void
		{
		}
		protected function keyUpHandler(p__1:flash.events.KeyboardEvent):void
		{
		}
		protected function hookAccessibility(p__1:flash.events.Event):void
		{
			removeEventListener(flash.events.Event.ENTER_FRAME, hookAccessibility);
			initializeAccessibility();
		}
		protected function initializeAccessibility():void
		{
			if (fl.core.UIComponent.createAccessibilityImplementation != null){
				fl.core.UIComponent.createAccessibilityImplementation(this);
			}
		}
		public static function getStyleDefinition():Object
		{
			return(defaultStyles);
		}
		public static function mergeStyles(... p__1):Object
		{
			var l__2:Object;
			var l__3:uint;
			var l__4:uint;
			var l__5:Object;
			var l__6:String;
			l__2 = {};
			l__3 = p__1.length;
			l__4 = 0;
			while(l__4 < l__3){
				l__5 = p__1[l__4];
				for (l__6 in l__5){
					if (l__2[l__6] != null){
					} else {
						l__2[l__6] = p__1[l__4][l__6];
					}
				}
				l__4++;
			}
			return(l__2);
		}
	}
}