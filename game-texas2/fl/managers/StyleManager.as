// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package fl.managers
{
	import fl.core.*;
	import flash.utils.*;
	import flash.text.*;
	public class StyleManager
	{
		private var globalStyles:Object;
		private var classToDefaultStylesDict:flash.utils.Dictionary;
		private var styleToClassesHash:Object;
		private var classToStylesDict:flash.utils.Dictionary;
		private var classToInstancesDict:flash.utils.Dictionary;
		private static var _instance:fl.managers.StyleManager;
		public function StyleManager()
		{
			styleToClassesHash = {};
			classToInstancesDict = new flash.utils.Dictionary(true);
			classToStylesDict = new flash.utils.Dictionary(true);
			classToDefaultStylesDict = new flash.utils.Dictionary(true);
			globalStyles = fl.core.UIComponent.getStyleDefinition();
		}
		private static function getInstance()
		{
			if (_instance == null){
				_instance = new StyleManager();
			}
			return(_instance);
		}
		public static function registerInstance(instance:fl.core.UIComponent):void
		{
			var inst:fl.managers.StyleManager;
			var classDef:Class;
			var target:Class;
			var defaultStyles:Object;
			var styleToClasses:Object;
			var n:String;
			inst = getInstance();
			classDef = getClassDef(instance);
			if (classDef == null){
				return;
			}
			if (inst.classToInstancesDict[classDef] == null){
				inst.classToInstancesDict[classDef] = new flash.utils.Dictionary(true);
				target = classDef;
				while(defaultStyles == null){
					if (target["getStyleDefinition"] != null){
						defaultStyles = target["getStyleDefinition"]();
						break;
					}
					try {
						target = (instance.loaderInfo.applicationDomain.getDefinition(flash.utils.getQualifiedSuperclassName(target)) as Class);
					} catch (err:Error) {
						try {
							target = (flash.utils.getDefinitionByName(flash.utils.getQualifiedSuperclassName(target)) as Class);
						} catch (e:Error) {
							defaultStyles = fl.core.UIComponent.getStyleDefinition();
							break;
						}
					}
				}
				styleToClasses = inst.styleToClassesHash;
				for (n in defaultStyles){
					if (styleToClasses[n] == null){
						styleToClasses[n] = new flash.utils.Dictionary(true);
					}
					styleToClasses[n][classDef] = true;
				}
				inst.classToDefaultStylesDict[classDef] = defaultStyles;
				inst.classToStylesDict[classDef] = {};
			}
			inst.classToInstancesDict[classDef][instance] = true;
			setSharedStyles(instance);
		}
		private static function setSharedStyles(p__1:fl.core.UIComponent):void
		{
			var l__2:fl.managers.StyleManager;
			var l__3:Class;
			var l__4:Object;
			var l__5:String;
			l__2 = getInstance();
			l__3 = getClassDef(p__1);
			l__4 = l__2.classToDefaultStylesDict[l__3];
			for (l__5 in l__4){
				p__1.setSharedStyle(l__5, getSharedStyle(p__1, l__5));
			}
		}
		private static function getSharedStyle(p__1:fl.core.UIComponent, p__2:String):Object
		{
			var l__3:Class;
			var l__4:fl.managers.StyleManager;
			var l__5:Object;
			l__3 = getClassDef(p__1);
			l__4 = getInstance();
			l__5 = l__4.classToStylesDict[l__3][p__2];
			if (l__5 != null){
				return(l__5);
			}
			l__5 = l__4.globalStyles[p__2];
			if (l__5 != null){
				return(l__5);
			}
			return(l__4.classToDefaultStylesDict[l__3][p__2]);
		}
		public static function getComponentStyle(p__1:Object, p__2:String):Object
		{
			var l__3:Class;
			var l__4:Object;
			l__3 = getClassDef(p__1);
			l__4 = getInstance().classToStylesDict[l__3];
			return((l__4 == null) ? null : l__4[p__2]);
		}
		public static function clearComponentStyle(p__1:Object, p__2:String):void
		{
			var l__3:Class;
			var l__4:Object;
			l__3 = getClassDef(p__1);
			l__4 = getInstance().classToStylesDict[l__3];
			if (!(l__4 == null) && !(l__4[p__2] == null)){
				delete l__4[p__2];
				invalidateComponentStyle(l__3, p__2);
			}
		}
		public static function setComponentStyle(p__1:Object, p__2:String, p__3:Object):void
		{
			var l__4:Class;
			var l__5:Object;
			l__4 = getClassDef(p__1);
			l__5 = getInstance().classToStylesDict[l__4];
			if (l__5 == null){
				l__5 = getInstance().classToStylesDict[l__4] = {};
			}
			if (l__5 == p__3){
				return;
			}
			l__5[p__2] = p__3;
			invalidateComponentStyle(l__4, p__2);
		}
		private static function getClassDef(component:Object):Class
		{
			if (component is Class){
				return(component as Class);
			}
			try {
				return(flash.utils.getDefinitionByName(flash.utils.getQualifiedClassName(component)) as Class);
			} catch (e:Error) {
				if (component is fl.core.UIComponent){
					try {
						return(component.loaderInfo.applicationDomain.getDefinition(flash.utils.getQualifiedClassName(component)) as Class);
					} catch (e:Error) {
					}
				}
			}
			return(null);
		}
		private static function invalidateStyle(p__1:String):void
		{
			var l__2:flash.utils.Dictionary;
			var l__3:Object;
			l__2 = getInstance().styleToClassesHash[p__1];
			if (l__2 == null){
				return;
			}
			for (l__3 in l__2){
				invalidateComponentStyle(Class(l__3), p__1);
			}
		}
		private static function invalidateComponentStyle(p__1:Class, p__2:String):void
		{
			var l__3:flash.utils.Dictionary;
			var l__4:Object;
			var l__5:fl.core.UIComponent;
			l__3 = getInstance().classToInstancesDict[p__1];
			if (l__3 == null){
				return;
			}
			for (l__4 in l__3){
				l__5 = (l__4 as fl.core.UIComponent);
				if (l__5 == null){
				} else {
					l__5.setSharedStyle(p__2, getSharedStyle(l__5, p__2));
				}
			}
		}
		public static function setStyle(p__1:String, p__2:Object):void
		{
			var l__3:Object;
			l__3 = getInstance().globalStyles;
			if ((l__3[p__1] === p__2) && !(p__2 is flash.text.TextFormat)){
				return;
			}
			l__3[p__1] = p__2;
			invalidateStyle(p__1);
		}
		public static function clearStyle(p__1:String):void
		{
			setStyle(p__1, null);
		}
		public static function getStyle(p__1:String):Object
		{
			return(getInstance().globalStyles[p__1]);
		}
	}
}