// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.yahoo.astra.fl.utils
{
	import fl.core.UIComponent;
	import flash.display.DisplayObject;
	import fl.managers.*;
	import flash.utils.*;
	import com.yahoo.astra.utils.*;
	public class UIComponentUtil
	{
		public function UIComponentUtil()
		{
		}
		public static function getDisplayObjectInstance(target:flash.display.DisplayObject, input:Object):flash.display.DisplayObject
		{
			if (input is InstanceFactory){
				return(InstanceFactory(input).createInstance() as DisplayObject);
			}
			if ((input is Class) || (input is Function)){
				return((new input()) as DisplayObject);
			}
			if (input is DisplayObject){
				(input as DisplayObject).x = 0;
				(input as DisplayObject).y = 0;
				return(input as DisplayObject);
			}
			var classDef:Object;
			try {
				classDef = getDefinitionByName(input.toString());
			} catch (e:Error) {
				try {
					classDef = (target.loaderInfo.applicationDomain.getDefinition(input.toString()) as Object);
				} catch (e:Error) {
				}
			}
			if (classDef == null){
				return(null);
			}
			return((new classDef()) as DisplayObject);
		}
		public static function getClassDefinition(target:Object):Class
		{
			if (target is Class){
				return(target as Class);
			}
			try {
				return(getDefinitionByName(getQualifiedClassName(target)) as Class);
			} catch (e:Error) {
				if (target is DisplayObject){
					try {
						return(target.loaderInfo.applicationDomain.getDefinition(getQualifiedClassName(target)) as Class);
					} catch (e:Error) {
					}
				}
			}
			return(null);
		}
		public static function getStyleValue(target:fl.core.UIComponent, styleName:String):Object
		{
			var classDef:Class;
			var defaultStyles:Object;
			var value:Object = target.getStyle(styleName);
			value = value ? value : StyleManager.getComponentStyle(target, styleName);
			if (value){
				return(value);
			}
			classDef = UIComponentUtil.getClassDefinition(target);
			while(defaultStyles == null){
				if (classDef["getStyleDefinition"] != null){
					defaultStyles = classDef["getStyleDefinition"]();
					break;
				}
				try {
					classDef = (target.loaderInfo.applicationDomain.getDefinition(getQualifiedSuperclassName(classDef)) as Class);
				} catch (err:Error) {
					try {
						classDef = (getDefinitionByName(getQualifiedSuperclassName(classDef)) as Class);
					} catch (e:Error) {
						defaultStyles = UIComponent.getStyleDefinition();
						break;
					}
				}
			}
			if (defaultStyles.hasOwnProperty(styleName)){
				return(defaultStyles[styleName]);
			}
			return(null);
		}
	}
}