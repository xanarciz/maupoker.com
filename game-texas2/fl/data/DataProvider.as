// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package fl.data
{
	import flash.events.*;
	import fl.events.*;
	public class DataProvider extends flash.events.EventDispatcher
	{
		protected var data:Array;
		public function DataProvider(p__1:Object = null)
		{
			if (p__1 == null){
				data = [];
			} else {
				data = getDataFromObject(p__1);
			}
		}
		public function get length():uint
		{
			return(data.length);
		}
		public function invalidateItemAt(p__1:int):void
		{
			checkIndex(p__1, data.length - 1);
			dispatchChangeEvent(fl.events.DataChangeType.INVALIDATE, [data[p__1]], p__1, p__1);
		}
		public function invalidateItem(p__1:Object):void
		{
			var l__2:uint;
			l__2 = getItemIndex(p__1);
			if (l__2 == -1){
				return;
			}
			invalidateItemAt(l__2);
		}
		public function invalidate():void
		{
			dispatchEvent(new fl.events.DataChangeEvent(fl.events.DataChangeEvent.DATA_CHANGE, fl.events.DataChangeType.INVALIDATE_ALL, data.AS3::concat(), 0, data.length));
		}
		public function addItemAt(p__1:Object, p__2:uint):void
		{
			checkIndex(p__2, data.length);
			dispatchPreChangeEvent(fl.events.DataChangeType.ADD, [p__1], p__2, p__2);
			data.AS3::splice(p__2, 0, p__1);
			dispatchChangeEvent(fl.events.DataChangeType.ADD, [p__1], p__2, p__2);
		}
		public function addItem(p__1:Object):void
		{
			dispatchPreChangeEvent(fl.events.DataChangeType.ADD, [p__1], data.length - 1, data.length - 1);
			data.AS3::push(p__1);
			dispatchChangeEvent(fl.events.DataChangeType.ADD, [p__1], data.length - 1, data.length - 1);
		}
		public function addItemsAt(p__1:Object, p__2:uint):void
		{
			var l__3:Array;
			checkIndex(p__2, data.length);
			l__3 = getDataFromObject(p__1);
			dispatchPreChangeEvent(fl.events.DataChangeType.ADD, l__3, p__2, (p__2 + l__3.length) - 1);
			data.AS3::splice.AS3::apply(data, [p__2, 0].AS3::concat(l__3));
			dispatchChangeEvent(fl.events.DataChangeType.ADD, l__3, p__2, (p__2 + l__3.length) - 1);
		}
		public function addItems(p__1:Object):void
		{
			addItemsAt(p__1, data.length);
		}
		public function concat(p__1:Object):void
		{
			addItems(p__1);
		}
		public function merge(p__1:Object):void
		{
			var l__2:Array;
			var l__3:uint;
			var l__4:uint;
			var l__5:uint;
			var l__6:Object;
			l__2 = getDataFromObject(p__1);
			l__3 = l__2.length;
			l__4 = data.length;
			dispatchPreChangeEvent(fl.events.DataChangeType.ADD, data.AS3::slice(l__4, data.length), l__4, this.data.length - 1);
			l__5 = 0;
			while(l__5 < l__3){
				l__6 = l__2[l__5];
				if (getItemIndex(l__6) == -1){
					data.AS3::push(l__6);
				}
				l__5++;
			}
			if (data.length > l__4){
				dispatchChangeEvent(fl.events.DataChangeType.ADD, data.AS3::slice(l__4, data.length), l__4, this.data.length - 1);
			} else {
				dispatchChangeEvent(fl.events.DataChangeType.ADD, [], -1, -1);
			}
		}
		public function getItemAt(p__1:uint):Object
		{
			checkIndex(p__1, data.length - 1);
			return(data[p__1]);
		}
		public function getItemIndex(p__1:Object):int
		{
			return(data.AS3::indexOf(p__1));
		}
		public function removeItemAt(p__1:uint):Object
		{
			var l__2:Array;
			checkIndex(p__1, data.length - 1);
			dispatchPreChangeEvent(fl.events.DataChangeType.REMOVE, data.AS3::slice(p__1, (p__1 + 1)), p__1, p__1);
			l__2 = data.AS3::splice(p__1, 1);
			dispatchChangeEvent(fl.events.DataChangeType.REMOVE, l__2, p__1, p__1);
			return(l__2[0]);
		}
		public function removeItem(p__1:Object):Object
		{
			var l__2:int;
			l__2 = getItemIndex(p__1);
			if (l__2 != -1){
				return(removeItemAt(l__2));
			}
			return(null);
		}
		public function removeAll():void
		{
			var l__1:Array;
			l__1 = data.AS3::concat();
			dispatchPreChangeEvent(fl.events.DataChangeType.REMOVE_ALL, l__1, 0, l__1.length);
			data = [];
			dispatchChangeEvent(fl.events.DataChangeType.REMOVE_ALL, l__1, 0, l__1.length);
		}
		public function replaceItem(p__1:Object, p__2:Object):Object
		{
			var l__3:int;
			l__3 = getItemIndex(p__2);
			if (l__3 != -1){
				return(replaceItemAt(p__1, l__3));
			}
			return(null);
		}
		public function replaceItemAt(p__1:Object, p__2:uint):Object
		{
			var l__3:Array;
			checkIndex(p__2, data.length - 1);
			l__3 = [data[p__2]];
			dispatchPreChangeEvent(fl.events.DataChangeType.REPLACE, l__3, p__2, p__2);
			data[p__2] = p__1;
			dispatchChangeEvent(fl.events.DataChangeType.REPLACE, l__3, p__2, p__2);
			return(l__3[0]);
		}
		public function sort(... p__1)
		{
			var l__2:Array;
			dispatchPreChangeEvent(fl.events.DataChangeType.SORT, data.AS3::concat(), 0, data.length - 1);
			l__2 = data.AS3::sort.AS3::apply(data, p__1);
			dispatchChangeEvent(fl.events.DataChangeType.SORT, data.AS3::concat(), 0, data.length - 1);
			return(l__2);
		}
		public function sortOn(p__1:Object, p__2:Object = null)
		{
			var l__3:Array;
			dispatchPreChangeEvent(fl.events.DataChangeType.SORT, data.AS3::concat(), 0, data.length - 1);
			l__3 = data.AS3::sortOn(p__1, p__2);
			dispatchChangeEvent(fl.events.DataChangeType.SORT, data.AS3::concat(), 0, data.length - 1);
			return(l__3);
		}
		public function clone():fl.data.DataProvider
		{
			return(new fl.data.DataProvider(data));
		}
		public function toArray():Array
		{
			return(data.AS3::concat());
		}
		override public function toString():String
		{
			return(("DataProvider [" + data.AS3::join(" , ")) + "]");
		}
		protected function getDataFromObject(p__1:Object):Array
		{
			var l__2:Array;
			var l__3:Array;
			var l__4:uint;
			var l__5:Object;
			var l__6:XML;
			var l__7:XMLList;
			var l__8:XML;
			var l__9:XMLList;
			var l__10:XML;
			var l__11:XMLList;
			var l__12:XML;
			if (p__1 is Array){
				l__3 = (p__1 as Array);
				if (l__3.length > 0){
					if ((l__3[0] is String) || (l__3[0] is Number)){
						l__2 = [];
						l__4 = 0;
						while(l__4 < l__3.length){
							l__5 = {label:String(l__3[l__4]), data:l__3[l__4]};
							l__2.AS3::push(l__5);
							l__4++;
						}
						return(l__2);
					}
				}
				return(p__1.concat());
			} else {
				if (p__1 is fl.data.DataProvider){
					return(p__1.toArray());
				}
				if (p__1 is XML){
					l__6 = (p__1 as XML);
					l__2 = [];
					l__7 = l__6.*;
					for each (l__8 in l__7){
						p__1 = {};
						l__9 = l__8.attributes();
						for each (l__10 in l__9){
							p__1[l__10.localName()] = l__10.toString();
						}
						l__11 = l__8.*;
						for each (l__12 in l__11){
							if (l__12.hasSimpleContent()){
								p__1[l__12.localName()] = l__12.toString();
							}
						}
						l__2.AS3::push(p__1);
					}
					return(l__2);
				}
			}
			throw new TypeError(("Error: Type Coercion failed: cannot convert " + p__1) + " to Array or DataProvider.");
		}
		protected function checkIndex(p__1:int, p__2:int):void
		{
			if ((p__1 > p__2) || (p__1 < 0)){
				throw new RangeError(((("DataProvider index (" + p__1) + ") is not in acceptable range (0 - ") + p__2) + ")");
			}
		}
		protected function dispatchChangeEvent(p__1:String, p__2:Array, p__3:int, p__4:int):void
		{
			dispatchEvent(new fl.events.DataChangeEvent(fl.events.DataChangeEvent.DATA_CHANGE, p__1, p__2, p__3, p__4));
		}
		protected function dispatchPreChangeEvent(p__1:String, p__2:Array, p__3:int, p__4:int):void
		{
			dispatchEvent(new fl.events.DataChangeEvent(fl.events.DataChangeEvent.PRE_DATA_CHANGE, p__1, p__2, p__3, p__4));
		}
	}
}