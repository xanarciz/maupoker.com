// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.popups.modules
{
	import flash.events.*;
	import flash.display.*;
	import com.script.poker.table.asset.*;
	import com.script.poker.popups.events.*;
	import flash.text.*;
	import fl.controls.RadioButton;
	import fl.controls.RadioButtonGroup;

	public class CreateTable extends flash.display.MovieClip
	{
		private var _big:Number = 0;
		private var _small:Number = 0;
		public var tbname:*;
		public var tbbig:*;
		public var tbsmall:*;
		private var passStyle:flash.text.TextFormat;
		//public var btnCreateCancel:com.script.poker.table.asset.PokerButton;
		//public var btnCreateAccept:com.script.poker.table.asset.PokerButton;
		private var _max:Number = 0;
		private var _name:String;
		public var pipe:*;
		private var _pass:String;
		public var err:*;
		public var ket1:*;
		public var tbmax:*;
		private var regStyle:flash.text.TextFormat;
		public var tbpass:*;
		public var txtname:*;
		public var txtpass:*;
		public var txtblind:*;
		public var txtblind2:*;
		public var langs;
		public function CreateTable()
		{
		}
		public function preflight(p__1:*)
		{
			var l__2:* = p__1.font1;
			var l__3:* = new l__2();
			err = l__3.field;
			err.x = 292;
			err.y = 204;
			err.width = 136;
			err.height = 100;
			addChild(err);
			
			txtname.text = langs.l_tabname
			txtpass.text = langs.l_password
			txtblind.text = langs.l_smallblind
			txtblind2.text = langs.l_bigblind
			
			var l__4:* = p__1.input2;
			var l__5:* = new l__4();
			tbname = l__5.field;
			tbname.x = 175;
			tbname.y = 25;
			tbname.width = 213;
			tbname.height = 23;
			addChild(tbname);
			var l__6:* = new l__4();
			tbpass = l__6.field;
			tbpass.x = 175;
			tbpass.y = 57;
			tbpass.width = 213;
			tbpass.height = 22;
			addChild(tbpass);
			var l__7:* = p__1.input3;
			var l__8:* = new l__4();
			tbsmall = l__8.field;
			tbsmall.x = 155;
			tbsmall.y = 115;
			tbsmall.width = 67;
			tbsmall.height = 24;
			addChild(tbsmall);
			var l__9:* = new l__4();
			tbbig = l__9.field;
			tbbig.x = 327;
			tbbig.y = 115;
			tbbig.width = 67;
			tbbig.height = 24;
			addChild(tbbig);
			var l__10:* = new l__4();
			tbmax = l__10.field;
			tbmax.x = 375;
			tbmax.y = 169;
			tbmax.width = 67;
			tbmax.height = 24;
			addChild(tbmax);
			tbmax.visible=false;
			var l__12:* = p__1.myriad;
			btnCreateAccept = new PokerButton(l__12, "large", "Create", null, 125, 5);
			btnCreateCancel = new PokerButton(l__12, "large", "Cancel", null, 125, 5);
			btnCreateAccept.x = 230;
			btnCreateCancel.x = 95;
			btnCreateAccept.y = 300;
			btnCreateCancel.y = 300;
			addChild(btnCreateAccept);
			addChild(btnCreateCancel);
			initListeners();
			
			tbpass.displayAsPassword = true;
			tbname.maxChars = 15;
			tbsmall.maxChars = 10;
			tbsmall.restrict = "0-9";
			tbbig.restrict = "0-9";
			tbbig.type = "dynamic";
			tbmax.maxChars = 1;
			tbmax.restrict = "0-9";
			tbsmall.addEventListener(flash.events.FocusEvent.FOCUS_IN, onSmallFocus);
			reset();
			
			var ketGroup:RadioButtonGroup = new RadioButtonGroup("costGroup");

			
			/*ket0 = new RadioButton();
			ket0.group = ketGroup;
			//ket1.label = "Option A";
			ket0.value = 0;
			ket0.move(20, 164);
			addChild(ket0);*/
			
			ket1 = new RadioButton();
			ket1.group = ketGroup;
			//ket1.label = "Option A";
			ket1.value = 1;
			ket1.move(20, 164);
			addChild(ket1);
			
			ket2 = new RadioButton();
			ket2.group = ketGroup;
			//ket1.label = "Option A";
			ket2.value = 2;
			ket2.move(20, 185);
			addChild(ket2);
			
			ket3 = new RadioButton();
			ket3.group = ketGroup;
			//ket1.label = "Option A";
			ket3.value = 3;
			ket3.move(20, 206);
			addChild(ket3);
			
			ket4 = new RadioButton();
			ket4.group = ketGroup;
			//ket1.label = "Option A";
			ket4.value = 4;
			ket4.move(20, 227);
			addChild(ket4);
			
			ket5 = new RadioButton();
			ket5.group = ketGroup;
			//ket1.label = "Option A";
			ket5.value = 5;
			ket5.move(20, 248);
			addChild(ket5);
			
			ket6 = new RadioButton();
			ket6.group = ketGroup;
			//ket1.label = "Option A";
			ket6.value = 6;
			ket6.move(20, 269);
			addChild(ket6);
			
			//=============================
			
			var l__22:* = p__1.font1;
			var l__23:* = new l__22();
			ket1a = l__23.field;
			ket1a.x = 170;
			ket1a.y = 164;
			ket1a.width = 95;
			ket1a.height = 20;
			addChild(ket1a);
			
			ket1a.text = ": 10.000.000"
			
			var l__26:* = p__1.font1;
			var l__27:* = new l__26();
			ket2a = l__27.field;
			ket2a.x = 170;
			ket2a.y = 185;
			ket2a.width = 95;
			ket2a.height = 20;
			addChild(ket2a);
			
			ket2a.text = ": 10.000.000"
			
			var l__30:* = p__1.font1;
			var l__31:* = new l__30();
			ket3a = l__31.field;
			ket3a.x = 170;
			ket3a.y = 206;
			ket3a.width = 95;
			ket3a.height = 20;
			addChild(ket3a);
			
			ket3a.text = ": 10.000.000"
			
			var l__34:* = p__1.font1;
			var l__35:* = new l__34();
			ket4a = l__35.field;
			ket4a.x = 170;
			ket4a.y = 227;
			ket4a.width = 95;
			ket4a.height = 20;
			addChild(ket4a);
			
			ket4a.text = ": 10.000.000"
			
			var l__38:* = p__1.font1;
			var l__39:* = new l__38();
			ket5a = l__39.field;
			ket5a.x = 170;
			ket5a.y = 248;
			ket5a.width = 95;
			ket5a.height = 20;
			addChild(ket5a);
			
			ket5a.text = ": 10.000.000"
			
			var l__42:* = p__1.font1;
			var l__43:* = new l__42();
			ket6a = l__43.field;
			ket6a.x = 170;
			ket6a.y = 269;
			ket6a.width = 95;
			ket6a.height = 20;
			addChild(ket6a);
			
			ket6a.text = ": 10.000.000"
			
			ket1.selected = true
			
			/*
			var l__20:* = p__1.font1;
			var l__21:* = new l__20();
			ket0 = l__21.field;
			ket0.x = 50;
			ket0.y = 164;
			ket0.width = 120;
			ket0.height = 20;
			addChild(ket0);
			
			ket0.text = "7 Hari (1 Minggu)"
			
			
			//=================================
			var l__24:* = p__1.font1;
			var l__25:* = new l__24();
			ket1 = l__25.field;
			ket1.x = 50;
			ket1.y = 185;
			ket1.width = 120;
			ket1.height = 20;
			addChild(ket1);
			
			ket1.text = "7 Hari (1 Minggu)"
			
			
			//=================================
			var l__28:* = p__1.font1;
			var l__29:* = new l__28();
			ket2 = l__29.field;
			ket2.x = 50;
			ket2.y = 206;
			ket2.width = 120;
			ket2.height = 20;
			addChild(ket2);
			
			ket2.text = "7 Hari (1 Minggu)"
			
			
			
			var l__32:* = p__1.font1;
			var l__33:* = new l__32();
			ket3 = l__33.field;
			ket3.x = 50;
			ket3.y = 227;
			ket3.width = 120;
			ket3.height = 20;
			addChild(ket3);
			
			ket3.text = "7 Hari (1 Minggu)"
			
			
			//===========================
			var l__36:* = p__1.font1;
			var l__37:* = new l__36();
			ket4 = l__37.field;
			ket4.x = 50;
			ket4.y = 248;
			ket4.width = 120;
			ket4.height = 20;
			addChild(ket4);
			
			ket4.text = "7 Hari (1 Minggu)"
			
			
			//===============
			var l__40:* = p__1.font1;
			var l__41:* = new l__40();
			ket5 = l__41.field;
			ket5.x = 50;
			ket5.y = 269;
			ket5.width = 120;
			ket5.height = 20;
			addChild(ket5);
			
			ket5.text = "7 Hari (1 Minggu)"
			
			
			*/
			
		}
		
		private function initListeners():void
		{
			btnCreateAccept.addEventListener(MouseEvent.CLICK, onCreateAccept);
			btnCreateCancel.addEventListener(MouseEvent.CLICK, onCreateCancel);
		}
		private function onCreateAccept(p__1:flash.events.MouseEvent = null):void
		{	
			dispatchEvent(new PPVEvent(PPVEvent.PRIVATE_TABLE_YES));
			
		}
		private function onCreateCancel(p__1:flash.events.MouseEvent):void
		{
			dispatchEvent(new PPVEvent(PPVEvent.PRIVATE_TABLE_NO));
			//dispatchEvent(new TBEvent(TBEvent.BUYIN_CANCEL));
		}
		private function onSmallFocus(p__1:flash.events.FocusEvent)
		{
			tbsmall.addEventListener(flash.events.KeyboardEvent.KEY_UP, catchKeyup);
		}
		public function catchKeyup(p__1:flash.events.KeyboardEvent):void
		{
			if ((!isNaN(Number(tbsmall.text))) && (tbsmall.text.length > 0)){
				tbbig.text = String(Number(tbsmall.text) * 2);
			} else {
				tbsmall.text = "1";
				tbbig.text = "2";
			}
		}
		public function setPassFocus():void
		{
			tbpass.stage.focus = tbpass;
		}
		public function setSmallFocus():void
		{
			tbsmall.stage.focus = tbsmall;
		}
		public function setNameFocus():void
		{
			tbname.stage.focus = tbname;
		}
		public function setMaxFocus():void
		{
			tbmax.stage.focus = tbmax;
		}
		public function set tablename(p__1:String)
		{
			tbname.text = p__1;
		}
		public function get tablename()
		{
			return(tbname.text);
		}
		public function set tablepassword(p__1:String)
		{
			tbpass.text = p__1;
		}
		public function get tablepassword()
		{
			return(tbpass.text);
		}
		public function set small(p__1:String)
		{
			tbsmall.text = p__1;
		}
		public function get small()
		{
			return(tbsmall.text);
		}
		public function set large(p__1:String)
		{
			tbbig.text = p__1;
		}
		public function get large()
		{
			return(tbbig.text);
		}
		public function set max(p__1:String)
		{
			tbmax.text = p__1;
		}
		public function get max()
		{
			return(tbmax.text);
		}
		public function set errMsg(p__1:String)
		{
			err.text = p__1;
		}
		public function set costMsg(p__1:Array)
		{
			/*for(var c=0; c<p__1.length; c++) {
			
				this["ket"+c].text = p__1[c].ket;
				this["ket"+c+"a"].text = ": "+StringUtility.StringToMoney(p__1[c].cost);
			}*/
			ket1.label = p__1[0].ket;
			ket1a.text = ": "+p__1[0].cost;
			
			ket2.label = p__1[1].ket;
			ket2a.text = ": "+p__1[1].cost;
			
			ket3.label = p__1[2].ket;
			ket3a.text = ": "+p__1[2].cost;
			
			ket4.label = p__1[3].ket;
			ket4a.text = ": "+p__1[3].cost;
			
			ket5.label = p__1[4].ket;
			ket5a.text = ": "+p__1[4].cost;
			
			ket6.label = p__1[5].ket;
			ket6a.text = ": "+p__1[5].cost;
		}
		public function get costMsg()
		{
			return(err.text);
		}
		public function get errMsg()
		{
			return(err.text);
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