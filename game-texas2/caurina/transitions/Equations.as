// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package caurina.transitions
{
	import ws.tink.managers.LibraryManager;
	public class Equations
	{
		public function Equations()
		{
		}
		public static function init():void
		{
			Tweener.registerTransition("easenone", easeNone);
			Tweener.registerTransition("linear", easeNone);
			Tweener.registerTransition("easeinquad", easeInQuad);
			Tweener.registerTransition("easeoutquad", easeOutQuad);
			Tweener.registerTransition("easeinoutquad", easeInOutQuad);
			Tweener.registerTransition("easeoutinquad", easeOutInQuad);
			Tweener.registerTransition("easeincubic", easeInCubic);
			Tweener.registerTransition("easeoutcubic", easeOutCubic);
			Tweener.registerTransition("easeinoutcubic", easeInOutCubic);
			Tweener.registerTransition("easeoutincubic", easeOutInCubic);
			Tweener.registerTransition("easeinquart", easeInQuart);
			Tweener.registerTransition("easeoutquart", easeOutQuart);
			Tweener.registerTransition("easeinoutquart", easeInOutQuart);
			Tweener.registerTransition("easeoutinquart", easeOutInQuart);
			Tweener.registerTransition("easeinquint", easeInQuint);
			Tweener.registerTransition("easeoutquint", easeOutQuint);
			Tweener.registerTransition("easeinoutquint", easeInOutQuint);
			Tweener.registerTransition("easeoutinquint", easeOutInQuint);
			Tweener.registerTransition("easeinsine", easeInSine);
			Tweener.registerTransition("easeoutsine", easeOutSine);
			Tweener.registerTransition("easeinoutsine", easeInOutSine);
			Tweener.registerTransition("easeoutinsine", easeOutInSine);
			Tweener.registerTransition("easeincirc", easeInCirc);
			Tweener.registerTransition("easeoutcirc", easeOutCirc);
			Tweener.registerTransition("easeinoutcirc", easeInOutCirc);
			Tweener.registerTransition("easeoutincirc", easeOutInCirc);
			Tweener.registerTransition("easeinexpo", easeInExpo);
			Tweener.registerTransition("easeoutexpo", easeOutExpo);
			Tweener.registerTransition("easeinoutexpo", easeInOutExpo);
			Tweener.registerTransition("easeoutinexpo", easeOutInExpo);
			Tweener.registerTransition("easeinelastic", easeInElastic);
			Tweener.registerTransition("easeoutelastic", easeOutElastic);
			Tweener.registerTransition("easeinoutelastic", easeInOutElastic);
			Tweener.registerTransition("easeoutinelastic", easeOutInElastic);
			Tweener.registerTransition("easeinback", easeInBack);
			Tweener.registerTransition("easeoutback", easeOutBack);
			Tweener.registerTransition("easeinoutback", easeInOutBack);
			Tweener.registerTransition("easeoutinback", easeOutInBack);
			Tweener.registerTransition("easeinbounce", easeInBounce);
			Tweener.registerTransition("easeoutbounce", easeOutBounce);
			Tweener.registerTransition("easeinoutbounce", easeInOutBounce);
			Tweener.registerTransition("easeoutinbounce", easeOutInBounce);
		}
		public static function easeNone(p__1:Number, p__2:Number, p__3:Number, p__4:Number, p__5:Object = null):Number
		{
			return(((p__3) * (p__1)) / (p__4) + p__2);
		}
		public static function easeInQuad(p__1:Number, p__2:Number, p__3:Number, p__4:Number, p__5:Object = null):Number
		{
			return((((p__3) * (p__1 = (p__1) / (p__4))) * (p__1)) + p__2);
		}
		public static function easeOutQuad(p__1:Number, p__2:Number, p__3:Number, p__4:Number, p__5:Object = null):Number
		{
			return(((-(p__3) * (p__1 = (p__1) / (p__4))) * (p__1 - 2)) + p__2);
		}
		public static function easeInOutQuad(p__1:Number, p__2:Number, p__3:Number, p__4:Number, p__5:Object = null):Number
		{
			if ((p__1 = (p__1) / ((p__4) / 2)) < 1){
				return((((p__3) / 2) * (p__1)) * (p__1) + p__2);
			}
			p__1 = (p__1) - 1;
			return((-(p__3) / 2) * (((p__1) - 1 * (p__1 - 2)) - 1) + p__2);
		}
		public static function easeOutInQuad(p__1:Number, p__2:Number, p__3:Number, p__4:Number, p__5:Object = null):Number
		{
			if ((p__1) < ((p__4) / 2)){
				return(easeOutQuad((p__1) * 2, p__2, (p__3) / 2, p__4, p__5));
			}
			return(easeInQuad(((p__1) * 2 - p__4), (p__2 + ((p__3) / 2)), (p__3) / 2, p__4, p__5));
		}
		public static function easeInCubic(p__1:Number, p__2:Number, p__3:Number, p__4:Number, p__5:Object = null):Number
		{
			return(((((p__3) * (p__1 = (p__1) / (p__4))) * (p__1)) * (p__1)) + p__2);
		}
		public static function easeOutCubic(p__1:Number, p__2:Number, p__3:Number, p__4:Number, p__5:Object = null):Number
		{
			return(((p__3) * ((((p__1 = ((p__1) / (p__4)) - 1) * (p__1)) * (p__1)) + 1)) + p__2);
		}
		public static function easeInOutCubic(p__1:Number, p__2:Number, p__3:Number, p__4:Number, p__5:Object = null):Number
		{
			if ((p__1 = (p__1) / ((p__4) / 2)) < 1){
				return(((((p__3) / 2) * (p__1)) * (p__1)) * (p__1) + p__2);
			}
			return((((p__3) / 2) * ((((p__1 = (p__1 - 2)) * (p__1)) * (p__1)) + 2)) + p__2);
		}
		public static function easeOutInCubic(p__1:Number, p__2:Number, p__3:Number, p__4:Number, p__5:Object = null):Number
		{
			if ((p__1) < ((p__4) / 2)){
				return(easeOutCubic((p__1) * 2, p__2, (p__3) / 2, p__4, p__5));
			}
			return(easeInCubic(((p__1) * 2 - p__4), (p__2 + ((p__3) / 2)), (p__3) / 2, p__4, p__5));
		}
		public static function easeInQuart(p__1:Number, p__2:Number, p__3:Number, p__4:Number, p__5:Object = null):Number
		{
			return((((((p__3) * (p__1 = (p__1) / (p__4))) * (p__1)) * (p__1)) * (p__1)) + p__2);
		}
		public static function easeOutQuart(p__1:Number, p__2:Number, p__3:Number, p__4:Number, p__5:Object = null):Number
		{
			return((-(p__3) * (((((p__1 = ((p__1) / (p__4)) - 1) * (p__1)) * (p__1)) * (p__1)) - 1)) + p__2);
		}
		public static function easeInOutQuart(p__1:Number, p__2:Number, p__3:Number, p__4:Number, p__5:Object = null):Number
		{
			if ((p__1 = (p__1) / ((p__4) / 2)) < 1){
				return((((((p__3) / 2) * (p__1)) * (p__1)) * (p__1)) * (p__1) + p__2);
			}
			return(((-(p__3) / 2) * (((((p__1 = (p__1 - 2)) * (p__1)) * (p__1)) * (p__1)) - 2)) + p__2);
		}
		public static function easeOutInQuart(p__1:Number, p__2:Number, p__3:Number, p__4:Number, p__5:Object = null):Number
		{
			if ((p__1) < ((p__4) / 2)){
				return(easeOutQuart((p__1) * 2, p__2, (p__3) / 2, p__4, p__5));
			}
			return(easeInQuart(((p__1) * 2 - p__4), (p__2 + ((p__3) / 2)), (p__3) / 2, p__4, p__5));
		}
		public static function easeInQuint(p__1:Number, p__2:Number, p__3:Number, p__4:Number, p__5:Object = null):Number
		{
			return(((((((p__3) * (p__1 = (p__1) / (p__4))) * (p__1)) * (p__1)) * (p__1)) * (p__1)) + p__2);
		}
		public static function easeOutQuint(p__1:Number, p__2:Number, p__3:Number, p__4:Number, p__5:Object = null):Number
		{
			return(((p__3) * ((((((p__1 = ((p__1) / (p__4)) - 1) * (p__1)) * (p__1)) * (p__1)) * (p__1)) + 1)) + p__2);
		}
		public static function easeInOutQuint(p__1:Number, p__2:Number, p__3:Number, p__4:Number, p__5:Object = null):Number
		{
			if ((p__1 = (p__1) / ((p__4) / 2)) < 1){
				return(((((((p__3) / 2) * (p__1)) * (p__1)) * (p__1)) * (p__1)) * (p__1) + p__2);
			}
			return((((p__3) / 2) * ((((((p__1 = (p__1 - 2)) * (p__1)) * (p__1)) * (p__1)) * (p__1)) + 2)) + p__2);
		}
		public static function easeOutInQuint(p__1:Number, p__2:Number, p__3:Number, p__4:Number, p__5:Object = null):Number
		{
			if ((p__1) < ((p__4) / 2)){
				return(easeOutQuint((p__1) * 2, p__2, (p__3) / 2, p__4, p__5));
			}
			return(easeInQuint(((p__1) * 2 - p__4), (p__2 + ((p__3) / 2)), (p__3) / 2, p__4, p__5));
		}
		public static function easeInSine(p__1:Number, p__2:Number, p__3:Number, p__4:Number, p__5:Object = null):Number
		{
			return((-(p__3) * Math.cos(((p__1) / (p__4)) * (Math.PI / 2)) + p__3) + p__2);
		}
		public static function easeOutSine(p__1:Number, p__2:Number, p__3:Number, p__4:Number, p__5:Object = null):Number
		{
			return((p__3) * Math.sin(((p__1) / (p__4)) * (Math.PI / 2)) + p__2);
		}
		public static function easeInOutSine(p__1:Number, p__2:Number, p__3:Number, p__4:Number, p__5:Object = null):Number
		{
			return((-(p__3) / 2) * (Math.cos((Math.PI * (p__1)) / (p__4)) - 1) + p__2);
		}
		public static function easeOutInSine(p__1:Number, p__2:Number, p__3:Number, p__4:Number, p__5:Object = null):Number
		{
			if ((p__1) < ((p__4) / 2)){
				return(easeOutSine((p__1) * 2, p__2, (p__3) / 2, p__4, p__5));
			}
			return(easeInSine(((p__1) * 2 - p__4), (p__2 + ((p__3) / 2)), (p__3) / 2, p__4, p__5));
		}
		public static function easeInExpo(p__1:Number, p__2:Number, p__3:Number, p__4:Number, p__5:Object = null):Number
		{
			return(((p__1) == 0) ? (p__2) : (((p__3) * Math.pow(2, 10 * (((p__1) / (p__4)) - 1)) + p__2) - ((p__3) * 0.001)));
		}
		public static function easeOutExpo(p__1:Number, p__2:Number, p__3:Number, p__4:Number, p__5:Object = null):Number
		{
			return(((p__1) == (p__4)) ? (p__2 + p__3) : (((p__3) * 1.001) * (-Math.pow(2, (-10 * (p__1)) / (p__4)) + 1) + p__2));
		}
		public static function easeInOutExpo(p__1:Number, p__2:Number, p__3:Number, p__4:Number, p__5:Object = null):Number
		{
			if ((p__1) == 0){
				return(p__2);
			}
			if ((p__1) == (p__4)){
				return(p__2 + p__3);
			}
			if ((p__1 = (p__1) / ((p__4) / 2)) < 1){
				return((((p__3) / 2) * Math.pow(2, 10 * ((p__1) - 1)) + p__2) - ((p__3) * 0.0005));
			}
			p__1 = (p__1) - 1;
			return((((p__3) / 2) * 1.0005) * (-Math.pow(2, -10 * (p__1) - 1) + 2) + p__2);
		}
		public static function easeOutInExpo(p__1:Number, p__2:Number, p__3:Number, p__4:Number, p__5:Object = null):Number
		{
			if ((p__1) < ((p__4) / 2)){
				return(easeOutExpo((p__1) * 2, p__2, (p__3) / 2, p__4, p__5));
			}
			return(easeInExpo(((p__1) * 2 - p__4), (p__2 + ((p__3) / 2)), (p__3) / 2, p__4, p__5));
		}
		public static function easeInCirc(p__1:Number, p__2:Number, p__3:Number, p__4:Number, p__5:Object = null):Number
		{
			return((-(p__3) * (Math.sqrt(1 - ((p__1 = (p__1) / (p__4)) * (p__1))) - 1)) + p__2);
		}
		public static function easeOutCirc(p__1:Number, p__2:Number, p__3:Number, p__4:Number, p__5:Object = null):Number
		{
			return(((p__3) * Math.sqrt(1 - ((p__1 = ((p__1) / (p__4)) - 1) * (p__1)))) + p__2);
		}
		public static function easeInOutCirc(p__1:Number, p__2:Number, p__3:Number, p__4:Number, p__5:Object = null):Number
		{
			if ((p__1 = (p__1) / ((p__4) / 2)) < 1){
				return((-(p__3) / 2) * (Math.sqrt(1 - ((p__1) * (p__1))) - 1) + p__2);
			}
			return((((p__3) / 2) * (Math.sqrt(1 - ((p__1 = (p__1 - 2)) * (p__1))) + 1)) + p__2);
		}
		public static function easeOutInCirc(p__1:Number, p__2:Number, p__3:Number, p__4:Number, p__5:Object = null):Number
		{
			if ((p__1) < ((p__4) / 2)){
				return(easeOutCirc((p__1) * 2, p__2, (p__3) / 2, p__4, p__5));
			}
			return(easeInCirc(((p__1) * 2 - p__4), (p__2 + ((p__3) / 2)), (p__3) / 2, p__4, p__5));
		}
		public static function easeInElastic(p__1:Number, p__2:Number, p__3:Number, p__4:Number, p__5:Object = null):Number
		{
			var l__7:Number;
			if ((p__1) == 0){
				return(p__2);
			}
			if ((p__1 = (p__1) / (p__4)) == 1){
				return(p__2 + p__3);
			}
			var l__6:Number = ((!Boolean(p__5)) || isNaN(p__5.period)) ? ((p__4) * 0.3) : (p__5.period);
			var l__8:Number = ((!Boolean(p__5)) || isNaN(p__5.amplitude)) ? 0 : (p__5.amplitude);
			if ((!Boolean(l__8)) || (l__8 < Math.abs(p__3))){
				l__8 = p__3;
				l__7 = l__6 / 4;
			} else {
				l__7 = (l__6 / (2 * Math.PI)) * Math.asin((p__3) / l__8);
			}
			return(-((l__8 * Math.pow(2, 10 * (p__1 = (p__1) - 1))) * Math.sin((((p__1) * (p__4) - l__7) * (2 * Math.PI)) / l__6)) + p__2);
		}
		public static function easeOutElastic(p__1:Number, p__2:Number, p__3:Number, p__4:Number, p__5:Object = null):Number
		{
			var l__7:Number;
			if ((p__1) == 0){
				return(p__2);
			}
			if ((p__1 = (p__1) / (p__4)) == 1){
				return(p__2 + p__3);
			}
			var l__6:Number = ((!Boolean(p__5)) || isNaN(p__5.period)) ? ((p__4) * 0.3) : (p__5.period);
			var l__8:Number = ((!Boolean(p__5)) || isNaN(p__5.amplitude)) ? 0 : (p__5.amplitude);
			if ((!Boolean(l__8)) || (l__8 < Math.abs(p__3))){
				l__8 = p__3;
				l__7 = l__6 / 4;
			} else {
				l__7 = (l__6 / (2 * Math.PI)) * Math.asin((p__3) / l__8);
			}
			return(((l__8 * Math.pow(2, -10 * (p__1))) * Math.sin((((p__1) * (p__4) - l__7) * (2 * Math.PI)) / l__6) + p__3) + p__2);
		}
		public static function easeInOutElastic(p__1:Number, p__2:Number, p__3:Number, p__4:Number, p__5:Object = null):Number
		{
			var l__7:Number;
			if ((p__1) == 0){
				return(p__2);
			}
			if ((p__1 = (p__1) / ((p__4) / 2)) == 2){
				return(p__2 + p__3);
			}
			var l__6:Number = ((!Boolean(p__5)) || isNaN(p__5.period)) ? ((p__4) * ((0.3 * 1.5))) : (p__5.period);
			var l__8:Number = ((!Boolean(p__5)) || isNaN(p__5.amplitude)) ? 0 : (p__5.amplitude);
			if ((!Boolean(l__8)) || (l__8 < Math.abs(p__3))){
				l__8 = p__3;
				l__7 = l__6 / 4;
			} else {
				l__7 = (l__6 / (2 * Math.PI)) * Math.asin((p__3) / l__8);
			}
			if ((p__1) < 1){
				return((-0.5 * ((l__8 * Math.pow(2, 10 * (p__1 = (p__1) - 1))) * Math.sin((((p__1) * (p__4) - l__7) * (2 * Math.PI)) / l__6))) + p__2);
			}
			return(((((l__8 * Math.pow(2, -10 * (p__1 = (p__1) - 1))) * Math.sin((((p__1) * (p__4) - l__7) * (2 * Math.PI)) / l__6)) * 0.5) + p__3) + p__2);
		}
		public static function easeOutInElastic(p__1:Number, p__2:Number, p__3:Number, p__4:Number, p__5:Object = null):Number
		{
			if ((p__1) < ((p__4) / 2)){
				return(easeOutElastic((p__1) * 2, p__2, (p__3) / 2, p__4, p__5));
			}
			return(easeInElastic(((p__1) * 2 - p__4), (p__2 + ((p__3) / 2)), (p__3) / 2, p__4, p__5));
		}
		public static function easeInBack(p__1:Number, p__2:Number, p__3:Number, p__4:Number, p__5:Object = null):Number
		{
			var l__6:Number = ((!Boolean(p__5)) || isNaN(p__5.overshoot)) ? 1.70158 : (p__5.overshoot);
			return(((((p__3) * (p__1 = (p__1) / (p__4))) * (p__1)) * ((l__6 + 1) * (p__1) - l__6)) + p__2);
		}
		public static function easeOutBack(p__1:Number, p__2:Number, p__3:Number, p__4:Number, p__5:Object = null):Number
		{
			var l__6:Number = ((!Boolean(p__5)) || isNaN(p__5.overshoot)) ? 1.70158 : (p__5.overshoot);
			return(((p__3) * ((((p__1 = ((p__1) / (p__4)) - 1) * (p__1)) * ((l__6 + 1) * (p__1) + l__6)) + 1)) + p__2);
		}
		public static function easeInOutBack(p__1:Number, p__2:Number, p__3:Number, p__4:Number, p__5:Object = null):Number
		{
			var l__6:Number = ((!Boolean(p__5)) || isNaN(p__5.overshoot)) ? 1.70158 : (p__5.overshoot);
			if ((p__1 = (p__1) / ((p__4) / 2)) < 1){
				return((((p__3) / 2) * (((p__1) * (p__1)) * ((((l__6 *= 1.525) + 1) * (p__1)) - l__6))) + p__2);
			}
			return((((p__3) / 2) * ((((p__1 = (p__1 - 2)) * (p__1)) * ((((l__6 *= 1.525) + 1) * (p__1)) + l__6)) + 2)) + p__2);
		}
		public static function easeOutInBack(p__1:Number, p__2:Number, p__3:Number, p__4:Number, p__5:Object = null):Number
		{
			if ((p__1) < ((p__4) / 2)){
				return(easeOutBack((p__1) * 2, p__2, (p__3) / 2, p__4, p__5));
			}
			return(easeInBack(((p__1) * 2 - p__4), (p__2 + ((p__3) / 2)), (p__3) / 2, p__4, p__5));
		}
		public static function easeInBounce(p__1:Number, p__2:Number, p__3:Number, p__4:Number, p__5:Object = null):Number
		{
			return((p__3 - easeOutBounce((p__4 - p__1), 0, p__3, p__4)) + p__2);
		}
		public static function easeOutBounce(p__1:Number, p__2:Number, p__3:Number, p__4:Number, p__5:Object = null):Number
		{
			if ((p__1 = (p__1) / (p__4)) < (1 / 2.75)){
				return((p__3) * ((7.5625 * (p__1)) * (p__1)) + p__2);
			}
			if ((p__1) < (2 / 2.75)){
				return(((p__3) * (((7.5625 * (p__1 = (p__1 - (1.5 / 2.75)))) * (p__1)) + 0.75)) + p__2);
			}
			if ((p__1) < (2.5 / 2.75)){
				return(((p__3) * (((7.5625 * (p__1 = (p__1 - (2.25 / 2.75)))) * (p__1)) + 0.9375)) + p__2);
			}
			return(((p__3) * (((7.5625 * (p__1 = (p__1 - (2.625 / 2.75)))) * (p__1)) + 0.984375)) + p__2);
		}
		public static function easeInOutBounce(p__1:Number, p__2:Number, p__3:Number, p__4:Number, p__5:Object = null):Number
		{
			if ((p__1) < ((p__4) / 2)){
				return(easeInBounce((p__1) * 2, 0, p__3, p__4) * 0.5 + p__2);
			}
			return((easeOutBounce(((p__1) * 2 - p__4), 0, p__3, p__4) * 0.5 + ((p__3) * 0.5)) + p__2);
		}
		public static function easeOutInBounce(p__1:Number, p__2:Number, p__3:Number, p__4:Number, p__5:Object = null):Number
		{
			if ((p__1) < ((p__4) / 2)){
				return(easeOutBounce((p__1) * 2, p__2, (p__3) / 2, p__4, p__5));
			}
			return(easeInBounce(((p__1) * 2 - p__4), (p__2 + ((p__3) / 2)), (p__3) / 2, p__4, p__5));
		}
	}
}