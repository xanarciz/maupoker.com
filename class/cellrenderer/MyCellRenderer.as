/******************************************************************************
MyCellRenderer class
copyright Flashscript.biz: 2008
This class overrides some of the settings for Datagrid and List components.
********************************************************************************/

package cellrenderer
{
	import fl.controls.listClasses.CellRenderer;
/* 
/ The class extends the CellRenderer class and inherits all the 
/ properties from this class.
*/
	public class MyCellRenderer extends CellRenderer
	{
/*
/ We declare a static Array variable to get hold which rows have been
/ selected.
*/
		private static  var _myArray:Array=new Array;
		public function MyCellRenderer ():void
		{
			super ();
		}
/*
/ This function will add the row index number to the array.
*/
		public static function selectIndex (sid:int):void
		{
			_myArray.push (sid);
		}
/*
* This method overrides the inherited drawBackground() method and adds the GreyColor from
* the MovieClip GreyColor to each selected index. 
*/
		override protected function drawBackground ():void
		{
			for (var count:int=0; count<=_myArray.length; count++)
			{
/*
/ _listdata.index is the index for each row.
*/
				if (_listData.index == _myArray[count])
				{
/*
/ We select the style after the row was pressed.
*/
					setStyle ("selectedUpSkin","#CCCCCC");
					setStyle ("upSkin", "#CCCCCC");
				}
				super.drawBackground ();
			}
		}
/*
/ This is another class of the CellRenderer class, which we need
/ to override to set new properties. We change the textField properties. 
/ The textField is derived from the LabelButton, which is used for the 
/ DataGrid and List components rows and headers. We set wordWrap to true if the
/ text is very long and give html properties to the textField. The string
/ for the textField has the name 'label'.
*/
		override protected function drawLayout ():void
		{
			//textField.wordWrap = true;
			textField.autoSize = "left";
			textField.width = this.width;
			textField.htmlText=this.label;
			super.drawLayout ();
		}
	}
}