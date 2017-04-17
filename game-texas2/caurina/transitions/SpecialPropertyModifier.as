// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package caurina.transitions
{
	public class SpecialPropertyModifier
	{
		public var getValue:Function;
		public var modifyValues:Function;
		public function SpecialPropertyModifier(p__1:Function, p__2:Function)
		{
			modifyValues = p__1;
			getValue = p__2;
		}
		public function toString():String
		{
			var l__1:* = "";
			l__1 = (l__1 + "[SpecialPropertyModifier ");
			l__1 = (l__1 + ("modifyValues:" + String(modifyValues)));
			l__1 = (l__1 + ", ");
			l__1 = (l__1 + ("getValue:" + String(getValue)));
			l__1 = (l__1 + "]");
			return(l__1);
		}
	}
}