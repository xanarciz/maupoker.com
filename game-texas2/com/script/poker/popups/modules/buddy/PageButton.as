// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.popups.modules.buddy
{
	import flash.events.*;
	import caurina.transitions.*;
	import caurina.transitions.properties.*;
	import flash.display.*;
	public class PageButton extends flash.display.MovieClip
	{
		public var tinter:flash.display.MovieClip;
		public var grad:flash.display.MovieClip;
		public var ref:flash.display.MovieClip;
		public var isActive:Boolean;
		public var up:Boolean;
		public function PageButton(p__1:Boolean):void
		{
			up = p__1;
			if (up){
				ref.refDown.visible = false;
			}
			if (!up){
				grad.rotation = tinter.rotation = 180;
				ref.refUp.visible = false;
			}
			this.mouseChildren = false;
			this.addEventListener(flash.events.MouseEvent.ROLL_OVER, thisOver);
			this.addEventListener(flash.events.MouseEvent.ROLL_OUT, thisOut);
		}
		public function thisOver(p__1:flash.events.MouseEvent):void
		{
			if (isActive){
				caurina.transitions.Tweener.addTween(tinter, {_color:13209, time:0.15, transition:"easeOutSine"});
			}
		}
		public function thisOut(p__1:flash.events.MouseEvent):void
		{
			if (isActive){
				caurina.transitions.Tweener.addTween(tinter, {_color:3355443, time:0.15, transition:"easeOutSine"});
			}
		}
		public function setActive(p__1:Boolean):void
		{
			isActive = p__1;
			this.useHandCursor = p__1;
			this.buttonMode = p__1;
			if (p__1){
				caurina.transitions.Tweener.addTween(tinter, {_color:3355443});
			}
			if (!(p__1)){
				caurina.transitions.Tweener.addTween(tinter, {_color:12303291});
			}
		}
	}
	//var l__1:* = caurina.transitions.properties.ColorShortcuts.init();
	
	//return(l__1);
}