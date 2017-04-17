// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.lobby
{
	public dynamic class DataGridRoomItem
	{
		public function DataGridRoomItem(p__1:com.script.poker.lobby.RoomItem, p__2:Boolean)
		{
			var l__3:Number = 0;
			if (p__2){
				if (p__1._status == "1") {
					this["Status"] = "Open";
				}
				else {
					this["Status"] = "Close";
				}
				this["Max"] = gridComma(p__1.maxBuyin);
				this["Min"] = gridComma(p__1.bigBlind * 20);
				this["Players"] = ((p__1.players + " / ") + p__1.maxPlayers);
				this["sitPlayers"] = int(p__1.players);
				this["maxPlayers"] = int(p__1.maxPlayers);
				this["Stakes"] = ((p__1.smallBlind + " / ") + p__1.bigBlind);
				this["smallBlind"] = Number(p__1.smallBlind);
				this["bigBlind"] = Number(p__1.bigBlind);
				this["Room"] = p__1.roomName;
				this["ID"] = p__1.id;
				this["NO"] = p__1.no;
				//this["Jackpot"] = p__1.jackpot;
			} else {
				if ((p__1.status == 1) || (p__1.status == true)){
					this["Status"] = "Running";
				} else {
					this["Status"] = "Register";
				}
				this["Players"] = ((p__1.players + " / ") + p__1.maxPlayers);
				this["sitPlayers"] = int(p__1.players);
				this["maxPlayers"] = int(p__1.maxPlayers);
				this["Fee"] = ((p__1.entryFee + " + ") + p__1.hostFee);
				this["entryFee"] = p__1.entryFee;
				this["hostFee"] = p__1.hostFee;
				this["Room"] = p__1.roomName;
				this["ID"] = p__1.id;
				this["NO"] = p__1.no;
				//this["Jackpot"] = p__1.jackpot;
			}
		}
		
		public function gridComma(number) {
			number = ''+number;
			var minus;
			var dec;
			if(number < 0) { 
				minus = number.substr(0,1);
				number = ''+number.substr(1);
			}else{
				minus = '';
				number = ''+number;
			}	
			if(number.indexOf(".") != -1){
				dec = number.substring(number.indexOf("."),number.indexOf(".")+3);
				number = number.substring(0,number.indexOf("."));
				
				if(dec.length <= 2) dec += "0";
			}else{
				dec = '';
			}
			if (number.length>3) {
				var mod = number.length%3;
				var output = (mod>0 ? (number.substring(0, mod)) : '');
				for (i=0; i<Math.floor(number.length/3); i++) {
					if ((mod == 0) && (i == 0)) {
						output += number.substring(mod+3*i, mod+3*i+3);
					} else {
						output += ','+number.substring(mod+3*i, mod+3*i+3);
					}
				}
				return (minus+output+dec);
			} else {
				return minus+number+dec;
			}
		}

	}
}