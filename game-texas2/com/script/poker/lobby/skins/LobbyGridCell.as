// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.lobby.skins
{
	import fl.controls.listClasses.CellRenderer;
	import fl.core.UIComponent;
	import fl.controls.BaseButton;
	import fl.controls.LabelButton;
	import flash.display.InteractiveObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	
	public class LobbyGridCell extends fl.controls.listClasses.CellRenderer
	{
		public function LobbyGridCell():void
		{
		}
		override protected function drawBackground():void
		{
			setStyle("upSkin", lobbyGridCell_upSkin);
			setStyle("overSkin", lobbyGridCell_overSkin);
			setStyle("selectedOverSkin", lobbyGridCell_overSkin);
			setStyle("selectedUpSkin", lobbyGridCell_selectedSkin);
			setStyle("selectedDownSkin", lobbyGridCell_selectedSkin);
			setStyle("downSkin", lobbyGridCell_selectedSkin);
			super.drawBackground();
		}
		public static function getStyleDefinition():Object
		{
			return(CellRenderer.getStyleDefinition());
		}
	}
}