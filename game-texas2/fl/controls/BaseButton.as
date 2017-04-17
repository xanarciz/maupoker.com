// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package fl.controls
{
	import fl.core.*;
	import flash.display.*;
	import flash.events.*;
	import fl.events.*;
	import flash.utils.*;
	public class BaseButton extends fl.core.UIComponent
	{
		protected var _selected:Boolean = false;
		private var unlockedMouseState:String;
		protected var pressTimer:flash.utils.Timer;
		protected var mouseState:String;
		protected var background:flash.display.DisplayObject;
		private var _mouseStateLocked:Boolean = false;
		protected var _autoRepeat:Boolean = false;
		private static var defaultStyles:Object = {upSkin:"Button_upSkin", downSkin:"Button_downSkin", overSkin:"Button_overSkin", disabledSkin:"Button_disabledSkin", selectedDisabledSkin:"Button_selectedDisabledSkin", selectedUpSkin:"Button_selectedUpSkin", selectedDownSkin:"Button_selectedDownSkin", selectedOverSkin:"Button_selectedOverSkin", focusRectSkin:null, focusRectPadding:null, repeatDelay:500, repeatInterval:35};
		public function BaseButton()
		{
			buttonMode = true;
			mouseChildren = false;
			useHandCursor = false;
			setupMouseEvents();
			setMouseState("up");
			pressTimer = new flash.utils.Timer(1, 0);
			pressTimer.addEventListener(flash.events.TimerEvent.TIMER, buttonDown, false, 0, true);
		}
		override public function get enabled():Boolean
		{
			return(super.enabled);
		}
		override public function set enabled(p__1:Boolean):void
		{
			super.enabled = p__1;
			mouseEnabled = p__1;
		}
		public function get selected():Boolean
		{
			return(_selected);
		}
		public function set selected(p__1:Boolean):void
		{
			if (_selected == p__1){
				return;
			}
			_selected = p__1;
			invalidate(fl.core.InvalidationType.STATE);
		}
		public function get autoRepeat():Boolean
		{
			return(_autoRepeat);
		}
		public function set autoRepeat(p__1:Boolean):void
		{
			_autoRepeat = p__1;
		}
		public function set mouseStateLocked(p__1:Boolean):void
		{
			_mouseStateLocked = p__1;
			if (p__1 == false){
				setMouseState(unlockedMouseState);
			} else {
				unlockedMouseState = mouseState;
			}
		}
		public function setMouseState(p__1:String):void
		{
			if (_mouseStateLocked){
				unlockedMouseState = p__1;
				return;
			}
			if (mouseState == p__1){
				return;
			}
			mouseState = p__1;
			invalidate(fl.core.InvalidationType.STATE);
		}
		protected function setupMouseEvents():void
		{
			addEventListener(flash.events.MouseEvent.ROLL_OVER, mouseEventHandler, false, 0, true);
			addEventListener(flash.events.MouseEvent.MOUSE_DOWN, mouseEventHandler, false, 0, true);
			addEventListener(flash.events.MouseEvent.MOUSE_UP, mouseEventHandler, false, 0, true);
			addEventListener(flash.events.MouseEvent.ROLL_OUT, mouseEventHandler, false, 0, true);
		}
		protected function mouseEventHandler(p__1:flash.events.MouseEvent):void
		{
			if (p__1.type == flash.events.MouseEvent.MOUSE_DOWN){
				setMouseState("down");
				startPress();
			} else if ((p__1.type == flash.events.MouseEvent.ROLL_OVER) || (p__1.type == flash.events.MouseEvent.MOUSE_UP)){
				setMouseState("over");
				endPress();
			} else if (p__1.type == flash.events.MouseEvent.ROLL_OUT){
				setMouseState("up");
				endPress();
			}
		}
		protected function startPress():void
		{
			if (_autoRepeat){
				pressTimer.delay = Number(getStyleValue("repeatDelay"));
				pressTimer.start();
			}
			dispatchEvent(new fl.events.ComponentEvent(fl.events.ComponentEvent.BUTTON_DOWN, true));
		}
		protected function buttonDown(p__1:flash.events.TimerEvent):void
		{
			if (!_autoRepeat){
				endPress();
				return;
			}
			if (pressTimer.currentCount == 1){
				pressTimer.delay = Number(getStyleValue("repeatInterval"));
			}
			dispatchEvent(new fl.events.ComponentEvent(fl.events.ComponentEvent.BUTTON_DOWN, true));
		}
		protected function endPress():void
		{
			pressTimer.reset();
		}
		override protected function draw():void
		{
			if (isInvalid(fl.core.InvalidationType.STYLES, fl.core.InvalidationType.STATE)){
				drawBackground();
				invalidate(fl.core.InvalidationType.SIZE, false);
			}
			if (isInvalid(fl.core.InvalidationType.SIZE)){
				drawLayout();
			}
			super.draw();
		}
		protected function drawBackground():void
		{
			var l__1:String;
			var l__2:flash.display.DisplayObject;
			l__1 = enabled ? mouseState : "disabled";
			if (selected){
				l__1 = (("selected" + l__1.AS3::substr(0, 1).AS3::toUpperCase()) + l__1.AS3::substr(1));
			}
			l__1 = (l__1 + "Skin");
			l__2 = background;
			background = getDisplayObjectInstance(getStyleValue(l__1));
			addChildAt(background, 0);
			if (!(l__2 == null) && !(l__2 == background)){
				removeChild(l__2);
			}
		}
		protected function drawLayout():void
		{
			background.width = width;
			background.height = height;
		}
		public static function getStyleDefinition():Object
		{
			return(defaultStyles);
		}
	}
}