// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package caurina.transitions
{
	import ws.tink.core.Library;
	public class PropertyInfoObj
	{
		public var modifierParameters:Array;
		public var isSpecialProperty:Boolean;
		public var valueComplete:Number;
		public var modifierFunction:Function;
		public var extra:Object;
		public var valueStart:Number;
		public var hasModifier:Boolean;
		public var arrayIndex:Number;
		public var originalValueComplete:Object;
		public function PropertyInfoObj(p__1:Number, p__2:Number, p__3:Object, p__4:Number, p__5:Object, p__6:Boolean, p__7:Function, p__8:Array)
		{
			valueStart = p__1;
			valueComplete = p__2;
			originalValueComplete = p__3;
			arrayIndex = p__4;
			extra = p__5;
			isSpecialProperty = p__6;
			hasModifier = Boolean(p__7);
			modifierFunction = p__7;
			modifierParameters = p__8;
		}
		public function clone():caurina.transitions.PropertyInfoObj
		{
			var l__1:caurina.transitions.PropertyInfoObj = new PropertyInfoObj(valueStart, valueComplete, originalValueComplete, arrayIndex, extra, isSpecialProperty, modifierFunction, modifierParameters);
			return(l__1);
		}
		public function toString():String
		{
			var l__1:* = "\n[PropertyInfoObj ";
			l__1 = (l__1 + ("valueStart:" + String(valueStart)));
			l__1 = (l__1 + ", ");
			l__1 = (l__1 + ("valueComplete:" + String(valueComplete)));
			l__1 = (l__1 + ", ");
			l__1 = (l__1 + ("originalValueComplete:" + String(originalValueComplete)));
			l__1 = (l__1 + ", ");
			l__1 = (l__1 + ("arrayIndex:" + String(arrayIndex)));
			l__1 = (l__1 + ", ");
			l__1 = (l__1 + ("extra:" + String(extra)));
			l__1 = (l__1 + ", ");
			l__1 = (l__1 + ("isSpecialProperty:" + String(isSpecialProperty)));
			l__1 = (l__1 + ", ");
			l__1 = (l__1 + ("hasModifier:" + String(hasModifier)));
			l__1 = (l__1 + ", ");
			l__1 = (l__1 + ("modifierFunction:" + String(modifierFunction)));
			l__1 = (l__1 + ", ");
			l__1 = (l__1 + ("modifierParameters:" + String(modifierParameters)));
			l__1 = (l__1 + "]\n");
			return(l__1);
		}
	}
}