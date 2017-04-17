// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.yahoo.astra.utils
{
	import flash.utils.*;
	public class InstanceFactory
	{
		private var _methods:Object;
		private var _targetClass:Class = Object;
		private var _properties:Object;
		public function InstanceFactory(p__1:Class, p__2:Object = null, p__3:Object = null)
		{
			this.targetClass = p__1;
			this.properties = p__2;
			this.methods = p__3;
		}
		public function get targetClass():Class
		{
			return(this._targetClass);
		}
		public function set targetClass(p__1:Class):void
		{
			this._targetClass = p__1;
		}
		public function get properties():Object
		{
			return(this._properties);
		}
		public function set properties(p__1:Object):void
		{
			this._properties = p__1;
		}
		public function get methods():Object
		{
			return(this._methods);
		}
		public function set methods(p__1:Object):void
		{
			this._methods = p__1;
		}
		public function createInstance():Object
		{
			var l__1:Object = new targetClass();
			this.restoreInstance(l__1);
			return(l__1);
		}
		public function restoreInstance(p__1:Object):void
		{
			var l__2:String;
			var l__3:String;
			var l__4:Array;
			if (!(p__1 is targetClass)){
				throw new ArgumentError("Value to be initialized must be an instance of " + getQualifiedClassName(this.targetClass));
			}
			if (this.properties){
				for (l__2 in this.properties){
					if (p__1.hasOwnProperty(l__2)){
						p__1[l__2] = properties[l__2];
					}
				}
			}
			if (this.methods){
				for (l__3 in this.methods){
					if (p__1[l__3] is Function){
						l__4 = (this.methods[l__3] as Array);
						p__1[l__3].apply(p__1, l__4);
					}
				}
			}
		}
	}
}