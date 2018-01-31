(function($){$.fn.priceFormat=function(options){var defaults={prefix:'IDR ',centsSeparator:'',thousandsSeparator:'.',limit:12,centsLimit:0};var options=$.extend(defaults,options);return this.each(function(){var obj=$(this);var is_number=/[0-9]/;var prefix=options.prefix;var centsSeparator=options.centsSeparator;var thousandsSeparator=options.thousandsSeparator;var limit=options.limit;var centsLimit=options.centsLimit;function to_numbers(str){var formatted='';for(var i=0;i<(str.length);i++){char=str.charAt(i);if(formatted.length==0&&char==0)char=false;if(char&&char.match(is_number)){if(limit){if(formatted.length<limit)formatted=formatted+char;}else{formatted=formatted+char;}}}
return formatted;}
function fill_with_zeroes(str){while(str.length<(centsLimit+1))str='0'+str;return str;}
function price_format(str){var formatted=fill_with_zeroes(to_numbers(str));var thousandsFormatted='';var thousandsCount=0;var centsVal=formatted.substr(formatted.length-centsLimit,centsLimit);var integerVal=formatted.substr(0,formatted.length-centsLimit);formatted=integerVal+centsSeparator+centsVal;if(thousandsSeparator){for(var j=integerVal.length;j>0;j--){char=integerVal.substr(j-1,1);thousandsCount++;if(thousandsCount%3==0)char=thousandsSeparator+char;thousandsFormatted=char+thousandsFormatted;}
if(thousandsFormatted.substr(0,1)==thousandsSeparator)thousandsFormatted=thousandsFormatted.substring(1,thousandsFormatted.length);formatted=thousandsFormatted+centsSeparator+centsVal;}
if(prefix)formatted=prefix+formatted;return formatted;}
function key_check(e){var code=(e.keyCode?e.keyCode:e.which);var typed=String.fromCharCode(code);var functional=false;var str=obj.val();var newValue=price_format(str+typed);if(code>=96&&code<=105)functional=true;if(code==8)functional=true;if(code==9)functional=true;if(code==13)functional=true;if(code==37)functional=true;if(code==39)functional=true;if(!functional){e.preventDefault();e.stopPropagation();if(str!=newValue)obj.val(newValue);}}
function price_it(){var str=obj.val();var price=price_format(str);if(str!=price)obj.val(price);}
$(this).bind('keydown',key_check);$(this).bind('keyup',price_it);if($(this).val().length>0)price_it();});};})(jQuery);