// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.adobe.serialization.json
{
	public class JSONDecoder
	{
		private var value:*;
		private var tokenizer:com.adobe.serialization.json.JSONTokenizer;
		private var token:com.adobe.serialization.json.JSONToken;
		public function JSONDecoder(p__1:String)
		{
			tokenizer = new JSONTokenizer(p__1);
			nextToken();
			value = parseValue();
			
		}
		public function getValue()
		{
			return(value);
		}
		private function nextToken():com.adobe.serialization.json.JSONToken
		{
			return(token = tokenizer.getNextToken());
		}
		private function parseArray():Array
		{
			var l__1:Array = new Array();
			nextToken();
			if (token.type == JSONTokenType.RIGHT_BRACKET){
				return(l__1);
			}
			while(true){
				l__1.push(parseValue());
				nextToken();
				if (token.type == JSONTokenType.RIGHT_BRACKET){
					return(l__1);
				}
				if (token.type == JSONTokenType.COMMA){
					nextToken();
				} else {
					tokenizer.parseError("Expecting ] or , but found " + token.value);
				}
			}
			return(null);
		}
		private function parseObject():Object
		{
			var l__2:String;
			var l__1:Object = new Object();
			nextToken();
			if (token.type == JSONTokenType.RIGHT_BRACE){
				return(l__1);
			}
			while(true){
				if (token.type == JSONTokenType.STRING){
					l__2 = String(token.value);
					nextToken();
					if (token.type == JSONTokenType.COLON){
						nextToken();
						l__1[l__2] = parseValue();
						nextToken();
						if (token.type == JSONTokenType.RIGHT_BRACE){
							return(l__1);
						}
						if (token.type == JSONTokenType.COMMA){
							nextToken();
						} else {
							tokenizer.parseError("Expecting } or , but found " + token.value);
						}
					} else {
						tokenizer.parseError("Expecting : but found " + token.value);
					}
				} else {
					tokenizer.parseError("Expecting string but found " + token.value);
				}
			}
			return(null);
		}
		private function parseValue():Object
		{
			switch(token.type){
				case JSONTokenType.LEFT_BRACE:
				{
					return(parseObject());
				}
				case JSONTokenType.LEFT_BRACKET:
				{
					return(parseArray());
				}
				case JSONTokenType.STRING:
				{
				}
				case JSONTokenType.NUMBER:
				{
				}
				case JSONTokenType.TRUE:
				{
				}
				case JSONTokenType.FALSE:
				{
				}
				case JSONTokenType.NULL:
				{
					return(token.value);
				}
				default:
				{
					tokenizer.parseError("Unexpected " + token.value);
				}
			}
			return(null);
		}
	}
}