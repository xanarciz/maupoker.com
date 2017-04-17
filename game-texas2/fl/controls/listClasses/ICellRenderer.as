// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package fl.controls.listClasses
{
	public interface ICellRenderer
	{
		function set y(p__1:Number):void;
		function set x(p__1:Number):void;
		function setSize(p__1:Number, p__2:Number):void;
		function get listData():fl.controls.listClasses.ListData;
		function set listData(p__1:fl.controls.listClasses.ListData):void;
		function get data():Object;
		function set data(p__1:Object):void;
		function get selected():Boolean;
		function set selected(p__1:Boolean):void;
		function setMouseState(p__1:String):void;
	}
}