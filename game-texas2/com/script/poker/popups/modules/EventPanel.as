// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.popups.modules
{
	import flash.events.*;
	import flash.display.*;
	import com.script.poker.popups.events.*;
	import flash.text.*;
	import fl.data.DataProvider;
	import fl.controls.dataGridClasses.DataGridColumn;
	import fl.managers.StyleManager;
	import fl.events.DataGridEvent;
	import fl.events.DataGridEventReason;
	import fl.controls.DataGrid;
	import fl.managers.FocusManager;
	import fl.managers.FocusManager;
	import cellrenderer.MyCellRenderer;
	
	public class EventPanel extends flash.display.MovieClip
	{
		private var _start:String = "";
		private var _stop:String = "";
		private var evstart:*;
		private var evstop:*;
		private var evpoin:*;
		private var pause_txt:*;
		public var txtpaused:flash.display.MovieClip;
		public var mc_rule:flash.display.MovieClip;
		public var btn_rules:SimpleButton;
		public var btn_close_atas:SimpleButton;
		public var dg:fl.controls.DataGrid;
		public var evrule:String = "";
		//public var btnCreateCancel:com.script.poker.table.asset.PokerButton;
		//public var btnCreateAccept:com.script.poker.table.asset.PokerButton;
		private var _poin:Number = 0;
		
		public function EventPanel()
		{
		}
		public function preflight(p__1:*)
		{
			var l__4:* = p__1.font1;
			var l__5:* = new l__4();
			evstart = l__5.field;
			evstart.x = 69;
			evstart.y = 17;
			evstart.width = 100;
			evstart.height = 23;
			addChild(evstart);
			var l__6:* = new l__4();
			evstop = l__6.field;
			evstop.x = 234;
			evstop.y = 17;
			evstop.width = 100;
			evstop.height = 22;
			addChild(evstop);
			var l__8:* = new l__4();
			evpoin = l__8.field;
			evpoin.x = 69;
			evpoin.y = 57;
			evpoin.width = 100;
			evpoin.height = 24;
			addChild(evpoin);
			
			initListeners();
			//reset();
			
			//=============================
			
		}
		
		private function initListeners():void
		{
			mc_rule.visible = false;
			btn_rules.addEventListener(MouseEvent.CLICK, onShowRules);
			mc_rule.btnClose.addEventListener(MouseEvent.CLICK, onclose);
			btn_close_atas.addEventListener(MouseEvent.CLICK, onCloseEvent);

		}
		private function onShowRules(p__1:flash.events.MouseEvent = null):void
		{	
			
			mc_rule.visible = true;
			
		}
		private function onclose(p__1:flash.events.MouseEvent = null):void
		{	
			mc_rule.visible = false;
			
		}
		private function onCloseEvent(p__1:flash.events.MouseEvent = null):void
		{	
			this.visible = false;
			
		}
		private function onCreateCancel(p__1:flash.events.MouseEvent):void
		{
			dispatchEvent(new PPVEvent(PPVEvent.PRIVATE_TABLE_NO));
			//dispatchEvent(new TBEvent(TBEvent.BUYIN_CANCEL));
		}
		public function set eventstart(p__1:String)
		{
			evstart.text = p__1;
		}
		public function get eventstart()
		{
			return(evstart.text);
		}
		public function set eventstop(p__1:String)
		{
			evstop.text = p__1;
		}
		public function get eventstop()
		{
			return(evstop.text);
		}
		public function set eventpoin(p__1:String)
		{
			evpoin.text = p__1;
		}
		public function get eventpoin()
		{
			return(evpoin.text);
		}		
		public function set eventrule(p__1:String)
		{
			mc_rule.rules1.htmlText = p__1;
		}
		public function setTopWinner(p__1:Array, p__2:Array){
			var tabl = new Array();
			//selRoom = p__1[3]
			//isiTable = result;
			//roomItem = p__1;
			var j=1;
			for(var i=0;i<p__1.length;i++){
				
				
				tabl.push({No:j,UserId:p__1[i],Poin:p__2[i]});
				j++;
				
			}
			dg.removeAllColumns();
			dg.dataProvider = new DataProvider(tabl);
			dg.columns = ["No","UserId","Poin"];
			dg.getColumnAt(0).width = 45;			
			dg.getColumnAt(0).headerText = "No";
			dg.getColumnAt(1).headerText = "UserId";
			dg.getColumnAt(2).headerText = "Poin";
			
		}
		public function reset()
		{
			tbname.text = "";
			tbpass.text = "";
			err.text = "";
			tbsmall.text = "0";
			tbbig.text = "0";
			tbmax.text = "0";
		}
	}
}