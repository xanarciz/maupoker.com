// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package caurina.transitions
{
	public class SpecialProperty
	{
		public var parameters:Array;
		public var getValue:Function;
		public var preProcess:Function;
		public var setValue:Function;
		public function SpecialProperty(p__1:Function, p__2:Function, p__3:Array = null, p__4:Function = null)
		{
			getValue = p__1;
			setValue = p__2;
			parameters = p__3;
			preProcess = p__4;
		}
		public function toString():String
		{
			var l__1:* = "";
			l__1 = (l__1 + "[SpecialProperty ");
			l__1 = (l__1 + ("getValue:" + String(getValue)));
			l__1 = (l__1 + ", ");
			l__1 = (l__1 + ("setValue:" + String(setValue)));
			l__1 = (l__1 + ", ");
			l__1 = (l__1 + ("parameters:" + String(parameters)));
			l__1 = (l__1 + ", ");
			l__1 = (l__1 + ("preProcess:" + String(preProcess)));
			l__1 = (l__1 + "]");
			return(l__1);
		}
	}
}