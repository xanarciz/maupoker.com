// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package fl.managers
{
	import fl.controls.*;
	import flash.display.*;
	public interface IFocusManager
	{
		function get defaultButton():fl.controls.Button;
		function set defaultButton(p__1:fl.controls.Button):void;
		function get defaultButtonEnabled():Boolean;
		function set defaultButtonEnabled(p__1:Boolean):void;
		function get nextTabIndex():int;
		function get showFocusIndicator():Boolean;
		function set showFocusIndicator(p__1:Boolean):void;
		function getFocus():flash.display.InteractiveObject;
		function setFocus(p__1:flash.display.InteractiveObject):void;
		function showFocus():void;
		function hideFocus():void;
		function activate():void;
		function deactivate():void;
		function findFocusManagerComponent(p__1:flash.display.InteractiveObject):flash.display.InteractiveObject;
		function getNextFocusManagerComponent(p__1:Boolean = false):flash.display.InteractiveObject;
	}
}