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
	import fl.events.*;
	import flash.utils.*;
	import fl.containers.*;
	import flash.ui.*;
	public class SelectableList extends fl.containers.BaseScrollPane implements IFocusManagerComponent
	{
		protected var invalidItems:flash.utils.Dictionary;
		protected var renderedItems:flash.utils.Dictionary;
		protected var listHolder:flash.display.Sprite;
		protected var _allowMultipleSelection:Boolean = false;
		protected var lastCaretIndex:int = -1;
		protected var _selectedIndices:Array;
		protected var availableCellRenderers:Array;
		protected var list:flash.display.Sprite;
		protected var caretIndex:int = -1;
		protected var updatedRendererStyles:Object;
		protected var preChangeItems:Array;
		protected var activeCellRenderers:Array;
		protected var rendererStyles:Object;
		protected var _verticalScrollPosition:Number;
		protected var _dataProvider:fl.data.DataProvider;
		protected var _horizontalScrollPosition:Number;
		private var collectionItemImport:fl.data.SimpleCollectionItem;
		protected var _selectable:Boolean = true;
		public static var createAccessibilityImplementation:Function;
		private static var defaultStyles:Object = {skin:"List_skin", cellRenderer:fl.controls.listClasses.CellRenderer, contentPadding:null, disabledAlpha:null};
		public function SelectableList()
		{
			activeCellRenderers = [];
			availableCellRenderers = [];
			invalidItems = new flash.utils.Dictionary(true);
			renderedItems = new flash.utils.Dictionary(true);
			_selectedIndices = [];
			if (dataProvider == null){
				dataProvider = new fl.data.DataProvider();
			}
			verticalScrollPolicy = fl.controls.ScrollPolicy.AUTO;
			rendererStyles = {};
			updatedRendererStyles = {};
		}
		override public function set enabled(p__1:Boolean):void
		{
			super.enabled = p__1;
			list.mouseChildren = _enabled;
		}
		public function get dataProvider():fl.data.DataProvider
		{
			return(_dataProvider);
		}
		public function set dataProvider(p__1:fl.data.DataProvider):void
		{
			if (_dataProvider != null){
				_dataProvider.removeEventListener(fl.events.DataChangeEvent.DATA_CHANGE, handleDataChange);
				_dataProvider.removeEventListener(fl.events.DataChangeEvent.PRE_DATA_CHANGE, onPreChange);
			}
			_dataProvider = p__1;
			_dataProvider.addEventListener(fl.events.DataChangeEvent.DATA_CHANGE, handleDataChange, false, 0, true);
			_dataProvider.addEventListener(fl.events.DataChangeEvent.PRE_DATA_CHANGE, onPreChange, false, 0, true);
			clearSelection();
			invalidateList();
		}
		override public function get maxHorizontalScrollPosition():Number
		{
			return(_maxHorizontalScrollPosition);
		}
		public function set maxHorizontalScrollPosition(p__1:Number):void
		{
			_maxHorizontalScrollPosition = p__1;
			invalidate(fl.core.InvalidationType.SIZE);
		}
		public function get length():uint
		{
			return(_dataProvider.length);
		}
		public function get allowMultipleSelection():Boolean
		{
			return(_allowMultipleSelection);
		}
		public function set allowMultipleSelection(p__1:Boolean):void
		{
			if (p__1 == _allowMultipleSelection){
				return;
			}
			_allowMultipleSelection = p__1;
			if ((!p__1) && (_selectedIndices.length > 1)){
				_selectedIndices = [_selectedIndices.AS3::pop()];
				invalidate(fl.core.InvalidationType.DATA);
			}
		}
		public function get selectable():Boolean
		{
			return(_selectable);
		}
		public function set selectable(p__1:Boolean):void
		{
			if (p__1 == _selectable){
				return;
			}
			if (!p__1){
				selectedIndices = [];
			}
			_selectable = p__1;
		}
		public function get selectedIndex():int
		{
			return((_selectedIndices.length == 0) ? -1 : _selectedIndices[_selectedIndices.length - 1]);
		}
		public function set selectedIndex(p__1:int):void
		{
			selectedIndices = (p__1 == -1) ? null : [p__1];
		}
		public function get selectedIndices():Array
		{
			return(_selectedIndices.AS3::concat());
		}
		public function set selectedIndices(p__1:Array):void
		{
			if (!_selectable){
				return;
			}
			_selectedIndices = (p__1 == null) ? [] : p__1.AS3::concat();
			invalidate(fl.core.InvalidationType.SELECTED);
		}
		public function get selectedItem():Object
		{
			return((_selectedIndices.length == 0) ? null : _dataProvider.getItemAt(selectedIndex));
		}
		public function set selectedItem(p__1:Object):void
		{
			var l__2:int;
			l__2 = _dataProvider.getItemIndex(p__1);
			selectedIndex = l__2;
		}
		public function get selectedItems():Array
		{
			var l__1:Array;
			var l__2:uint;
			l__1 = [];
			l__2 = 0;
			while(l__2 < _selectedIndices.length){
				l__1.AS3::push(_dataProvider.getItemAt(_selectedIndices[l__2]));
				l__2++;
			}
			return(l__1);
		}
		public function set selectedItems(p__1:Array):void
		{
			var l__2:Array;
			var l__3:uint;
			var l__4:int;
			if (p__1 == null){
				selectedIndices = null;
				return;
			}
			l__2 = [];
			l__3 = 0;
			while(l__3 < p__1.length){
				l__4 = _dataProvider.getItemIndex(p__1[l__3]);
				if (l__4 != -1){
					l__2.AS3::push(l__4);
				}
				l__3++;
			}
			selectedIndices = l__2;
		}
		public function get rowCount():uint
		{
			return(0);
		}
		public function clearSelection():void
		{
			selectedIndex = -1;
		}
		public function itemToCellRenderer(p__1:Object):fl.controls.listClasses.ICellRenderer
		{
			var l__2:* = undefined;
			var l__3:fl.controls.listClasses.ICellRenderer;
			if (p__1 != null){
				for (l__2 in activeCellRenderers){
					l__3 = (activeCellRenderers[l__2] as fl.controls.listClasses.ICellRenderer);
					if (l__3.data == p__1){
						return(l__3);
					}
				}
			}
			return(null);
		}
		public function addItem(p__1:Object):void
		{
			_dataProvider.addItem(p__1);
			invalidateList();
		}
		public function addItemAt(p__1:Object, p__2:uint):void
		{
			_dataProvider.addItemAt(p__1, p__2);
			invalidateList();
		}
		public function removeAll():void
		{
			_dataProvider.removeAll();
		}
		public function getItemAt(p__1:uint):Object
		{
			return(_dataProvider.getItemAt(p__1));
		}
		public function removeItem(p__1:Object):Object
		{
			return(_dataProvider.removeItem(p__1));
		}
		public function removeItemAt(p__1:uint):Object
		{
			return(_dataProvider.removeItemAt(p__1));
		}
		public function replaceItemAt(p__1:Object, p__2:uint):Object
		{
			return(_dataProvider.replaceItemAt(p__1, p__2));
		}
		public function invalidateList():void
		{
			_invalidateList();
			invalidate(fl.core.InvalidationType.DATA);
		}
		public function invalidateItem(p__1:Object):void
		{
			if (renderedItems[p__1] == null){
				return;
			}
			invalidItems[p__1] = true;
			invalidate(fl.core.InvalidationType.DATA);
		}
		public function invalidateItemAt(p__1:uint):void
		{
			var l__2:Object;
			l__2 = _dataProvider.getItemAt(p__1);
			if (l__2 != null){
				invalidateItem(l__2);
			}
		}
		public function sortItems(... p__1)
		{
			return(_dataProvider.sort.AS3::apply(_dataProvider, p__1));
		}
		public function sortItemsOn(p__1:String, p__2:Object = null)
		{
			return(_dataProvider.sortOn(p__1, p__2));
		}
		public function isItemSelected(p__1:Object):Boolean
		{
			return(selectedItems.AS3::indexOf(p__1) > -1);
		}
		public function scrollToSelected():void
		{
			scrollToIndex(selectedIndex);
		}
		public function scrollToIndex(p__1:int):void
		{
		}
		public function getNextIndexAtLetter(p__1:String, p__2:int = -1):int
		{
			var l__3:int;
			var l__4:Number;
			var l__5:Number;
			var l__6:Object;
			var l__7:String;
			if (length == 0){
				return(-1);
			}
			p__1 = p__1.AS3::toUpperCase();
			l__3 = length - 1;
			l__4 = 0;
			while(l__4 < l__3){
				l__5 = ((p__2 + 1) + l__4);
				if (l__5 > (length - 1)){
					l__5 = (l__5 - length);
				}
				l__6 = getItemAt(l__5);
				if (l__6 == null){
					break;
				}
				l__7 = itemToLabel(l__6);
				if (l__7 == null){
				} else if (l__7.AS3::charAt(0).AS3::toUpperCase() == p__1){
					return(l__5);
				}
				l__4++;
			}
			return(-1);
		}
		public function itemToLabel(p__1:Object):String
		{
			return(p__1["label"]);
		}
		public function setRendererStyle(p__1:String, p__2:Object, p__3:uint = 0):void
		{
			if (rendererStyles[p__1] == p__2){
				return;
			}
			updatedRendererStyles[p__1] = p__2;
			rendererStyles[p__1] = p__2;
			invalidate(fl.core.InvalidationType.RENDERER_STYLES);
		}
		public function getRendererStyle(p__1:String, p__2:int = -1):Object
		{
			return(rendererStyles[p__1]);
		}
		public function clearRendererStyle(p__1:String, p__2:int = -1):void
		{
			delete rendererStyles[p__1];
			updatedRendererStyles[p__1] = null;
			invalidate(fl.core.InvalidationType.RENDERER_STYLES);
		}
		override protected function configUI():void
		{
			super.configUI();
			listHolder = new flash.display.Sprite();
			addChild(listHolder);
			listHolder.scrollRect = contentScrollRect;
			list = new flash.display.Sprite();
			listHolder.addChild(list);
		}
		protected function _invalidateList():void
		{
			availableCellRenderers = [];
			while(activeCellRenderers.length > 0){
				list.removeChild(activeCellRenderers.AS3::pop() as flash.display.DisplayObject);
			}
		}
		protected function handleDataChange(p__1:fl.events.DataChangeEvent):void
		{
			var l__2:int;
			var l__3:int;
			var l__4:String;
			var l__5:uint;
			l__2 = p__1.startIndex;
			l__3 = p__1.endIndex;
			l__4 = p__1.changeType;
			if (l__4 == fl.events.DataChangeType.INVALIDATE_ALL){
				clearSelection();
				invalidateList();
			} else if (l__4 == fl.events.DataChangeType.INVALIDATE){
				l__5 = 0;
				while(l__5 < p__1.items.length){
					invalidateItem(p__1.items[l__5]);
					l__5++;
				}
			} else if (l__4 == fl.events.DataChangeType.ADD){
				l__5 = 0;
				while(l__5 < _selectedIndices.length){
					if (_selectedIndices[l__5] >= l__2){
						_selectedIndices[l__5] = (_selectedIndices[l__5] + (l__2 - l__3));
					}
					l__5++;
				}
			} else if (l__4 == fl.events.DataChangeType.REMOVE){
				l__5 = 0;
				while(l__5 < _selectedIndices.length){
					if (_selectedIndices[l__5] >= l__2){
						if (_selectedIndices[l__5] <= l__3){
							delete _selectedIndices[l__5];
						} else {
							_selectedIndices[l__5] = (_selectedIndices[l__5] - ((l__2 - l__3) + 1));
						}
					}
					l__5++;
				}
			} else if (l__4 == fl.events.DataChangeType.REMOVE_ALL){
				clearSelection();
			} else if (l__4 == fl.events.DataChangeType.REPLACE){
			} else {
				selectedItems = preChangeItems;
				preChangeItems = null;
			}
			invalidate(fl.core.InvalidationType.DATA);
		}
		protected function handleCellRendererMouseEvent(p__1:flash.events.MouseEvent):void
		{
			var l__2:fl.controls.listClasses.ICellRenderer;
			var l__3:String;
			l__2 = (p__1.target as fl.controls.listClasses.ICellRenderer);
			l__3 = (p__1.type == flash.events.MouseEvent.ROLL_OVER) ? fl.events.ListEvent.ITEM_ROLL_OVER : fl.events.ListEvent.ITEM_ROLL_OUT;
			dispatchEvent(new fl.events.ListEvent(l__3, false, false, l__2.listData.column, l__2.listData.row, l__2.listData.index, l__2.data));
		}
		protected function handleCellRendererClick(p__1:flash.events.MouseEvent):void
		{
			var l__2:fl.controls.listClasses.ICellRenderer;
			var l__3:uint;
			var l__4:int;
			var l__5:int;
			var l__6:uint;
			if (!_enabled){
				return;
			}
			l__2 = (p__1.currentTarget as fl.controls.listClasses.ICellRenderer);
			l__3 = l__2.listData.index;
			if ((!dispatchEvent(new fl.events.ListEvent(fl.events.ListEvent.ITEM_CLICK, false, true, l__2.listData.column, l__2.listData.row, l__3, l__2.data))) || (!_selectable)){
				return;
			}
			l__4 = selectedIndices.AS3::indexOf(l__3);
			if (!_allowMultipleSelection){
				if (l__4 != -1){
					return;
				}
				l__2.selected = true;
				_selectedIndices = [l__3];
				lastCaretIndex = caretIndex = l__3;
			} else if (p__1.shiftKey){
				l__6 = (_selectedIndices.length > 0) ? _selectedIndices[0] : l__3;
				_selectedIndices = [];
				if (l__6 > l__3){
					l__5 = l__6;
					while(l__5 >= l__3){
						_selectedIndices.AS3::push(l__5);
						l__5--;
					}
				} else {
					l__5 = l__6;
					while(l__5 <= l__3){
						_selectedIndices.AS3::push(l__5);
						l__5++;
					}
				}
				caretIndex = l__3;
			} else if (p__1.ctrlKey){
				if (l__4 != -1){
					l__2.selected = false;
					_selectedIndices.AS3::splice(l__4, 1);
				} else {
					l__2.selected = true;
					_selectedIndices.AS3::push(l__3);
				}
				caretIndex = l__3;
			} else {
				_selectedIndices = [l__3];
				lastCaretIndex = caretIndex = l__3;
			}
			dispatchEvent(new flash.events.Event(flash.events.Event.CHANGE));
			invalidate(fl.core.InvalidationType.DATA);
		}
		protected function handleCellRendererChange(p__1:flash.events.Event):void
		{
			var l__2:fl.controls.listClasses.ICellRenderer;
			var l__3:uint;
			l__2 = (p__1.currentTarget as fl.controls.listClasses.ICellRenderer);
			l__3 = l__2.listData.index;
			_dataProvider.invalidateItemAt(l__3);
		}
		protected function handleCellRendererDoubleClick(p__1:flash.events.MouseEvent):void
		{
			var l__2:fl.controls.listClasses.ICellRenderer;
			var l__3:uint;
			if (!_enabled){
				return;
			}
			l__2 = (p__1.currentTarget as fl.controls.listClasses.ICellRenderer);
			l__3 = l__2.listData.index;
			dispatchEvent(new fl.events.ListEvent(fl.events.ListEvent.ITEM_DOUBLE_CLICK, false, true, l__2.listData.column, l__2.listData.row, l__3, l__2.data));
		}
		override protected function setHorizontalScrollPosition(p__1:Number, p__2:Boolean = false):void
		{
			var l__3:Number;
			if (p__1 == _horizontalScrollPosition){
				return;
			}
			l__3 = (p__1 - _horizontalScrollPosition);
			_horizontalScrollPosition = p__1;
			if (p__2){
				dispatchEvent(new fl.events.ScrollEvent(fl.controls.ScrollBarDirection.HORIZONTAL, l__3, p__1));
			}
		}
		override protected function setVerticalScrollPosition(p__1:Number, p__2:Boolean = false):void
		{
			var l__3:Number;
			if (p__1 == _verticalScrollPosition){
				return;
			}
			l__3 = (p__1 - _verticalScrollPosition);
			_verticalScrollPosition = p__1;
			if (p__2){
				dispatchEvent(new fl.events.ScrollEvent(fl.controls.ScrollBarDirection.VERTICAL, l__3, p__1));
			}
		}
		override protected function draw():void
		{
			super.draw();
		}
		override protected function drawLayout():void
		{
			super.drawLayout();
			contentScrollRect = listHolder.scrollRect;
			contentScrollRect.width = availableWidth;
			contentScrollRect.height = availableHeight;
			listHolder.scrollRect = contentScrollRect;
		}
		protected function updateRendererStyles():void
		{
			var l__1:Array;
			var l__2:uint;
			var l__3:uint;
			var l__4:String;
			l__1 = availableCellRenderers.AS3::concat(activeCellRenderers);
			l__2 = l__1.length;
			l__3 = 0;
			while(l__3 < l__2){
				if (l__1[l__3].setStyle == null){
				} else {
					for (l__4 in updatedRendererStyles){
						l__1[l__3].setStyle(l__4, updatedRendererStyles[l__4]);
					}
					l__1[l__3].drawNow();
				}
				l__3++;
			}
			updatedRendererStyles = {};
		}
		protected function drawList():void
		{
		}
		override protected function keyDownHandler(p__1:flash.events.KeyboardEvent):void
		{
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
					moveSelectionVertically(p__1.keyCode, p__1.shiftKey && _allowMultipleSelection, p__1.ctrlKey && _allowMultipleSelection);
					p__1.stopPropagation();
					break;
				}
				case flash.ui.Keyboard.LEFT:
				{
				}
				case flash.ui.Keyboard.RIGHT:
				{
					moveSelectionHorizontally(p__1.keyCode, p__1.shiftKey && _allowMultipleSelection, p__1.ctrlKey && _allowMultipleSelection);
					p__1.stopPropagation();
					break;
				}
			}
		}
		protected function moveSelectionHorizontally(p__1:uint, p__2:Boolean, p__3:Boolean):void
		{
		}
		protected function moveSelectionVertically(p__1:uint, p__2:Boolean, p__3:Boolean):void
		{
		}
		override protected function initializeAccessibility():void
		{
			if (fl.controls.SelectableList.createAccessibilityImplementation != null){
				fl.controls.SelectableList.createAccessibilityImplementation(this);
			}
		}
		protected function onPreChange(p__1:fl.events.DataChangeEvent):void
		{
			switch(p__1.changeType){
				case fl.events.DataChangeType.REMOVE:
				{
				}
				case fl.events.DataChangeType.ADD:
				{
				}
				case fl.events.DataChangeType.INVALIDATE:
				{
				}
				case fl.events.DataChangeType.REMOVE_ALL:
				{
				}
				case fl.events.DataChangeType.REPLACE:
				{
				}
				case fl.events.DataChangeType.INVALIDATE_ALL:
				{
					break;
				}
				default:
				{
					preChangeItems = selectedItems;
					break;
				}
			}
		}
		public static function getStyleDefinition():Object
		{
			return(mergeStyles(defaultStyles, fl.containers.BaseScrollPane.getStyleDefinition()));
		}
	}
}