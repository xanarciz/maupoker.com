// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package caurina.transitions
{
	public class SpecialPropertySplitter
	{
		public var parameters:Array;
		public var splitValues:Function;
		public function SpecialPropertySplitter(p__1:Function, p__2:Array)
		{
			splitValues = p__1;
			parameters = p__2;
		}
		public function toString():String
		{
			var l__1:* = "";
			l__1 = (l__1 + "[SpecialPropertySplitter ");
			l__1 = (l__1 + ("splitValues:" + String(splitValues)));
			l__1 = (l__1 + ", ");
			l__1 = (l__1 + ("parameters:" + String(parameters)));
			l__1 = (l__1 + "]");
			return(l__1);
		}
	}
}