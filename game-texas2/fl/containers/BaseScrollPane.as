// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package fl.containers
{
	import fl.core.*;
	import fl.controls.*;
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import fl.events.*;
	public class BaseScrollPane extends fl.core.UIComponent
	{
		protected var defaultLineScrollSize:Number = 4;
		protected var _maxHorizontalScrollPosition:Number = 0;
		protected var vScrollBar:Boolean;
		protected var disabledOverlay:flash.display.Shape;
		protected var hScrollBar:Boolean;
		protected var availableWidth:Number;
		protected var _verticalPageScrollSize:Number = 0;
		protected var vOffset:Number = 0;
		protected var _verticalScrollBar:fl.controls.ScrollBar;
		protected var useFixedHorizontalScrolling:Boolean = false;
		protected var contentWidth:Number = 0;
		protected var contentHeight:Number = 0;
		protected var _horizontalPageScrollSize:Number = 0;
		protected var background:flash.display.DisplayObject;
		protected var _useBitmpScrolling:Boolean = false;
		protected var contentPadding:Number = 0;
		protected var availableHeight:Number;
		protected var _horizontalScrollBar:fl.controls.ScrollBar;
		protected var contentScrollRect:flash.geom.Rectangle;
		protected var _horizontalScrollPolicy:String;
		protected var _verticalScrollPolicy:String;
		protected static const SCROLL_BAR_STYLES:Object = {upArrowDisabledSkin:"upArrowDisabledSkin", upArrowDownSkin:"upArrowDownSkin", upArrowOverSkin:"upArrowOverSkin", upArrowUpSkin:"upArrowUpSkin", downArrowDisabledSkin:"downArrowDisabledSkin", downArrowDownSkin:"downArrowDownSkin", downArrowOverSkin:"downArrowOverSkin", downArrowUpSkin:"downArrowUpSkin", thumbDisabledSkin:"thumbDisabledSkin", thumbDownSkin:"thumbDownSkin", thumbOverSkin:"thumbOverSkin", thumbUpSkin:"thumbUpSkin", thumbIcon:"thumbIcon", trackDisabledSkin:"trackDisabledSkin", trackDownSkin:"trackDownSkin", trackOverSkin:"trackOverSkin", trackUpSkin:"trackUpSkin", repeatDelay:"repeatDelay", repeatInterval:"repeatInterval"};
		private static var defaultStyles:Object = {repeatDelay:500, repeatInterval:35, skin:"ScrollPane_upSkin", contentPadding:0, disabledAlpha:0.5};
		public function BaseScrollPane()
		{
		}
		override public function set enabled(p__1:Boolean):void
		{
			if (enabled == p__1){
				return;
			}
			_verticalScrollBar.enabled = p__1;
			_horizontalScrollBar.enabled = p__1;
			super.enabled = p__1;
		}
		public function get horizontalScrollPolicy():String
		{
			return(_horizontalScrollPolicy);
		}
		public function set horizontalScrollPolicy(p__1:String):void
		{
			_horizontalScrollPolicy = p__1;
			invalidate(fl.core.InvalidationType.SIZE);
		}
		public function get verticalScrollPolicy():String
		{
			return(_verticalScrollPolicy);
		}
		public function set verticalScrollPolicy(p__1:String):void
		{
			_verticalScrollPolicy = p__1;
			invalidate(fl.core.InvalidationType.SIZE);
		}
		public function get horizontalLineScrollSize():Number
		{
			return(_horizontalScrollBar.lineScrollSize);
		}
		public function set horizontalLineScrollSize(p__1:Number):void
		{
			_horizontalScrollBar.lineScrollSize = p__1;
		}
		public function get verticalLineScrollSize():Number
		{
			return(_verticalScrollBar.lineScrollSize);
		}
		public function set verticalLineScrollSize(p__1:Number):void
		{
			_verticalScrollBar.lineScrollSize = p__1;
		}
		public function get horizontalScrollPosition():Number
		{
			return(_horizontalScrollBar.scrollPosition);
		}
		public function set horizontalScrollPosition(p__1:Number):void
		{
			drawNow();
			_horizontalScrollBar.scrollPosition = p__1;
			setHorizontalScrollPosition(_horizontalScrollBar.scrollPosition, false);
		}
		public function get verticalScrollPosition():Number
		{
			return(_verticalScrollBar.scrollPosition);
		}
		public function set verticalScrollPosition(p__1:Number):void
		{
			drawNow();
			_verticalScrollBar.scrollPosition = p__1;
			setVerticalScrollPosition(_verticalScrollBar.scrollPosition, false);
		}
		public function get maxHorizontalScrollPosition():Number
		{
			drawNow();
			return(Math.max(0, (contentWidth - availableWidth)));
		}
		public function get maxVerticalScrollPosition():Number
		{
			drawNow();
			return(Math.max(0, (contentHeight - availableHeight)));
		}
		public function get useBitmapScrolling():Boolean
		{
			return(_useBitmpScrolling);
		}
		public function set useBitmapScrolling(p__1:Boolean):void
		{
			_useBitmpScrolling = p__1;
			invalidate(fl.core.InvalidationType.STATE);
		}
		public function get horizontalPageScrollSize():Number
		{
			if (isNaN(availableWidth)){
				drawNow();
			}
			return(((_horizontalPageScrollSize == 0) && (!isNaN(availableWidth))) ? availableWidth : _horizontalPageScrollSize);
		}
		public function set horizontalPageScrollSize(p__1:Number):void
		{
			_horizontalPageScrollSize = p__1;
			invalidate(fl.core.InvalidationType.SIZE);
		}
		public function get verticalPageScrollSize():Number
		{
			if (isNaN(availableHeight)){
				drawNow();
			}
			return(((_verticalPageScrollSize == 0) && (!isNaN(availableHeight))) ? availableHeight : _verticalPageScrollSize);
		}
		public function set verticalPageScrollSize(p__1:Number):void
		{
			_verticalPageScrollSize = p__1;
			invalidate(fl.core.InvalidationType.SIZE);
		}
		public function get horizontalScrollBar():fl.controls.ScrollBar
		{
			return(_horizontalScrollBar);
		}
		public function get verticalScrollBar():fl.controls.ScrollBar
		{
			return(_verticalScrollBar);
		}
		override protected function configUI():void
		{
			var l__1:flash.display.Graphics;
			super.configUI();
			contentScrollRect = new flash.geom.Rectangle(0, 0, 85, 85);
			_verticalScrollBar = new fl.controls.ScrollBar();
			_verticalScrollBar.addEventListener(fl.events.ScrollEvent.SCROLL, handleScroll, false, 0, true);
			_verticalScrollBar.visible = false;
			_verticalScrollBar.lineScrollSize = defaultLineScrollSize;
			addChild(_verticalScrollBar);
			copyStylesToChild(_verticalScrollBar, SCROLL_BAR_STYLES);
			_horizontalScrollBar = new fl.controls.ScrollBar();
			_horizontalScrollBar.direction = fl.controls.ScrollBarDirection.HORIZONTAL;
			_horizontalScrollBar.addEventListener(fl.events.ScrollEvent.SCROLL, handleScroll, false, 0, true);
			_horizontalScrollBar.visible = false;
			_horizontalScrollBar.lineScrollSize = defaultLineScrollSize;
			addChild(_horizontalScrollBar);
			copyStylesToChild(_horizontalScrollBar, SCROLL_BAR_STYLES);
			disabledOverlay = new flash.display.Shape();
			l__1 = disabledOverlay.graphics;
			l__1.beginFill(16777215);
			l__1.drawRect(0, 0, width, height);
			l__1.endFill();
			addEventListener(flash.events.MouseEvent.MOUSE_WHEEL, handleWheel, false, 0, true);
		}
		protected function setContentSize(p__1:Number, p__2:Number):void
		{
			if (((contentWidth == p__1) || useFixedHorizontalScrolling) && (contentHeight == p__2)){
				return;
			}
			contentWidth = p__1;
			contentHeight = p__2;
			invalidate(fl.core.InvalidationType.SIZE);
		}
		protected function handleScroll(p__1:fl.events.ScrollEvent):void
		{
			if (p__1.target == _verticalScrollBar){
				setVerticalScrollPosition(p__1.position);
			} else {
				setHorizontalScrollPosition(p__1.position);
			}
		}
		protected function handleWheel(p__1:flash.events.MouseEvent):void
		{
			if (((!enabled) || (!_verticalScrollBar.visible)) || (contentHeight <= availableHeight)){
				return;
			}
			_verticalScrollBar.scrollPosition = (_verticalScrollBar.scrollPosition - (p__1.delta * verticalLineScrollSize));
			setVerticalScrollPosition(_verticalScrollBar.scrollPosition);
			dispatchEvent(new fl.events.ScrollEvent(fl.controls.ScrollBarDirection.VERTICAL, p__1.delta, horizontalScrollPosition));
		}
		protected function setHorizontalScrollPosition(p__1:Number, p__2:Boolean = false):void
		{
		}
		protected function setVerticalScrollPosition(p__1:Number, p__2:Boolean = false):void
		{
		}
		override protected function draw():void
		{
			if (isInvalid(fl.core.InvalidationType.STYLES)){
				setStyles();
				drawBackground();
				if (contentPadding != getStyleValue("contentPadding")){
					invalidate(fl.core.InvalidationType.SIZE, false);
				}
			}
			if (isInvalid(fl.core.InvalidationType.SIZE, fl.core.InvalidationType.STATE)){
				drawLayout();
			}
			updateChildren();
			super.draw();
		}
		protected function setStyles():void
		{
			copyStylesToChild(_verticalScrollBar, SCROLL_BAR_STYLES);
			copyStylesToChild(_horizontalScrollBar, SCROLL_BAR_STYLES);
		}
		protected function drawBackground():void
		{
			var l__1:flash.display.DisplayObject;
			l__1 = background;
			background = getDisplayObjectInstance(getStyleValue("skin"));
			background.width = width;
			background.height = height;
			addChildAt(background, 0);
			if (!(l__1 == null) && !(l__1 == background)){
				removeChild(l__1);
			}
		}
		protected function drawLayout():void
		{
			calculateAvailableSize();
			calculateContentWidth();
			background.width = width;
			background.height = height;
			if (vScrollBar){
				_verticalScrollBar.visible = true;
				_verticalScrollBar.x = ((width - fl.controls.ScrollBar.WIDTH) - contentPadding);
				_verticalScrollBar.y = contentPadding;
				_verticalScrollBar.height = availableHeight;
			} else {
				_verticalScrollBar.visible = false;
			}
			_verticalScrollBar.setScrollProperties(availableHeight, 0, (contentHeight - availableHeight), verticalPageScrollSize);
			setVerticalScrollPosition(_verticalScrollBar.scrollPosition, false);
			if (hScrollBar){
				_horizontalScrollBar.visible = true;
				_horizontalScrollBar.x = contentPadding;
				_horizontalScrollBar.y = ((height - fl.controls.ScrollBar.WIDTH) - contentPadding);
				_horizontalScrollBar.width = availableWidth;
			} else {
				_horizontalScrollBar.visible = false;
			}
			_horizontalScrollBar.setScrollProperties(availableWidth, 0, useFixedHorizontalScrolling ? _maxHorizontalScrollPosition : (contentWidth - availableWidth), horizontalPageScrollSize);
			setHorizontalScrollPosition(_horizontalScrollBar.scrollPosition, false);
			drawDisabledOverlay();
		}
		protected function drawDisabledOverlay():void
		{
			if (enabled){
				if (contains(disabledOverlay)){
					removeChild(disabledOverlay);
				}
			} else {
				disabledOverlay.x = disabledOverlay.y = contentPadding;
				disabledOverlay.width = availableWidth;
				disabledOverlay.height = availableHeight;
				disabledOverlay.alpha = (getStyleValue("disabledAlpha") as Number);
				addChild(disabledOverlay);
			}
		}
		protected function calculateAvailableSize():void
		{
			var l__1:Number;
			var l__2:Number;
			var l__3:Number;
			var l__4:Number;
			var l__5:Number;
			l__1 = fl.controls.ScrollBar.WIDTH;
			l__2 = contentPadding = Number(getStyleValue("contentPadding"));
			l__3 = ((height - (2 * l__2)) - vOffset);
			vScrollBar = (_verticalScrollPolicy == fl.controls.ScrollPolicy.ON) || ((_verticalScrollPolicy == fl.controls.ScrollPolicy.AUTO) && (contentHeight > l__3));
			l__4 = ((width - (vScrollBar ? l__1 : 0)) - (2 * l__2));
			l__5 = useFixedHorizontalScrolling ? _maxHorizontalScrollPosition : (contentWidth - l__4);
			hScrollBar = (_horizontalScrollPolicy == fl.controls.ScrollPolicy.ON) || ((_horizontalScrollPolicy == fl.controls.ScrollPolicy.AUTO) && (l__5 > 0));
			if (hScrollBar){
				l__3 = (l__3 - l__1);
			}
			if (((hScrollBar && (!vScrollBar)) && (_verticalScrollPolicy == fl.controls.ScrollPolicy.AUTO)) && (contentHeight > l__3)){
				vScrollBar = true;
				l__4 = (l__4 - l__1);
			}
			availableHeight = (l__3 + vOffset);
			availableWidth = l__4;
		}
		protected function calculateContentWidth():void
		{
		}
		protected function updateChildren():void
		{
			_verticalScrollBar.enabled = _horizontalScrollBar.enabled = enabled;
			_verticalScrollBar.drawNow();
			_horizontalScrollBar.drawNow();
		}
		public static function getStyleDefinition():Object
		{
			return(mergeStyles(defaultStyles, fl.controls.ScrollBar.getStyleDefinition()));
		}
	}
}