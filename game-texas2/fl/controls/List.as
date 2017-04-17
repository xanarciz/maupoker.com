// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package fl.controls
{
	import fl.controls.listClasses.*;
	import fl.core.*;
	import flash.display.*;
	import flash.events.*;
	import fl.managers.*;
	import flash.utils.*;
	import fl.containers.*;
	import flash.geom.*;
	import flash.ui.*;
	public class List extends fl.controls.SelectableList implements IFocusManagerComponent
	{
		protected var _iconField:String = "icon";
		protected var _labelField:String = "label";
		protected var _iconFunction:Function;
		protected var _rowHeight:Number = 20;
		protected var _cellRenderer:Object;
		protected var _labelFunction:Function;
		public static var createAccessibilityImplementation:Function;
		private static var defaultStyles:Object = {focusRectSkin:null, focusRectPadding:null};
		public function List()
		{
		}
		public function get labelField():String
		{
			return(_labelField);
		}
		public function set labelField(p__1:String):void
		{
			if ((p__1) == _labelField){
				return;
			}
			_labelField = p__1;
			invalidate(fl.core.InvalidationType.DATA);
		}
		public function get labelFunction():Function
		{
			return(_labelFunction);
		}
		public function set labelFunction(p__1:Function):void
		{
			if (_labelFunction == (p__1)){
				return;
			}
			_labelFunction = p__1;
			invalidate(fl.core.InvalidationType.DATA);
		}
		public function get iconField():String
		{
			return(_iconField);
		}
		public function set iconField(p__1:String):void
		{
			if ((p__1) == _iconField){
				return;
			}
			_iconField = p__1;
			invalidate(fl.core.InvalidationType.DATA);
		}
		public function get iconFunction():Function
		{
			return(_iconFunction);
		}
		public function set iconFunction(p__1:Function):void
		{
			if (_iconFunction == (p__1)){
				return;
			}
			_iconFunction = p__1;
			invalidate(fl.core.InvalidationType.DATA);
		}
		override public function get rowCount():uint
		{
			return(Math.ceil(calculateAvailableHeight() / rowHeight));
		}
		public function set rowCount(p__1:uint):void
		{
			var l__2:Number = Number(getStyleValue("contentPadding"));
			var l__3:Number = ((_horizontalScrollPolicy == fl.controls.ScrollPolicy.ON) || ((_horizontalScrollPolicy == fl.controls.ScrollPolicy.AUTO) && (_maxHorizontalScrollPosition > 0))) ? 15 : 0;
			height = ((rowHeight * (p__1) + (2 * l__2)) + l__3);
		}
		public function get rowHeight():Number
		{
			return(_rowHeight);
		}
		public function set rowHeight(p__1:Number):void
		{
			_rowHeight = p__1;
			invalidate(fl.core.InvalidationType.SIZE);
		}
		override public function scrollToIndex(p__1:int):void
		{
			drawNow();
			var l__2:uint = Math.floor(((_verticalScrollPosition + availableHeight)) / rowHeight) - 1;
			var l__3:uint = Math.ceil(_verticalScrollPosition / rowHeight);
			if ((p__1) < l__3){
				verticalScrollPosition = (p__1) * rowHeight;
			} else if ((p__1) > l__2){
				verticalScrollPosition = ((p__1 + 1) * rowHeight - availableHeight);
			}
		}
		override protected function configUI():void
		{
			useFixedHorizontalScrolling = true;
			_horizontalScrollPolicy = fl.controls.ScrollPolicy.AUTO;
			_verticalScrollPolicy = fl.controls.ScrollPolicy.AUTO;
			super.configUI();
		}
		protected function calculateAvailableHeight():Number
		{
			var l__1:Number = Number(getStyleValue("contentPadding"));
			return((height - (l__1 * 2)) - (((_horizontalScrollPolicy == fl.controls.ScrollPolicy.ON) || ((_horizontalScrollPolicy == fl.controls.ScrollPolicy.AUTO) && (_maxHorizontalScrollPosition > 0))) ? 15 : 0));
		}
		override protected function setHorizontalScrollPosition(p__1:Number, p__2:Boolean = false):void
		{
			list.x = -(p__1);
			super.setHorizontalScrollPosition(p__1, true);
		}
		override protected function setVerticalScrollPosition(p__1:Number, p__2:Boolean = false):void
		{
			invalidate(fl.core.InvalidationType.SCROLL);
			super.setVerticalScrollPosition(p__1, true);
		}
		override protected function draw():void
		{
			var l__1:* = !(contentHeight == ((rowHeight * length)));
			contentHeight = rowHeight * length;
			if (isInvalid(fl.core.InvalidationType.STYLES)){
				setStyles();
				drawBackground();
				if (contentPadding != getStyleValue("contentPadding")){
					invalidate(fl.core.InvalidationType.SIZE, false);
				}
				if (_cellRenderer != getStyleValue("cellRenderer")){
					_invalidateList();
					_cellRenderer = getStyleValue("cellRenderer");
				}
			}
			if (isInvalid(fl.core.InvalidationType.SIZE, fl.core.InvalidationType.STATE) || l__1){
				drawLayout();
			}
			if (isInvalid(fl.core.InvalidationType.RENDERER_STYLES)){
				updateRendererStyles();
			}
			if (isInvalid(fl.core.InvalidationType.STYLES, fl.core.InvalidationType.SIZE, fl.core.InvalidationType.DATA, fl.core.InvalidationType.SCROLL, fl.core.InvalidationType.SELECTED)){
				drawList();
			}
			updateChildren();
			validate();
		}
		override protected function drawList():void
		{
			var l__4:uint;
			var l__5:Object;
			var l__6:fl.controls.listClasses.ICellRenderer;
			var l__9:Boolean;
			var l__10:String;
			var l__11:Object;
			var l__12:flash.display.Sprite;
			var l__13:String;
			listHolder.x = listHolder.y = contentPadding;
			var l__1:flash.geom.Rectangle = listHolder.scrollRect;
			l__1.x = _horizontalScrollPosition;
			l__1.y = (Math.floor(_verticalScrollPosition) % rowHeight);
			listHolder.scrollRect = l__1;
			listHolder.cacheAsBitmap = useBitmapScrolling;
			var l__2:uint = Math.floor(_verticalScrollPosition / rowHeight);
			var l__3:uint = Math.min(length, ((l__2 + rowCount) + 1));
			var l__7:flash.utils.Dictionary = renderedItems = new flash.utils.Dictionary(true);
			l__4 = l__2;
			while(l__4 < l__3){
				l__7[_dataProvider.getItemAt(l__4)] = true;
				l__4++;
			}
			var l__8:flash.utils.Dictionary = new flash.utils.Dictionary(true);
			while(activeCellRenderers.length > 0){
				l__6 = (activeCellRenderers.AS3::pop() as fl.controls.listClasses.ICellRenderer);
				l__5 = l__6.data;
				if ((l__7[l__5] == null) || (invalidItems[l__5] == true)){
					availableCellRenderers.AS3::push(l__6);
				} else {
					l__8[l__5] = l__6;
					invalidItems[l__5] = true;
				}
				list.removeChild(l__6 as flash.display.DisplayObject);
			}
			invalidItems = new flash.utils.Dictionary(true);
			l__4 = l__2;
			while(l__4 < l__3){
				l__9 = false;
				l__5 = _dataProvider.getItemAt(l__4);
				if (l__8[l__5] != null){
					l__9 = true;
					l__6 = l__8[l__5];
					delete l__8[l__5];
				} else if (availableCellRenderers.length > 0){
					l__6 = (availableCellRenderers.AS3::pop() as fl.controls.listClasses.ICellRenderer);
				} else if ((l__12 = ((l__6 = (getDisplayObjectInstance(getStyleValue("cellRenderer")) as fl.controls.listClasses.ICellRenderer)) as flash.display.Sprite)) != null){
					l__12.addEventListener(flash.events.MouseEvent.CLICK, handleCellRendererClick, false, 0, true);
					l__12.addEventListener(flash.events.MouseEvent.ROLL_OVER, handleCellRendererMouseEvent, false, 0, true);
					l__12.addEventListener(flash.events.MouseEvent.ROLL_OUT, handleCellRendererMouseEvent, false, 0, true);
					l__12.addEventListener(flash.events.Event.CHANGE, handleCellRendererChange, false, 0, true);
					l__12.doubleClickEnabled = true;
					l__12.addEventListener(flash.events.MouseEvent.DOUBLE_CLICK, handleCellRendererDoubleClick, false, 0, true);
					if (l__12.AS3::hasOwnProperty("setStyle")){
						for (l__13 in rendererStyles){
							l__12["setStyle"](l__13, rendererStyles[l__13]);
						}
					}
				}
				list.addChild(l__6 as flash.display.Sprite);
				activeCellRenderers.AS3::push(l__6);
				l__6.y = rowHeight * (l__4 - l__2);
				l__6.setSize((availableWidth + _maxHorizontalScrollPosition), rowHeight);
				l__10 = itemToLabel(l__5);
				l__11 = null;
				if (_iconFunction != null){
					l__11 = _iconFunction(l__5);
				} else if (_iconField != null){
					l__11 = l__5[_iconField];
				}
				if (!l__9){
					l__6.data = l__5;
				}
				l__6.listData = new fl.controls.listClasses.ListData(l__10, l__11, this, l__4, l__4, 0);
				l__6.selected = !(_selectedIndices.AS3::indexOf(l__4) == -1);
				if (l__6 is fl.core.UIComponent){
					(l__6 as fl.core.UIComponent).drawNow();
				}
				l__4++;
			}
		}
		override protected function keyDownHandler(p__1:flash.events.KeyboardEvent):void
		{
			var l__2:int;
			if (!selectable){
				return;
			}
			switch(p__1.keyCode){
				case flash.ui.Keyboard.UP:
				{
				}
				case flash.ui.Keyboard.DOWN:
				{
				}
				case flash.ui.Keyboard.END:
				{
				}
				case flash.ui.Keyboard.HOME:
				{
				}
				case flash.ui.Keyboard.PAGE_UP:
				{
				}
				case flash.ui.Keyboard.PAGE_DOWN:
				{
					moveSelectionVertically(p__1.keyCode, (p__1.shiftKey) && _allowMultipleSelection, (p__1.ctrlKey) && _allowMultipleSelection);
					break;
				}
				case flash.ui.Keyboard.LEFT:
				{
				}
				case flash.ui.Keyboard.RIGHT:
				{
					moveSelectionHorizontally(p__1.keyCode, (p__1.shiftKey) && _allowMultipleSelection, (p__1.ctrlKey) && _allowMultipleSelection);
					break;
				}
				case flash.ui.Keyboard.SPACE:
				{
					if (caretIndex == -1){
						caretIndex = 0;
					}
					doKeySelection(caretIndex, p__1.shiftKey, p__1.ctrlKey);
					scrollToSelected();
					break;
				}
				default:
				{
					l__2 = getNextIndexAtLetter(String.AS3::fromCharCode(p__1.keyCode), selectedIndex);
					if (l__2 > -1){
						selectedIndex = l__2;
						scrollToSelected();
					}
					break;
				}
			}
			(p__1).stopPropagation();
		}
		override protected function moveSelectionHorizontally(p__1:uint, p__2:Boolean, p__3:Boolean):void
		{
		}
		override protected function moveSelectionVertically(p__1:uint, p__2:Boolean, p__3:Boolean):void
		{
			var l__4:int = Math.max(Math.floor(calculateAvailableHeight() / rowHeight), 1);
			var l__5:* = -1;
			var l__6:int;
			switch(p__1){
				case flash.ui.Keyboard.UP:
				{
					if (caretIndex > 0){
						l__5 = caretIndex - 1;
					}
					break;
				}
				case flash.ui.Keyboard.DOWN:
				{
					if (caretIndex < (length - 1)){
						l__5 = (caretIndex + 1);
					}
					break;
				}
				case flash.ui.Keyboard.PAGE_UP:
				{
					if (caretIndex > 0){
						l__5 = Math.max((caretIndex - l__4), 0);
					}
					break;
				}
				case flash.ui.Keyboard.PAGE_DOWN:
				{
					if (caretIndex < (length - 1)){
						l__5 = Math.min((caretIndex + l__4), length - 1);
					}
					break;
				}
				case flash.ui.Keyboard.HOME:
				{
					if (caretIndex > 0){
						l__5 = 0;
					}
					break;
				}
				case flash.ui.Keyboard.END:
				{
					if (caretIndex < (length - 1)){
						l__5 = length - 1;
					}
					break;
				}
			}
			if (l__5 >= 0){
				doKeySelection(l__5, p__2, p__3);
				scrollToSelected();
			}
		}
		protected function doKeySelection(p__1:int, p__2:Boolean, p__3:Boolean):void
		{
			var l__5:int;
			var l__6:Array;
			var l__7:int;
			var l__8:int;
			var l__4:Boolean;
			if (p__2){
				l__6 = [];
				l__7 = lastCaretIndex;
				l__8 = p__1;
				if (l__7 == -1){
					l__7 = (caretIndex != -1) ? caretIndex : (p__1);
				}
				if (l__7 > l__8){
					l__8 = l__7;
					l__7 = p__1;
				}
				l__5 = l__7;
				while(l__5 <= l__8){
					l__6.AS3::push(l__5);
					l__5++;
				}
				selectedIndices = l__6;
				caretIndex = p__1;
				l__4 = true;
			} else {
				selectedIndex = p__1;
				caretIndex = lastCaretIndex = p__1;
				l__4 = true;
			}
			if (l__4){
				dispatchEvent(new flash.events.Event(flash.events.Event.CHANGE));
			}
			invalidate(fl.core.InvalidationType.DATA);
		}
		override public function itemToLabel(p__1:Object):String
		{
			if (_labelFunction != null){
				return(String(_labelFunction(p__1)));
			}
			return(((p__1[_labelField]) != null) ? String(p__1[_labelField]) : "");
		}
		override protected function initializeAccessibility():void
		{
			if (fl.controls.List.createAccessibilityImplementation != null){
				fl.controls.List.createAccessibilityImplementation(this);
			}
		}
		public static function getStyleDefinition():Object
		{
			return(mergeStyles(defaultStyles, fl.controls.SelectableList.getStyleDefinition()));
		}
	}
}