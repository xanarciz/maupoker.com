// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package fl.controls
{
	import fl.data.*;
	import fl.controls.listClasses.*;
	import fl.core.*;
	import flash.display.*;
	import flash.events.*;
	import fl.managers.*;
	import flash.utils.*;
	import fl.containers.*;
	import flash.ui.*;
	public class TileList extends fl.controls.SelectableList implements IFocusManagerComponent
	{
		protected var _labelField:String = "label";
		protected var _scrollPolicy:String = "auto";
		protected var _labelFunction:Function;
		protected var _scrollDirection:String = "horizontal";
		protected var _iconFunction:Function;
		private var collectionItemImport:fl.data.TileListCollectionItem;
		protected var _rowHeight:Number = 50;
		protected var _cellRenderer:Object;
		protected var _columnWidth:Number = 50;
		protected var _iconField:String = "icon";
		protected var _sourceFunction:Function;
		protected var __rowCount:uint = 0;
		protected var __columnCount:uint = 0;
		protected var _sourceField:String = "source";
		protected var oldLength:uint = 0;
		public static var createAccessibilityImplementation:Function;
		private static var defaultStyles:Object = {cellRenderer:fl.controls.listClasses.ImageCell, focusRectSkin:null, focusRectPadding:null, skin:"TileList_skin"};
		public function TileList()
		{
		}
		override public function get dataProvider():fl.data.DataProvider
		{
			return(super.dataProvider);
		}
		override public function set dataProvider(p__1:fl.data.DataProvider):void
		{
			super.dataProvider = p__1;
		}
		public function get labelField():String
		{
			return(_labelField);
		}
		public function set labelField(p__1:String):void
		{
			if (p__1 == _labelField){
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
			if (_labelFunction == p__1){
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
			if (p__1 == _iconField){
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
			if (_iconFunction == p__1){
				return;
			}
			_iconFunction = p__1;
			invalidate(fl.core.InvalidationType.DATA);
		}
		public function get sourceField():String
		{
			return(_sourceField);
		}
		public function set sourceField(p__1:String):void
		{
			_sourceField = p__1;
			invalidate(fl.core.InvalidationType.DATA);
		}
		public function get sourceFunction():Function
		{
			return(_sourceFunction);
		}
		public function set sourceFunction(p__1:Function):void
		{
			_sourceFunction = p__1;
			invalidate(fl.core.InvalidationType.DATA);
		}
		override public function get rowCount():uint
		{
			var l__1:Number;
			var l__2:uint;
			var l__3:uint;
			l__1 = Number(getStyleValue("contentPadding"));
			l__2 = Math.max(1, (((_width - (2 * l__1)) / _columnWidth) << 0));
			l__3 = Math.max(1, (((_height - (2 * l__1)) / _rowHeight) << 0));
			if (_scrollDirection == fl.controls.ScrollBarDirection.HORIZONTAL){
				if ((_scrollPolicy == fl.controls.ScrollPolicy.ON) || ((_scrollPolicy == fl.controls.ScrollPolicy.AUTO) && (length > (l__2 * l__3)))){
					l__3 = Math.max(1, ((((_height - (2 * l__1)) - 15) / _rowHeight) << 0));
				}
			} else {
				l__3 = Math.max(1, Math.ceil((_height - (2 * l__1)) / _rowHeight));
			}
			return(l__3);
		}
		public function set rowCount(p__1:uint):void
		{
			var l__2:Number;
			var l__3:* = undefined;
			if (p__1 == 0){
				return;
			}
			if (componentInspectorSetting){
				__rowCount = p__1;
				return;
			}
			__rowCount = 0;
			l__2 = Number(getStyleValue("contentPadding"));
			l__3 = ((Math.ceil(length / p__1) > ((width / columnWidth) >> 0)) && (_scrollPolicy == fl.controls.ScrollPolicy.AUTO)) || (_scrollPolicy == fl.controls.ScrollPolicy.ON);
			height = ((rowHeight * p__1 + (2 * l__2)) + (((_scrollDirection == fl.controls.ScrollBarDirection.HORIZONTAL) && l__3) ? fl.controls.ScrollBar.WIDTH : 0));
		}
		public function get rowHeight():Number
		{
			return(_rowHeight);
		}
		public function set rowHeight(p__1:Number):void
		{
			if (_rowHeight == p__1){
				return;
			}
			_rowHeight = p__1;
			invalidate(fl.core.InvalidationType.SIZE);
		}
		public function get columnCount():uint
		{
			var l__1:Number;
			var l__2:uint;
			var l__3:uint;
			l__1 = Number(getStyleValue("contentPadding"));
			l__2 = Math.max(1, (((_width - (2 * l__1)) / _columnWidth) << 0));
			l__3 = Math.max(1, (((_height - (2 * l__1)) / _rowHeight) << 0));
			if (_scrollDirection != fl.controls.ScrollBarDirection.HORIZONTAL){
				if ((_scrollPolicy == fl.controls.ScrollPolicy.ON) || ((_scrollPolicy == fl.controls.ScrollPolicy.AUTO) && (length > (l__2 * l__3)))){
					l__2 = Math.max(1, ((((_width - (2 * l__1)) - 15) / _columnWidth) << 0));
				}
			} else {
				l__2 = Math.max(1, Math.ceil((_width - (2 * l__1)) / _columnWidth));
			}
			return(l__2);
		}
		public function set columnCount(p__1:uint):void
		{
			var l__2:Number;
			var l__3:Boolean;
			if (p__1 == 0){
				return;
			}
			if (componentInspectorSetting){
				__columnCount = p__1;
				return;
			}
			__columnCount = 0;
			l__2 = Number(getStyleValue("contentPadding"));
			l__3 = ((Math.ceil(length / p__1) > ((height / rowHeight) >> 0)) && (_scrollPolicy == fl.controls.ScrollPolicy.AUTO)) || (_scrollPolicy == fl.controls.ScrollPolicy.ON);
			width = ((columnWidth * p__1 + (2 * l__2)) + (((_scrollDirection == fl.controls.ScrollBarDirection.VERTICAL) && l__3) ? 15 : 0));
		}
		public function get columnWidth():Number
		{
			return(_columnWidth);
		}
		public function set columnWidth(p__1:Number):void
		{
			if (_columnWidth == p__1){
				return;
			}
			_columnWidth = p__1;
			invalidate(fl.core.InvalidationType.SIZE);
		}
		public function get innerWidth():Number
		{
			var l__1:Number;
			drawNow();
			l__1 = (getStyleValue("contentPadding") as Number);
			return((width - (l__1 * 2)) - (_verticalScrollBar.visible ? _verticalScrollBar.width : 0));
		}
		public function get innerHeight():Number
		{
			var l__1:Number;
			drawNow();
			l__1 = (getStyleValue("contentPadding") as Number);
			return((height - (l__1 * 2)) - (_horizontalScrollBar.visible ? _horizontalScrollBar.height : 0));
		}
		public function get direction():String
		{
			return(_scrollDirection);
		}
		public function set direction(p__1:String):void
		{
			if (_scrollDirection == p__1){
				return;
			}
			_scrollDirection = p__1;
			invalidate(fl.core.InvalidationType.SIZE);
		}
		public function get scrollPolicy():String
		{
			return(_scrollPolicy);
		}
		public function set scrollPolicy(p__1:String):void
		{
			if ((!componentInspectorSetting) && (_scrollPolicy == p__1)){
				return;
			}
			_scrollPolicy = p__1;
			if (direction == fl.controls.ScrollBarDirection.HORIZONTAL){
				_horizontalScrollPolicy = p__1;
				_verticalScrollPolicy = fl.controls.ScrollPolicy.OFF;
			} else {
				_verticalScrollPolicy = p__1;
				_horizontalScrollPolicy = fl.controls.ScrollPolicy.OFF;
			}
			invalidate(fl.core.InvalidationType.SIZE);
		}
		override public function scrollToIndex(p__1:int):void
		{
			var l__2:uint;
			var l__3:Number;
			var l__4:Number;
			drawNow();
			l__2 = Math.max(1, ((contentWidth / _columnWidth) << 0));
			if (_scrollDirection == fl.controls.ScrollBarDirection.VERTICAL){
				if (rowHeight > availableHeight){
					return;
				}
				l__3 = ((p__1 / l__2) >> 0) * rowHeight;
				if (l__3 < verticalScrollPosition){
					verticalScrollPosition = l__3;
				} else if (l__3 > ((verticalScrollPosition + availableHeight) - rowHeight)){
					verticalScrollPosition = ((l__3 + rowHeight) - availableHeight);
				}
			} else {
				if (columnWidth > availableWidth){
					return;
				}
				l__4 = (p__1 % l__2) * columnWidth;
				if (l__4 < horizontalScrollPosition){
					horizontalScrollPosition = l__4;
				} else if (l__4 > ((horizontalScrollPosition + availableWidth) - columnWidth)){
					horizontalScrollPosition = ((l__4 + columnWidth) - availableWidth);
				}
			}
		}
		override public function itemToLabel(p__1:Object):String
		{
			if (_labelFunction != null){
				return(String(_labelFunction(p__1)));
			}
			if (p__1[_labelField] == null){
				return("");
			}
			return(String(p__1[_labelField]));
		}
		override public function get verticalScrollPolicy():String
		{
			return(null);
		}
		override public function set verticalScrollPolicy(p__1:String):void
		{
		}
		override public function get horizontalScrollPolicy():String
		{
			return(null);
		}
		override public function set horizontalScrollPolicy(p__1:String):void
		{
		}
		override public function get maxHorizontalScrollPosition():Number
		{
			drawNow();
			return(_maxHorizontalScrollPosition);
		}
		override public function set maxHorizontalScrollPosition(p__1:Number):void
		{
		}
		override protected function configUI():void
		{
			super.configUI();
			_horizontalScrollPolicy = scrollPolicy;
			_verticalScrollPolicy = fl.controls.ScrollPolicy.OFF;
		}
		override protected function setHorizontalScrollPosition(p__1:Number, p__2:Boolean = false):void
		{
			invalidate(fl.core.InvalidationType.SCROLL);
			super.setHorizontalScrollPosition(p__1, true);
		}
		override protected function setVerticalScrollPosition(p__1:Number, p__2:Boolean = false):void
		{
			invalidate(fl.core.InvalidationType.SCROLL);
			super.setVerticalScrollPosition(p__1, true);
		}
		override protected function draw():void
		{
			var l__1:Boolean;
			if (direction == fl.controls.ScrollBarDirection.VERTICAL){
				if (__rowCount > 0){
					rowCount = __rowCount;
				}
				if (__columnCount > 0){
					columnCount = __columnCount;
				}
			} else {
				if (__columnCount > 0){
					columnCount = __columnCount;
				}
				if (__rowCount > 0){
					rowCount = __rowCount;
				}
			}
			l__1 = !(oldLength == length);
			oldLength = length;
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
				_maxHorizontalScrollPosition = Math.max(0, (contentWidth - availableWidth));
			}
			updateChildren();
			validate();
		}
		override protected function drawLayout():void
		{
			var l__1:uint;
			var l__2:uint;
			_horizontalScrollPolicy = (_scrollDirection == fl.controls.ScrollBarDirection.HORIZONTAL) ? _scrollPolicy : fl.controls.ScrollPolicy.OFF;
			_verticalScrollPolicy = (_scrollDirection != fl.controls.ScrollBarDirection.HORIZONTAL) ? _scrollPolicy : fl.controls.ScrollPolicy.OFF;
			if (_scrollDirection == fl.controls.ScrollBarDirection.HORIZONTAL){
				l__1 = rowCount;
				contentHeight = l__1 * _rowHeight;
				contentWidth = _columnWidth * Math.ceil(length / l__1);
			} else {
				l__2 = columnCount;
				contentWidth = l__2 * _columnWidth;
				contentHeight = _rowHeight * Math.ceil(length / l__2);
			}
			super.drawLayout();
		}
		override protected function drawList():void
		{
			var l__1:uint;
			var l__2:uint;
			var l__3:Object;
			var l__4:fl.controls.listClasses.ICellRenderer;
			var l__5:uint;
			var l__6:uint;
			var l__7:Number;
			var l__8:Number;
			var l__9:Number;
			var l__10:Number;
			var l__11:uint;
			var l__12:uint;
			var l__13:Array;
			var l__14:flash.utils.Dictionary;
			var l__15:flash.utils.Dictionary;
			var l__16:uint;
			var l__17:uint;
			var l__18:uint;
			var l__19:uint;
			var l__20:Boolean;
			var l__21:String;
			var l__22:Object;
			var l__23:Object;
			var l__24:flash.display.Sprite;
			var l__25:String;
			var l__26:fl.core.UIComponent;
			l__5 = rowCount;
			l__6 = columnCount;
			l__7 = columnWidth;
			l__8 = rowHeight;
			l__9 = 0;
			l__10 = 0;
			listHolder.x = listHolder.y = contentPadding;
			contentScrollRect = listHolder.scrollRect;
			contentScrollRect.x = (Math.floor(_horizontalScrollPosition) % l__7);
			contentScrollRect.y = (Math.floor(_verticalScrollPosition) % l__8);
			listHolder.scrollRect = contentScrollRect;
			listHolder.cacheAsBitmap = useBitmapScrolling;
			l__13 = [];
			if (_scrollDirection == fl.controls.ScrollBarDirection.HORIZONTAL){
				l__16 = ((availableWidth / l__7) << 0);
				l__17 = Math.max(l__16, Math.ceil(length / l__5));
				l__9 = ((_horizontalScrollPosition / l__7) << 0);
				l__6 = Math.max(l__16, Math.min((l__17 - l__9), (l__6 + 1)));
				l__12 = 0;
				while(l__12 < l__5){
					l__11 = 0;
					while(l__11 < l__6){
						l__2 = ((l__12 * l__17 + l__9) + l__11);
						if (l__2 >= length){
							break;
						}
						l__13.AS3::push(l__2);
						l__11++;
					}
					l__12++;
				}
			} else {
				l__5++;
				l__10 = ((_verticalScrollPosition / l__8) << 0);
				l__18 = Math.floor(l__10 * l__6);
				l__19 = Math.min(length, (l__18 + (l__5 * l__6)));
				l__1 = l__18;
				while(l__1 < l__19){
					l__13.AS3::push(l__1);
					l__1++;
				}
			}
			l__14 = renderedItems = new flash.utils.Dictionary(true);
			for each (l__2 in l__13){
				l__14[_dataProvider.getItemAt(l__2)] = true;
			}
			l__15 = new flash.utils.Dictionary(true);
			while(activeCellRenderers.length > 0){
				l__4 = activeCellRenderers.AS3::pop();
				l__3 = l__4.data;
				if ((l__14[l__3] == null) || (invalidItems[l__3] == true)){
					availableCellRenderers.AS3::push(l__4);
				} else {
					l__15[l__3] = l__4;
					invalidItems[l__3] = true;
				}
				list.removeChild(l__4 as flash.display.DisplayObject);
			}
			invalidItems = new flash.utils.Dictionary(true);
			l__1 = 0;
			for each (l__2 in l__13){
				l__11 = (l__1 % l__6);
				l__12 = ((l__1 / l__6) << 0);
				l__20 = false;
				l__3 = _dataProvider.getItemAt(l__2);
				if (l__15[l__3] != null){
					l__20 = true;
					l__4 = l__15[l__3];
					delete l__15[l__3];
				} else if (availableCellRenderers.length > 0){
					l__4 = (availableCellRenderers.AS3::pop() as fl.controls.listClasses.ICellRenderer);
				} else if ((l__24 = ((l__4 = (getDisplayObjectInstance(getStyleValue("cellRenderer")) as fl.controls.listClasses.ICellRenderer)) as flash.display.Sprite)) != null){
					l__24.addEventListener(flash.events.MouseEvent.CLICK, handleCellRendererClick, false, 0, true);
					l__24.addEventListener(flash.events.MouseEvent.ROLL_OVER, handleCellRendererMouseEvent, false, 0, true);
					l__24.addEventListener(flash.events.MouseEvent.ROLL_OUT, handleCellRendererMouseEvent, false, 0, true);
					l__24.addEventListener(flash.events.Event.CHANGE, handleCellRendererChange, false, 0, true);
					l__24.doubleClickEnabled = true;
					l__24.addEventListener(flash.events.MouseEvent.DOUBLE_CLICK, handleCellRendererDoubleClick, false, 0, true);
					if (l__24["setStyle"] != null){
						for (l__25 in rendererStyles){
							l__24["setStyle"](l__25, rendererStyles[l__25]);
						}
					}
				}
				list.addChild(l__4 as flash.display.Sprite);
				activeCellRenderers.AS3::push(l__4);
				l__4.y = l__8 * l__12;
				l__4.x = l__7 * l__11;
				l__4.setSize(columnWidth, rowHeight);
				l__21 = itemToLabel(l__3);
				l__22 = null;
				if (_iconFunction != null){
					l__22 = _iconFunction(l__3);
				} else if (_iconField != null){
					l__22 = l__3[_iconField];
				}
				l__23 = null;
				if (_sourceFunction != null){
					l__23 = _sourceFunction(l__3);
				} else if (_sourceField != null){
					l__23 = l__3[_sourceField];
				}
				if (!l__20){
					l__4.data = l__3;
				}
				l__4.listData = ((new fl.controls.listClasses.TileListData(l__21, l__22, l__23, this, l__2, (l__10 + l__12), (l__9 + l__11))) as fl.controls.listClasses.ListData);
				l__4.selected = !(_selectedIndices.AS3::indexOf(l__2) == -1);
				if (l__4 is fl.core.UIComponent){
					l__26 = (l__4 as fl.core.UIComponent);
					l__26.drawNow();
				}
				l__1++;
			}
		}
		override protected function keyDownHandler(p__1:flash.events.KeyboardEvent):void
		{
			var l__2:int;
			p__1.stopPropagation();
			if (!selectable){
				return;
			}
			switch(p__1.keyCode){
				case flash.ui.Keyboard.UP:
				{
				}
				case flash.ui.Keyboard.DOWN:
				{
					moveSelectionVertically(p__1.keyCode, p__1.shiftKey && _allowMultipleSelection, p__1.ctrlKey && _allowMultipleSelection);
					break;
				}
				case flash.ui.Keyboard.PAGE_UP:
				{
				}
				case flash.ui.Keyboard.PAGE_DOWN:
				{
				}
				case flash.ui.Keyboard.END:
				{
				}
				case flash.ui.Keyboard.HOME:
				{
					if (_scrollDirection == fl.controls.ScrollBarDirection.HORIZONTAL){
						moveSelectionHorizontally(p__1.keyCode, p__1.shiftKey && _allowMultipleSelection, p__1.ctrlKey && _allowMultipleSelection);
					} else {
						moveSelectionVertically(p__1.keyCode, p__1.shiftKey && _allowMultipleSelection, p__1.ctrlKey && _allowMultipleSelection);
					}
					break;
				}
				case flash.ui.Keyboard.LEFT:
				{
				}
				case flash.ui.Keyboard.RIGHT:
				{
					moveSelectionHorizontally(p__1.keyCode, p__1.shiftKey && _allowMultipleSelection, p__1.ctrlKey && _allowMultipleSelection);
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
		}
		protected function calculateAvailableHeight():Number
		{
			var l__1:Number;
			l__1 = Number(getStyleValue("contentPadding"));
			return((height - (l__1 * 2)) - (((_horizontalScrollPolicy == fl.controls.ScrollPolicy.ON) || ((_horizontalScrollPolicy == fl.controls.ScrollPolicy.AUTO) && (_maxHorizontalScrollPosition > 0))) ? 15 : 0));
		}
		override protected function moveSelectionVertically(p__1:uint, p__2:Boolean, p__3:Boolean):void
		{
			var l__4:uint;
			var l__5:uint;
			var l__6:uint;
			var l__7:int;
			var l__8:int;
			l__4 = Math.max(1, ((Math.max(contentHeight, availableHeight) / _rowHeight) << 0));
			l__5 = Math.ceil(Math.max(columnCount * rowCount, length) / l__4);
			l__6 = Math.ceil(length / l__5);
			switch(p__1){
				case flash.ui.Keyboard.UP:
				{
					l__7 = (selectedIndex - l__5);
					break;
				}
				case flash.ui.Keyboard.DOWN:
				{
					l__7 = (selectedIndex + l__5);
					break;
				}
				case flash.ui.Keyboard.HOME:
				{
					l__7 = 0;
					break;
				}
				case flash.ui.Keyboard.END:
				{
					l__7 = length - 1;
					break;
				}
				case flash.ui.Keyboard.PAGE_DOWN:
				{
					l__8 = (selectedIndex + (l__5 * (l__6 - 1)));
					if (l__8 >= length){
						l__8 = (l__8 - l__5);
					}
					l__7 = Math.min(length - 1, l__8);
					break;
				}
				case flash.ui.Keyboard.PAGE_UP:
				{
					l__8 = (selectedIndex - (l__5 * (l__6 - 1)));
					if (l__8 < 0){
						l__8 = (l__8 + l__5);
					}
					l__7 = Math.max(0, l__8);
					break;
				}
			}
			doKeySelection(l__7, p__2, p__3);
			scrollToSelected();
		}
		override protected function moveSelectionHorizontally(p__1:uint, p__2:Boolean, p__3:Boolean):void
		{
			var l__4:uint;
			var l__5:int;
			var l__6:int;
			var l__7:* = undefined;
			l__4 = Math.ceil(Math.max(rowCount * columnCount, length) / rowCount);
			switch(p__1){
				case flash.ui.Keyboard.LEFT:
				{
					l__5 = Math.max(0, selectedIndex - 1);
					break;
				}
				case flash.ui.Keyboard.RIGHT:
				{
					l__5 = Math.min(length - 1, (selectedIndex + 1));
					break;
				}
				case flash.ui.Keyboard.HOME:
				{
					l__5 = 0;
					break;
				}
				case flash.ui.Keyboard.END:
				{
					l__5 = length - 1;
					break;
				}
				case flash.ui.Keyboard.PAGE_UP:
				{
					l__6 = (selectedIndex - (selectedIndex % l__4));
					l__5 = Math.max(0, Math.max(l__6, (selectedIndex - columnCount)));
					break;
				}
				case flash.ui.Keyboard.PAGE_DOWN:
				{
					l__7 = ((selectedIndex - (selectedIndex % l__4)) + l__4) - 1;
					l__5 = Math.min(length - 1, Math.min(l__7, (selectedIndex + l__4)));
					break;
				}
			}
			doKeySelection(l__5, p__2, p__3);
			scrollToSelected();
		}
		protected function doKeySelection(p__1:uint, p__2:Boolean, p__3:Boolean):void
		{
			var l__4:Array;
			var l__5:Boolean;
			var l__6:uint;
			var l__7:int;
			l__4 = selectedIndices;
			l__5 = false;
			if ((p__1 < 0) || (p__1 > (length - 1))){
			} else if ((p__2 && (l__4.length > 0)) && !(p__1 == l__4[0])){
				l__6 = l__4[0];
				l__4 = [];
				if (p__1 < l__6){
					l__7 = l__6;
					while(l__7 >= p__1){
						l__4.AS3::push(l__7);
						l__7--;
					}
				} else {
					l__7 = l__6;
					while(l__7 <= p__1){
						l__4.AS3::push(l__7);
						l__7++;
					}
				}
				l__5 = true;
			} else {
				l__4 = [p__1];
				caretIndex = p__1;
				l__5 = true;
			}
			selectedIndices = l__4;
			if (l__5){
				dispatchEvent(new flash.events.Event(flash.events.Event.CHANGE));
			}
			invalidate(fl.core.InvalidationType.DATA);
		}
		override protected function initializeAccessibility():void
		{
			if (fl.controls.TileList.createAccessibilityImplementation != null){
				fl.controls.TileList.createAccessibilityImplementation(this);
			}
		}
		public static function getStyleDefinition():Object
		{
			return(mergeStyles(defaultStyles, fl.controls.SelectableList.getStyleDefinition(), fl.controls.ScrollBar.getStyleDefinition()));
		}
	}
}