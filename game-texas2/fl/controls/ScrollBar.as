// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package fl.controls
{
	import fl.core.*;
	import flash.display.*;
	import flash.events.*;
	import fl.events.*;
	public class ScrollBar extends fl.core.UIComponent
	{
		private var _direction:String = "vertical";
		protected var inDrag:Boolean = false;
		protected var upArrow:fl.controls.BaseButton;
		private var _pageScrollSize:Number = 0;
		protected var downArrow:fl.controls.BaseButton;
		private var _pageSize:Number = 10;
		private var thumbScrollOffset:Number;
		private var _maxScrollPosition:Number = 0;
		private var _scrollPosition:Number = 0;
		protected var track:fl.controls.BaseButton;
		private var _minScrollPosition:Number = 0;
		private var _lineScrollSize:Number = 1;
		protected var thumb:fl.controls.LabelButton;
		private static var defaultStyles:Object = {downArrowDisabledSkin:"ScrollArrowDown_disabledSkin", downArrowDownSkin:"ScrollArrowDown_downSkin", downArrowOverSkin:"ScrollArrowDown_overSkin", downArrowUpSkin:"ScrollArrowDown_upSkin", thumbDisabledSkin:"ScrollThumb_upSkin", thumbDownSkin:"ScrollThumb_downSkin", thumbOverSkin:"ScrollThumb_overSkin", thumbUpSkin:"ScrollThumb_upSkin", trackDisabledSkin:"ScrollTrack_skin", trackDownSkin:"ScrollTrack_skin", trackOverSkin:"ScrollTrack_skin", trackUpSkin:"ScrollTrack_skin", upArrowDisabledSkin:"ScrollArrowUp_disabledSkin", upArrowDownSkin:"ScrollArrowUp_downSkin", upArrowOverSkin:"ScrollArrowUp_overSkin", upArrowUpSkin:"ScrollArrowUp_upSkin", thumbIcon:"ScrollBar_thumbIcon", repeatDelay:500, repeatInterval:35};
		protected static const THUMB_STYLES:Object = {disabledSkin:"thumbDisabledSkin", downSkin:"thumbDownSkin", overSkin:"thumbOverSkin", upSkin:"thumbUpSkin", icon:"thumbIcon", textPadding:0};
		public static const WIDTH:Number = 15;
		protected static const DOWN_ARROW_STYLES:Object = {disabledSkin:"downArrowDisabledSkin", downSkin:"downArrowDownSkin", overSkin:"downArrowOverSkin", upSkin:"downArrowUpSkin", repeatDelay:"repeatDelay", repeatInterval:"repeatInterval"};
		protected static const UP_ARROW_STYLES:Object = {disabledSkin:"upArrowDisabledSkin", downSkin:"upArrowDownSkin", overSkin:"upArrowOverSkin", upSkin:"upArrowUpSkin", repeatDelay:"repeatDelay", repeatInterval:"repeatInterval"};
		protected static const TRACK_STYLES:Object = {disabledSkin:"trackDisabledSkin", downSkin:"trackDownSkin", overSkin:"trackOverSkin", upSkin:"trackUpSkin", repeatDelay:"repeatDelay", repeatInterval:"repeatInterval"};
		public function ScrollBar()
		{
			setStyles();
			focusEnabled = false;
		}
		override public function setSize(p__1:Number, p__2:Number):void
		{
			if (_direction == fl.controls.ScrollBarDirection.HORIZONTAL){
				super.setSize(p__2, p__1);
			} else {
				super.setSize(p__1, p__2);
			}
		}
		override public function get width():Number
		{
			return((_direction == fl.controls.ScrollBarDirection.HORIZONTAL) ? super.height : super.width);
		}
		override public function get height():Number
		{
			return((_direction == fl.controls.ScrollBarDirection.HORIZONTAL) ? super.width : super.height);
		}
		override public function get enabled():Boolean
		{
			return(super.enabled);
		}
		override public function set enabled(p__1:Boolean):void
		{
			super.enabled = p__1;
			downArrow.enabled = track.enabled = thumb.enabled = upArrow.enabled = enabled && (_maxScrollPosition > _minScrollPosition);
			updateThumb();
		}
		public function setScrollProperties(p__1:Number, p__2:Number, p__3:Number, p__4:Number = 0):void
		{
			this.pageSize = p__1;
			_minScrollPosition = p__2;
			_maxScrollPosition = p__3;
			if (p__4 >= 0){
				_pageScrollSize = p__4;
			}
			enabled = _maxScrollPosition > _minScrollPosition;
			setScrollPosition(_scrollPosition, false);
			updateThumb();
		}
		public function get scrollPosition():Number
		{
			return(_scrollPosition);
		}
		public function set scrollPosition(p__1:Number):void
		{
			setScrollPosition(p__1, true);
		}
		public function get minScrollPosition():Number
		{
			return(_minScrollPosition);
		}
		public function set minScrollPosition(p__1:Number):void
		{
			setScrollProperties(_pageSize, p__1, _maxScrollPosition);
		}
		public function get maxScrollPosition():Number
		{
			return(_maxScrollPosition);
		}
		public function set maxScrollPosition(p__1:Number):void
		{
			setScrollProperties(_pageSize, _minScrollPosition, p__1);
		}
		public function get pageSize():Number
		{
			return(_pageSize);
		}
		public function set pageSize(p__1:Number):void
		{
			if (p__1 > 0){
				_pageSize = p__1;
			}
		}
		public function get pageScrollSize():Number
		{
			return((_pageScrollSize == 0) ? _pageSize : _pageScrollSize);
		}
		public function set pageScrollSize(p__1:Number):void
		{
			if (p__1 >= 0){
				_pageScrollSize = p__1;
			}
		}
		public function get lineScrollSize():Number
		{
			return(_lineScrollSize);
		}
		public function set lineScrollSize(p__1:Number):void
		{
			if (p__1 > 0){
				_lineScrollSize = p__1;
			}
		}
		public function get direction():String
		{
			return(_direction);
		}
		public function set direction(p__1:String):void
		{
			var l__2:Boolean;
			if (_direction == p__1){
				return;
			}
			_direction = p__1;
			if (isLivePreview){
				return;
			}
			setScaleY(1);
			l__2 = _direction == fl.controls.ScrollBarDirection.HORIZONTAL;
			if (l__2 && componentInspectorSetting){
				if (rotation == 90){
					return;
				}
				setScaleX(-1);
				rotation = -90;
			}
			if (!componentInspectorSetting){
				if (l__2 && (rotation == 0)){
					rotation = -90;
					setScaleX(-1);
				} else if ((!l__2) && (rotation == -90)){
					rotation = 0;
					setScaleX(1);
				}
			}
			invalidate(fl.core.InvalidationType.SIZE);
		}
		override protected function configUI():void
		{
			super.configUI();
			track = new fl.controls.BaseButton();
			track.move(0, 14);
			track.useHandCursor = false;
			track.autoRepeat = true;
			track.focusEnabled = false;
			addChild(track);
			thumb = new fl.controls.LabelButton();
			thumb.label = "";
			thumb.setSize(WIDTH, 15);
			thumb.move(0, 15);
			thumb.focusEnabled = false;
			addChild(thumb);
			downArrow = new fl.controls.BaseButton();
			downArrow.setSize(WIDTH, 14);
			downArrow.autoRepeat = true;
			downArrow.focusEnabled = false;
			addChild(downArrow);
			upArrow = new fl.controls.BaseButton();
			upArrow.setSize(WIDTH, 14);
			upArrow.move(0, 0);
			upArrow.autoRepeat = true;
			upArrow.focusEnabled = false;
			addChild(upArrow);
			upArrow.addEventListener(fl.events.ComponentEvent.BUTTON_DOWN, scrollPressHandler, false, 0, true);
			downArrow.addEventListener(fl.events.ComponentEvent.BUTTON_DOWN, scrollPressHandler, false, 0, true);
			track.addEventListener(fl.events.ComponentEvent.BUTTON_DOWN, scrollPressHandler, false, 0, true);
			thumb.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, thumbPressHandler, false, 0, true);
			enabled = false;
		}
		override protected function draw():void
		{
			var l__1:Number;
			if (isInvalid(fl.core.InvalidationType.SIZE)){
				l__1 = super.height;
				downArrow.move(0, Math.max(upArrow.height, (l__1 - downArrow.height)));
				track.setSize(WIDTH, Math.max(0, (l__1 - (downArrow.height + upArrow.height))));
				updateThumb();
			}
			if (isInvalid(fl.core.InvalidationType.STYLES, fl.core.InvalidationType.STATE)){
				setStyles();
			}
			downArrow.drawNow();
			upArrow.drawNow();
			track.drawNow();
			thumb.drawNow();
			validate();
		}
		protected function scrollPressHandler(p__1:fl.events.ComponentEvent):void
		{
			var l__2:Number;
			var l__3:Number;
			p__1.stopImmediatePropagation();
			if (p__1.currentTarget == upArrow){
				setScrollPosition(_scrollPosition - _lineScrollSize);
			} else if (p__1.currentTarget == downArrow){
				setScrollPosition(_scrollPosition + _lineScrollSize);
			} else {
				l__2 = ((track.mouseY / track.height) * (_maxScrollPosition - _minScrollPosition) + _minScrollPosition);
				l__3 = (pageScrollSize == 0) ? pageSize : pageScrollSize;
				if (_scrollPosition < l__2){
					setScrollPosition(Math.min(l__2, (_scrollPosition + l__3)));
				} else if (_scrollPosition > l__2){
					setScrollPosition(Math.max(l__2, (_scrollPosition - l__3)));
				}
			}
		}
		protected function thumbPressHandler(p__1:flash.events.MouseEvent):void
		{
			inDrag = true;
			thumbScrollOffset = (mouseY - thumb.y);
			thumb.mouseStateLocked = true;
			mouseChildren = false;
			stage.addEventListener(flash.events.MouseEvent.MOUSE_MOVE, handleThumbDrag, false, 0, true);
			stage.addEventListener(flash.events.MouseEvent.MOUSE_UP, thumbReleaseHandler, false, 0, true);
		}
		protected function handleThumbDrag(p__1:flash.events.MouseEvent):void
		{
			var l__2:Number;
			l__2 = Math.max(0, Math.min((track.height - thumb.height), ((mouseY - track.y) - thumbScrollOffset)));
			setScrollPosition((l__2 / (track.height - thumb.height)) * (_maxScrollPosition - _minScrollPosition) + _minScrollPosition);
		}
		protected function thumbReleaseHandler(p__1:flash.events.MouseEvent):void
		{
			inDrag = false;
			mouseChildren = true;
			thumb.mouseStateLocked = false;
			stage.removeEventListener(flash.events.MouseEvent.MOUSE_MOVE, handleThumbDrag);
			stage.removeEventListener(flash.events.MouseEvent.MOUSE_UP, thumbReleaseHandler);
		}
		public function setScrollPosition(p__1:Number, p__2:Boolean = true):void
		{
			var l__3:Number;
			l__3 = scrollPosition;
			_scrollPosition = Math.max(_minScrollPosition, Math.min(_maxScrollPosition, p__1));
			if (l__3 == _scrollPosition){
				return;
			}
			if (p__2){
				dispatchEvent(new fl.events.ScrollEvent(_direction, (scrollPosition - l__3), scrollPosition));
			}
			updateThumb();
		}
		protected function setStyles():void
		{
			copyStylesToChild(downArrow, DOWN_ARROW_STYLES);
			copyStylesToChild(thumb, THUMB_STYLES);
			copyStylesToChild(track, TRACK_STYLES);
			copyStylesToChild(upArrow, UP_ARROW_STYLES);
		}
		protected function updateThumb():void
		{
			var l__1:Number;
			l__1 = ((_maxScrollPosition - _minScrollPosition) + _pageSize);
			if (((track.height <= 12) || (_maxScrollPosition <= _minScrollPosition)) || ((l__1 == 0) || isNaN(l__1))){
				thumb.height = 12;
				thumb.visible = false;
			} else {
				thumb.height = Math.max(13, (_pageSize / l__1) * track.height);
				thumb.y = (track.y + ((track.height - thumb.height) * ((_scrollPosition - _minScrollPosition) / (_maxScrollPosition - _minScrollPosition))));
				thumb.visible = enabled;
			}
		}
		public static function getStyleDefinition():Object
		{
			return(defaultStyles);
		}
	}
}