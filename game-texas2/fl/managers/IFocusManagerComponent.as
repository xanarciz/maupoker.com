// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package fl.managers
{
	public interface IFocusManagerComponent
	{
		function get focusEnabled():Boolean;
		function set focusEnabled(p__1:Boolean):void;
		function get mouseFocusEnabled():Boolean;
		function get tabEnabled():Boolean;
		function get tabIndex():int;
		function setFocus():void;
		function drawFocus(p__1:Boolean):void;
	}
}