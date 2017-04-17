// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package fl.controls.listClasses
{
	import fl.core.*;
	public class TileListData extends fl.controls.listClasses.ListData
	{
		protected var _source:Object;
		public function TileListData(p__1:String, p__2:Object, p__3:Object, p__4:fl.core.UIComponent, p__5:uint, p__6:uint, p__7:uint = 0)
		{
			super(p__1, p__2, p__4, p__5, p__6, p__7);
			_source = p__3;
		}
		public function get source():Object
		{
			return(_source);
		}
	}
}