// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.adobe.serialization.json
{
	public class JSONTokenizer
	{
		private var loc:int;
		private var ch:String;
		private var obj:Object;
		private var jsonString:String;
		public function JSONTokenizer(p__1:String)
		{
			jsonString = p__1;
			loc = 0;
			nextChar();
		}
		public function getNextToken():com.adobe.serialization.json.JSONToken
		{
			var l__2:String;
			var l__3:String;
			var l__4:String;
			var l__1:com.adobe.serialization.json.JSONToken = new JSONToken();
			skipIgnored();
			switch(ch){
				case "{":
				{
					l__1.type = JSONTokenType.LEFT_BRACE;
					l__1.value = "{";
					nextChar();
					break;
				}
				case "}":
				{
					l__1.type = JSONTokenType.RIGHT_BRACE;
					l__1.value = "}";
					nextChar();
					break;
				}
				case "[":
				{
					l__1.type = JSONTokenType.LEFT_BRACKET;
					l__1.value = "[";
					nextChar();
					break;
				}
				case "]":
				{
					l__1.type = JSONTokenType.RIGHT_BRACKET;
					l__1.value = "]";
					nextChar();
					break;
				}
				case ",":
				{
					l__1.type = JSONTokenType.COMMA;
					l__1.value = ",";
					nextChar();
					break;
				}
				case ":":
				{
					l__1.type = JSONTokenType.COLON;
					l__1.value = ":";
					nextChar();
					break;
				}
				case "t":
				{
					l__2 = ((("t" + nextChar()) + nextChar()) + nextChar());
					if (l__2 == "true"){
						l__1.type = JSONTokenType.TRUE;
						l__1.value = true;
						nextChar();
					} else {
						parseError("Expecting \'true\' but found " + l__2);
					}
					break;
				}
				case "f":
				{
					l__3 = (((("f" + nextChar()) + nextChar()) + nextChar()) + nextChar());
					if (l__3 == "false"){
						l__1.type = JSONTokenType.FALSE;
						l__1.value = false;
						nextChar();
					} else {
						parseError("Expecting \'false\' but found " + l__3);
					}
					break;
				}
				case "n":
				{
					l__4 = ((("n" + nextChar()) + nextChar()) + nextChar());
					if (l__4 == "null"){
						l__1.type = JSONTokenType.NULL;
						l__1.value = null;
						nextChar();
					} else {
						parseError("Expecting \'null\' but found " + l__4);
					}
					break;
				}
				case "\"":
				{
					l__1 = readString();
					break;
				}
				default:
				{
					if (isDigit(ch) || (ch == "-")){
						l__1 = readNumber();
					} else {
						if (ch == ""){
							return(null);
						}
						parseError(("Unexpected " + ch) + " encountered");
					}
				}
			}
			return(l__1);
		}
		private function readString():com.adobe.serialization.json.JSONToken
		{
			var l__3:String;
			var l__4:int;
			var l__1:com.adobe.serialization.json.JSONToken = new JSONToken();
			l__1.type = JSONTokenType.STRING;
			var l__2:* = "";
			nextChar();
			while(!(ch == "\"") && !(ch == "")){
				if (ch == "\\"){
					nextChar();
					switch(ch){
						case "\"":
						{
							l__2 = (l__2 + "\"");
							break;
						}
						case "/":
						{
							l__2 = (l__2 + "/");
							break;
						}
						case "\\":
						{
							l__2 = (l__2 + "\\");
							break;
						}
						case "b":
						{
							l__2 = (l__2 + "\b");
							break;
						}
						case "f":
						{
							l__2 = (l__2 + "\f");
							break;
						}
						case "n":
						{
							l__2 = (l__2 + "\n");
							break;
						}
						case "r":
						{
							l__2 = (l__2 + "\r");
							break;
						}
						case "t":
						{
							l__2 = (l__2 + "\t");
							break;
						}
						case "u":
						{
							l__3 = "";
							l__4 = 0;
							while(l__4 < 4){
								if (!isHexDigit(nextChar())){
									parseError(" Excepted a hex digit, but found: " + ch);
								}
								l__3 = (l__3 + ch);
								l__4++;
							}
							l__2 = (l__2 + String.fromCharCode(parseInt(l__3, 16)));
							break;
						}
						default:
						{
							l__2 = (l__2 + ("\\" + ch));
						}
					}
				} else {
					l__2 = (l__2 + ch);
				}
				nextChar();
			}
			if (ch == ""){
				parseError("Unterminated string literal");
			}
			nextChar();
			l__1.value = l__2;
			return(l__1);
		}
		private function readNumber():com.adobe.serialization.json.JSONToken
		{
			var l__1:com.adobe.serialization.json.JSONToken = new JSONToken();
			l__1.type = JSONTokenType.NUMBER;
			var l__2:* = "";
			if (ch == "-"){
				l__2 = (l__2 + "-");
				nextChar();
			}
			if (!isDigit(ch)){
				parseError("Expecting a digit");
			}
			if (ch == "0"){
				l__2 = (l__2 + ch);
				nextChar();
				if (isDigit(ch)){
					parseError("A digit cannot immediately follow 0");
				}
			} else {
				while(isDigit(ch)){
					l__2 = (l__2 + ch);
					nextChar();
				}
			}
			if (ch == "."){
				l__2 = (l__2 + ".");
				nextChar();
				if (!isDigit(ch)){
					parseError("Expecting a digit");
				}
				while(isDigit(ch)){
					l__2 = (l__2 + ch);
					nextChar();
				}
			}
			if ((ch == "e") || (ch == "E")){
				l__2 = (l__2 + "e");
				nextChar();
				if ((ch == "+") || (ch == "-")){
					l__2 = (l__2 + ch);
					nextChar();
				}
				if (!isDigit(ch)){
					parseError("Scientific notation number needs exponent value");
				}
				while(isDigit(ch)){
					l__2 = (l__2 + ch);
					nextChar();
				}
			}
			var l__3:Number = Number(l__2);
			if (isFinite(l__3) && (!isNaN(l__3))){
				l__1.value = l__3;
				return(l__1);
			}
			parseError(("Number " + l__3) + " is not valid!");
			return(null);
		}
		private function nextChar():String
		{
			return(ch = jsonString.charAt(loc++));
		}
		private function skipIgnored():void
		{
			skipWhite();
			skipComments();
			skipWhite();
		}
		private function skipComments():void
		{
			if (ch == "/"){
				nextChar();
				switch(ch){
					case "/":
					{
						do {
							nextChar();
						} while (!(ch == "\n") && !(ch == ""))
						nextChar();
						break;
					}
					case "*":
					{
						nextChar();
						while(true){
							if (ch == "*"){
								nextChar();
								if (ch == "/"){
									nextChar();
									break;
								}
							} else {
								nextChar();
							}
							if (ch == ""){
								parseError("Multi-line comment not closed");
							}
						}
						break;
					}
					default:
					{
						parseError(("Unexpected " + ch) + " encountered (expecting \'/\' or \'*\' )");
					}
				}
			}
		}
		private function skipWhite():void
		{
			while(isWhiteSpace(ch)){
				nextChar();
			}
		}
		private function isWhiteSpace(p__1:String):Boolean
		{
			return(((p__1 == " ") || (p__1 == "\t")) || (p__1 == "\n"));
		}
		private function isDigit(p__1:String):Boolean
		{
			return(((p__1 >= "0") && (p__1 <= "9")));
		}
		private function isHexDigit(p__1:String):Boolean
		{
			var l__2:String = p__1.toUpperCase();
			return((isDigit(p__1) || ((l__2 >= "A") && (l__2 <= "F"))));
		}
		public function parseError(p__1:String):void
		{
			throw new JSONParseError(p__1, loc, jsonString);
		}
	}
}