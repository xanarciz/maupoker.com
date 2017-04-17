// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package fl.managers
{
	import fl.core.*;
	import fl.controls.*;
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.text.*;
	import flash.ui.*;
	public class FocusManager implements IFocusManager
	{
		private var focusableObjects:flash.utils.Dictionary;
		private var _showFocusIndicator:Boolean = true;
		private var defButton:fl.controls.Button;
		private var focusableCandidates:Array;
		private var _form:flash.display.DisplayObjectContainer;
		private var _defaultButtonEnabled:Boolean = true;
		private var activated:Boolean = false;
		private var _defaultButton:fl.controls.Button;
		private var calculateCandidates:Boolean = true;
		private var lastFocus:flash.display.InteractiveObject;
		private var lastAction:String;
		public function FocusManager(p__1:flash.display.DisplayObjectContainer)
		{
			focusableObjects = new flash.utils.Dictionary(true);
			if (p__1 != null){
				_form = p__1;
				addFocusables(flash.display.DisplayObject(p__1));
				p__1.addEventListener(flash.events.Event.ADDED, addedHandler);
				p__1.addEventListener(flash.events.Event.REMOVED, removedHandler);
				activate();
			}
		}
		private function addedHandler(p__1:flash.events.Event):void
		{
			var l__2:flash.display.DisplayObject;
			l__2 = flash.display.DisplayObject(p__1.target);
			if (l__2.stage){
				addFocusables(flash.display.DisplayObject(p__1.target));
			}
		}
		private function removedHandler(p__1:flash.events.Event):void
		{
			var l__2:int;
			var l__3:flash.display.DisplayObject;
			var l__4:flash.display.InteractiveObject;
			l__3 = flash.display.DisplayObject(p__1.target);
			if ((l__3 is fl.managers.IFocusManagerComponent) && (focusableObjects[l__3] == true)){
				if (l__3 == lastFocus){
					fl.managers.IFocusManagerComponent(lastFocus).drawFocus(false);
					lastFocus = null;
				}
				l__3.removeEventListener(flash.events.Event.TAB_ENABLED_CHANGE, tabEnabledChangeHandler);
				delete focusableObjects[l__3];
				calculateCandidates = true;
			} else if ((l__3 is flash.display.InteractiveObject) && (focusableObjects[l__3] == true)){
				l__4 = (l__3 as flash.display.InteractiveObject);
				if (l__4){
					if (l__4 == lastFocus){
						lastFocus = null;
					}
					delete focusableObjects[l__4];
					calculateCandidates = true;
				}
				l__3.addEventListener(flash.events.Event.TAB_ENABLED_CHANGE, tabEnabledChangeHandler);
			}
			removeFocusables(l__3);
		}
		private function addFocusables(o:flash.display.DisplayObject, skipTopLevel:Boolean = false):void
		{
			var focusable:fl.managers.IFocusManagerComponent;
			var io:flash.display.InteractiveObject;
			var doc:flash.display.DisplayObjectContainer;
			var i:int;
			var child:flash.display.DisplayObject;
			if (!skipTopLevel){
				if (o is fl.managers.IFocusManagerComponent){
					focusable = fl.managers.IFocusManagerComponent(o);
					if (focusable.focusEnabled){
						if (focusable.tabEnabled && isTabVisible(o)){
							focusableObjects[o] = true;
							calculateCandidates = true;
						}
						o.addEventListener(flash.events.Event.TAB_ENABLED_CHANGE, tabEnabledChangeHandler);
						o.addEventListener(flash.events.Event.TAB_INDEX_CHANGE, tabIndexChangeHandler);
					}
				} else if (o is flash.display.InteractiveObject){
					io = (o as flash.display.InteractiveObject);
					if ((io && io.tabEnabled) && (findFocusManagerComponent(io) == io)){
						focusableObjects[io] = true;
						calculateCandidates = true;
					}
					io.addEventListener(flash.events.Event.TAB_ENABLED_CHANGE, tabEnabledChangeHandler);
					io.addEventListener(flash.events.Event.TAB_INDEX_CHANGE, tabIndexChangeHandler);
				}
			}
			if (o is flash.display.DisplayObjectContainer){
				doc = flash.display.DisplayObjectContainer(o);
				o.addEventListener(flash.events.Event.TAB_CHILDREN_CHANGE, tabChildrenChangeHandler);
				if (((doc is flash.display.Stage) || (doc.parent is flash.display.Stage)) || doc.tabChildren){
					i = 0;
					while(i < doc.numChildren){
						try {
							child = doc.getChildAt(i);
							if (child != null){
								addFocusables(doc.getChildAt(i));
							}
						} catch (error:SecurityError) {
						}
						i++;
					}
				}
			}
		}
		private function removeFocusables(p__1:flash.display.DisplayObject):void
		{
			var l__2:Object;
			var l__3:flash.display.DisplayObject;
			if (p__1 is flash.display.DisplayObjectContainer){
				p__1.removeEventListener(flash.events.Event.TAB_CHILDREN_CHANGE, tabChildrenChangeHandler);
				p__1.removeEventListener(flash.events.Event.TAB_INDEX_CHANGE, tabIndexChangeHandler);
				for (l__2 in focusableObjects){
					l__3 = flash.display.DisplayObject(l__2);
					if (flash.display.DisplayObjectContainer(p__1).contains(l__3)){
						if (l__3 == lastFocus){
							lastFocus = null;
						}
						l__3.removeEventListener(flash.events.Event.TAB_ENABLED_CHANGE, tabEnabledChangeHandler);
						delete focusableObjects[l__2];
						calculateCandidates = true;
					}
				}
			}
		}
		private function isTabVisible(p__1:flash.display.DisplayObject):Boolean
		{
			var l__2:flash.display.DisplayObjectContainer;
			l__2 = p__1.parent;
			while((l__2 && !(l__2 is flash.display.Stage)) && !(l__2.parent && (l__2.parent is flash.display.Stage))){
				if (!l__2.tabChildren){
					return(false);
				}
				l__2 = l__2.parent;
			}
			return(true);
		}
		private function isValidFocusCandidate(p__1:flash.display.DisplayObject, p__2:String):Boolean
		{
			var l__3:fl.managers.IFocusManagerGroup;
			if (!isEnabledAndVisible(p__1)){
				return(false);
			}
			if (p__1 is fl.managers.IFocusManagerGroup){
				l__3 = fl.managers.IFocusManagerGroup(p__1);
				if (p__2 == l__3.groupName){
					return(false);
				}
			}
			return(true);
		}
		private function isEnabledAndVisible(p__1:flash.display.DisplayObject):Boolean
		{
			var l__2:flash.display.DisplayObjectContainer;
			var l__3:flash.text.TextField;
			var l__4:flash.display.SimpleButton;
			l__2 = flash.display.DisplayObject(form).parent;
			while(p__1 != l__2){
				if (p__1 is fl.core.UIComponent){
					if (!fl.core.UIComponent(p__1).enabled){
						return(false);
					}
				} else if (p__1 is flash.text.TextField){
					l__3 = flash.text.TextField(p__1);
					if ((l__3.type == flash.text.TextFieldType.DYNAMIC) || (!l__3.selectable)){
						return(false);
					}
				} else if (p__1 is flash.display.SimpleButton){
					l__4 = flash.display.SimpleButton(p__1);
					if (!l__4.enabled){
						return(false);
					}
				}
				if (!p__1.visible){
					return(false);
				}
				p__1 = p__1.parent;
			}
			return(true);
		}
		private function tabEnabledChangeHandler(p__1:flash.events.Event):void
		{
			var l__2:flash.display.InteractiveObject;
			var l__3:Boolean;
			calculateCandidates = true;
			l__2 = flash.display.InteractiveObject(p__1.target);
			l__3 = focusableObjects[l__2] == true;
			if (l__2.tabEnabled){
				if ((!l__3) && isTabVisible(l__2)){
					if (!(l__2 is fl.managers.IFocusManagerComponent)){
						l__2.focusRect = false;
					}
					focusableObjects[l__2] = true;
				}
			} else if (l__3){
				delete focusableObjects[l__2];
			}
		}
		private function tabIndexChangeHandler(p__1:flash.events.Event):void
		{
			calculateCandidates = true;
		}
		private function tabChildrenChangeHandler(p__1:flash.events.Event):void
		{
			var l__2:flash.display.DisplayObjectContainer;
			if (p__1.target != p__1.currentTarget){
				return;
			}
			calculateCandidates = true;
			l__2 = flash.display.DisplayObjectContainer(p__1.target);
			if (l__2.tabChildren){
				addFocusables(l__2, true);
			} else {
				removeFocusables(l__2);
			}
		}
		public function activate():void
		{
			if (activated){
				return;
			}
			form.stage.addEventListener(flash.events.FocusEvent.MOUSE_FOCUS_CHANGE, mouseFocusChangeHandler, false, 0, true);
			form.stage.addEventListener(flash.events.FocusEvent.KEY_FOCUS_CHANGE, keyFocusChangeHandler, false, 0, true);
			form.addEventListener(flash.events.FocusEvent.FOCUS_IN, focusInHandler, true);
			form.addEventListener(flash.events.FocusEvent.FOCUS_OUT, focusOutHandler, true);
			form.stage.addEventListener(flash.events.Event.ACTIVATE, activateHandler, false, 0, true);
			form.stage.addEventListener(flash.events.Event.DEACTIVATE, deactivateHandler, false, 0, true);
			form.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, mouseDownHandler);
			form.addEventListener(flash.events.KeyboardEvent.KEY_DOWN, keyDownHandler, true);
			activated = true;
			if (lastFocus){
				setFocus(lastFocus);
			}
		}
		public function deactivate():void
		{
			form.stage.removeEventListener(flash.events.FocusEvent.MOUSE_FOCUS_CHANGE, mouseFocusChangeHandler);
			form.stage.removeEventListener(flash.events.FocusEvent.KEY_FOCUS_CHANGE, keyFocusChangeHandler);
			form.removeEventListener(flash.events.FocusEvent.FOCUS_IN, focusInHandler, true);
			form.removeEventListener(flash.events.FocusEvent.FOCUS_OUT, focusOutHandler, true);
			form.stage.removeEventListener(flash.events.Event.ACTIVATE, activateHandler);
			form.stage.removeEventListener(flash.events.Event.DEACTIVATE, deactivateHandler);
			form.removeEventListener(flash.events.MouseEvent.MOUSE_DOWN, mouseDownHandler);
			form.removeEventListener(flash.events.KeyboardEvent.KEY_DOWN, keyDownHandler, true);
			activated = false;
		}
		private function focusInHandler(p__1:flash.events.FocusEvent):void
		{
			var l__2:flash.display.InteractiveObject;
			var l__3:fl.controls.Button;
			l__2 = flash.display.InteractiveObject(p__1.target);
			if (form.contains(l__2)){
				lastFocus = findFocusManagerComponent(flash.display.InteractiveObject(l__2));
				if (lastFocus is fl.controls.Button){
					l__3 = fl.controls.Button(lastFocus);
					if (defButton){
						defButton.emphasized = false;
						defButton = l__3;
						l__3.emphasized = true;
					}
				} else if (defButton && !(defButton == _defaultButton)){
					defButton.emphasized = false;
					defButton = _defaultButton;
					_defaultButton.emphasized = true;
				}
			}
		}
		private function focusOutHandler(p__1:flash.events.FocusEvent):void
		{
			var l__2:flash.display.InteractiveObject;
			l__2 = (p__1.target as flash.display.InteractiveObject);
		}
		private function activateHandler(p__1:flash.events.Event):void
		{
			var l__2:flash.display.InteractiveObject;
			l__2 = flash.display.InteractiveObject(p__1.target);
			if (lastFocus){
				if (lastFocus is fl.managers.IFocusManagerComponent){
					fl.managers.IFocusManagerComponent(lastFocus).setFocus();
				} else {
					form.stage.focus = lastFocus;
				}
			}
			lastAction = "ACTIVATE";
		}
		private function deactivateHandler(p__1:flash.events.Event):void
		{
			var l__2:flash.display.InteractiveObject;
			l__2 = flash.display.InteractiveObject(p__1.target);
		}
		private function mouseFocusChangeHandler(p__1:flash.events.FocusEvent):void
		{
			if (p__1.relatedObject is flash.text.TextField){
				return;
			}
			p__1.preventDefault();
		}
		private function keyFocusChangeHandler(p__1:flash.events.FocusEvent):void
		{
			showFocusIndicator = true;
			if (((p__1.keyCode == flash.ui.Keyboard.TAB) || (p__1.keyCode == 0)) && (!p__1.isDefaultPrevented())){
				setFocusToNextObject(p__1);
				p__1.preventDefault();
			}
		}
		private function keyDownHandler(p__1:flash.events.KeyboardEvent):void
		{
			if (p__1.keyCode == flash.ui.Keyboard.TAB){
				lastAction = "KEY";
				if (calculateCandidates){
					sortFocusableObjects();
					calculateCandidates = false;
				}
			}
			if (((defaultButtonEnabled && (p__1.keyCode == flash.ui.Keyboard.ENTER)) && defaultButton) && defButton.enabled){
				sendDefaultButtonEvent();
			}
		}
		private function mouseDownHandler(p__1:flash.events.MouseEvent):void
		{
			var l__2:flash.display.InteractiveObject;
			if (p__1.isDefaultPrevented()){
				return;
			}
			l__2 = getTopLevelFocusTarget(flash.display.InteractiveObject(p__1.target));
			if (!l__2){
				return;
			}
			showFocusIndicator = false;
			if ((!(l__2 == lastFocus) || (lastAction == "ACTIVATE")) && !(l__2 is flash.text.TextField)){
				setFocus(l__2);
			}
			lastAction = "MOUSEDOWN";
		}
		public function get defaultButton():fl.controls.Button
		{
			return(_defaultButton);
		}
		public function set defaultButton(p__1:fl.controls.Button):void
		{
			var l__2:fl.controls.Button;
			l__2 = p__1 ? fl.controls.Button(p__1) : null;
			if (l__2 != _defaultButton){
				if (_defaultButton){
					_defaultButton.emphasized = false;
				}
				if (defButton){
					defButton.emphasized = false;
				}
				_defaultButton = l__2;
				defButton = l__2;
				if (l__2){
					l__2.emphasized = true;
				}
			}
		}
		public function sendDefaultButtonEvent():void
		{
			defButton.dispatchEvent(new flash.events.MouseEvent(flash.events.MouseEvent.CLICK));
		}
		private function setFocusToNextObject(p__1:flash.events.FocusEvent):void
		{
			var l__2:flash.display.InteractiveObject;
			if (!hasFocusableObjects()){
				return;
			}
			l__2 = getNextFocusManagerComponent(p__1.shiftKey);
			if (l__2){
				setFocus(l__2);
			}
		}
		private function hasFocusableObjects():Boolean
		{
			var l__1:Object;
			for (l__1 in focusableObjects){
				return(true);
			}
			return(false);
		}
		public function getNextFocusManagerComponent(p__1:Boolean = false):flash.display.InteractiveObject
		{
			var l__2:flash.display.DisplayObject;
			var l__3:String;
			var l__4:int;
			var l__5:Boolean;
			var l__6:int;
			var l__7:int;
			var l__8:fl.managers.IFocusManagerGroup;
			if (!hasFocusableObjects()){
				return(null);
			}
			if (calculateCandidates){
				sortFocusableObjects();
				calculateCandidates = false;
			}
			l__2 = form.stage.focus;
			l__2 = flash.display.DisplayObject(findFocusManagerComponent(flash.display.InteractiveObject(l__2)));
			l__3 = "";
			if (l__2 is fl.managers.IFocusManagerGroup){
				l__8 = fl.managers.IFocusManagerGroup(l__2);
				l__3 = l__8.groupName;
			}
			l__4 = getIndexOfFocusedObject(l__2);
			l__5 = false;
			l__6 = l__4;
			if (l__4 == -1){
				if (p__1){
					l__4 = focusableCandidates.length;
				}
				l__5 = true;
			}
			l__7 = getIndexOfNextObject(l__4, p__1, l__5, l__3);
			return(findFocusManagerComponent(focusableCandidates[l__7]));
		}
		private function getIndexOfFocusedObject(p__1:flash.display.DisplayObject):int
		{
			var l__2:int;
			var l__3:int;
			l__2 = focusableCandidates.length;
			l__3 = 0;
			l__3 = 0;
			while(l__3 < l__2){
				if (focusableCandidates[l__3] == p__1){
					return(l__3);
				}
				l__3++;
			}
			return(-1);
		}
		private function getIndexOfNextObject(p__1:int, p__2:Boolean, p__3:Boolean, p__4:String):int
		{
			var l__5:int;
			var l__6:int;
			var l__7:flash.display.DisplayObject;
			var l__8:fl.managers.IFocusManagerGroup;
			var l__9:int;
			var l__10:flash.display.DisplayObject;
			var l__11:fl.managers.IFocusManagerGroup;
			l__5 = focusableCandidates.length;
			l__6 = p__1;
			while(true){
				if (p__2){
					p__1--;
				} else {
					p__1++;
				}
				if (p__3){
					if (p__2 && (p__1 < 0)){
						break;
					}
					if ((!p__2) && (p__1 == l__5)){
						break;
					}
				} else {
					p__1 = ((p__1 + l__5) % l__5);
					if (l__6 == p__1){
						break;
					}
				}
				if (isValidFocusCandidate(focusableCandidates[p__1], p__4)){
					l__7 = flash.display.DisplayObject(findFocusManagerComponent(focusableCandidates[p__1]));
					if (l__7 is fl.managers.IFocusManagerGroup){
						l__8 = fl.managers.IFocusManagerGroup(l__7);
						l__9 = 0;
						while(l__9 < focusableCandidates.length){
							l__10 = focusableCandidates[l__9];
							if (l__10 is fl.managers.IFocusManagerGroup){
								l__11 = fl.managers.IFocusManagerGroup(l__10);
								if ((l__11.groupName == l__8.groupName) && l__11.selected){
									p__1 = l__9;
									break;
								}
							}
							l__9++;
						}
					}
					return(p__1);
				}
			}
			return(p__1);
		}
		private function sortFocusableObjects():void
		{
			var l__1:Object;
			var l__2:flash.display.InteractiveObject;
			focusableCandidates = [];
			for (l__1 in focusableObjects){
				l__2 = flash.display.InteractiveObject(l__1);
				if ((l__2.tabIndex && (!isNaN(Number(l__2.tabIndex)))) && (l__2.tabIndex > 0)){
					sortFocusableObjectsTabIndex();
					return;
				}
				focusableCandidates.AS3::push(l__2);
			}
			focusableCandidates.AS3::sort(sortByDepth);
		}
		private function sortFocusableObjectsTabIndex():void
		{
			var l__1:Object;
			var l__2:flash.display.InteractiveObject;
			focusableCandidates = [];
			for (l__1 in focusableObjects){
				l__2 = flash.display.InteractiveObject(l__1);
				if (l__2.tabIndex && (!isNaN(Number(l__2.tabIndex)))){
					focusableCandidates.AS3::push(l__2);
				}
			}
			focusableCandidates.AS3::sort(sortByTabIndex);
		}
		private function sortByDepth(p__1:flash.display.InteractiveObject, p__2:flash.display.InteractiveObject):Number
		{
			var l__3:String;
			var l__4:String;
			var l__5:int;
			var l__6:String;
			var l__7:String;
			var l__8:String;
			var l__9:flash.display.DisplayObject;
			var l__10:flash.display.DisplayObject;
			l__3 = "";
			l__4 = "";
			l__8 = "0000";
			l__9 = flash.display.DisplayObject(p__1);
			l__10 = flash.display.DisplayObject(p__2);
			while(!(l__9 == flash.display.DisplayObject(form)) && l__9.parent){
				l__5 = getChildIndex(l__9.parent, l__9);
				l__6 = l__5.AS3::toString(16);
				if (l__6.length < 4){
					l__7 = (l__8.AS3::substring(0, (4 - l__6.length)) + l__6);
				}
				l__3 = (l__7 + l__3);
				l__9 = l__9.parent;
			}
			while(!(l__10 == flash.display.DisplayObject(form)) && l__10.parent){
				l__5 = getChildIndex(l__10.parent, l__10);
				l__6 = l__5.AS3::toString(16);
				if (l__6.length < 4){
					l__7 = (l__8.AS3::substring(0, (4 - l__6.length)) + l__6);
				}
				l__4 = (l__7 + l__4);
				l__10 = l__10.parent;
			}
			return(((l__3 > l__4) ? 1 : ((l__3 < l__4) ? -1 : 0)));
		}
		private function getChildIndex(p__1:flash.display.DisplayObjectContainer, p__2:flash.display.DisplayObject):int
		{
			return(p__1.getChildIndex(p__2));
		}
		private function sortByTabIndex(p__1:flash.display.InteractiveObject, p__2:flash.display.InteractiveObject):int
		{
			return(((p__1.tabIndex > p__2.tabIndex) ? 1 : ((p__1.tabIndex < p__2.tabIndex) ? -1 : sortByDepth(p__1, p__2))));
		}
		public function get defaultButtonEnabled():Boolean
		{
			return(_defaultButtonEnabled);
		}
		public function set defaultButtonEnabled(p__1:Boolean):void
		{
			_defaultButtonEnabled = p__1;
		}
		public function get nextTabIndex():int
		{
			return(0);
		}
		public function get showFocusIndicator():Boolean
		{
			return(_showFocusIndicator);
		}
		public function set showFocusIndicator(p__1:Boolean):void
		{
			_showFocusIndicator = p__1;
		}
		public function get form():flash.display.DisplayObjectContainer
		{
			return(_form);
		}
		public function set form(p__1:flash.display.DisplayObjectContainer):void
		{
			_form = p__1;
		}
		public function getFocus():flash.display.InteractiveObject
		{
			var l__1:flash.display.InteractiveObject;
			l__1 = form.stage.focus;
			return(findFocusManagerComponent(l__1));
		}
		public function setFocus(p__1:flash.display.InteractiveObject):void
		{
			if (p__1 is fl.managers.IFocusManagerComponent){
				fl.managers.IFocusManagerComponent(p__1).setFocus();
			} else {
				form.stage.focus = p__1;
			}
		}
		public function showFocus():void
		{
		}
		public function hideFocus():void
		{
		}
		public function findFocusManagerComponent(p__1:flash.display.InteractiveObject):flash.display.InteractiveObject
		{
			var l__2:flash.display.InteractiveObject;
			l__2 = p__1;
			while(p__1){
				if ((p__1 is fl.managers.IFocusManagerComponent) && fl.managers.IFocusManagerComponent(p__1).focusEnabled){
					return(p__1);
				}
				p__1 = p__1.parent;
			}
			return(l__2);
		}
		private function getTopLevelFocusTarget(p__1:flash.display.InteractiveObject):flash.display.InteractiveObject
		{
			while(p__1 != flash.display.InteractiveObject(form)){
				if ((((p__1 is fl.managers.IFocusManagerComponent) && fl.managers.IFocusManagerComponent(p__1).focusEnabled) && fl.managers.IFocusManagerComponent(p__1).mouseFocusEnabled) && fl.core.UIComponent(p__1).enabled){
					return(p__1);
				}
				p__1 = p__1.parent;
				if (p__1 == null){
					break;
				}
			}
			return(null);
		}
	}
}