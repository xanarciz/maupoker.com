// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package fl.data
{
	public dynamic class SimpleCollectionItem
	{
		public var label:String;
		public var data:String;
		public function SimpleCollectionItem()
		{
		}
		public function toString():String
		{
			return(((("[SimpleCollectionItem: " + label) + ",") + data) + "]");
		}
	}
}