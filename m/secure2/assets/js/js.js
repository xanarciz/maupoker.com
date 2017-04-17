jQuery(document).ready(function(){
	
	init();
});
var config={x:0,y:0,blur:20,color:'#000000'};
init=function(){
	jQuery(".thumbs").fadeTo("fast", 0.75);	
	jQuery(".thumbs").hover(
		function(){
		
			jQuery(this).fadeTo("fast", 1);
		},
		function(){
			
			jQuery(this).fadeTo("slow", 0.75);
		}
	);
	/*
	jQuery(".tooltip[title],.tooltipB[title]").tipsy({
		gravity: 'n',
		html: true
	});
	*/
	jQuery(".dropshadow").each(function(){
		jQuery(this).css('-webkit-box-shadow',config.x+'px '+config.y+'px '+config.blur+'px '+config.color);
		jQuery(this).css('-moz-box-shadow',config.x+'px '+config.y+'px '+config.blur+'px '+config.color);
	});
	/*jQuery.nyroModalSettings({
		showBackground: function(elts, settings, callback){
			elts.bg.css({opacity:0}).fadeTo(500, 0.5, callback);
		},
		showContent: function(elts, settings, callback){
			elts.loading
				.css({
					marginTop: settings.marginTopLoading+'px',
					marginLeft: settings.marginLeftLoading+'px'
				})
				.show()
				.animate({
					width: settings.width+'px',
					height: settings.height+'px',
					marginTop: settings.marginTop+'px',
					marginLeft: settings.marginLeft+'px'
				}, {duration: 350, complete: function() {
					elts.contentWrapper
						.css({
							width: settings.width+'px',
							height: settings.height+'px',
							marginTop: settings.marginTop+'px',
							marginLeft: settings.marginLeft+'px'
						})
						.show();
						elts.loading.fadeOut(200, callback);
					}
				});
		},
		hideContent: function(elts, settings, callback){
			elts.contentWrapper.animate({opacity:"0"}, {duration: 0, complete: function() {
				elts.contentWrapper.hide();
				callback();
			}})
		},
		minWidth: 20,
		minHeight: 20,
		closeButton: '<a href="#" class="nyroModalClose" id="closeBut" title="close"></a>',
		padding: 0,
		bgColor: "#000000",
		modal: true
	});
	jQuery(".popup").nyroModal({
		modal: false
	});
	jQuery(".popup_modal").nyroModal({
		bgColor: "#ffffff",
		modal: true
	});*/
}



/*DIALOGS*/
opendialog=function(param){
	var loader=param.loader;
	var width=param.width || "auto";
	var temp_date=new Date();
	var temp_id="dialog_"+jQuery.trim((((1+Math.random())*0x10000)|0).toString(16).substring(1));
	jQuery("body").append("<div class='dialog' id='"+temp_id+"'></div>");
	jQuery("#"+loader).html(loader_img);
	if(param.url!=null){
		jQuery.get(param.url, function(data){
			jQuery("#"+temp_id).append(data).dialog({
				title: param.title || jQuery("#"+temp_id+" h1.title").html(),
				open: function(){
					jQuery("#"+loader).html("");
					jQuery("#"+temp_id+" h1.title").hide();
					if(param.open!=null){ param.open(); }
				},
				close: function(){
					jQuery(this).empty().remove();
					if(param.close!=null){ param.close(); }
				},
		   		modal: false,
				minHeight: 25,
				minWidth: 25,
				resizable: false,
				autoResize: true,
				width: width
			}).append("<div style='display:none;' id='temp_id'>"+temp_id+"</div>");
		});
	}else{
		jQuery("#"+temp_id).append(param.content).dialog({
			title: param.title || jQuery("#"+temp_id+" div.title").html(),
			open: function(){
				jQuery("#"+loader).html("");
				if(param.open!=null){ param.open(); }
			},
			close: function(){
				jQuery(this).empty().remove();
				if(param.close!=null){ param.close(); }
			},
			modal: true,
			minHeight: 25,
			minWidth: 25,
			resizable: false,
			autoResize: true,
			buttons: {
				"Ok": function(){
					jQuery(this).dialog("close");
				}
			},
			width: width
		});
	}
}
closedialog=function(obj){
	/*
	if(obj==null){obj="dummy";}
	jQuery("#"+obj).animate({opacity:1.0},1500,function(){
		jQuery.nyroModalRemove();
	});
	*/
	//jQuery.nyroModalRemove();
}



/*AJAX URL & FORM*/
setform=function(form,target,loader,fn){
	jQuery("#"+form).ajaxForm({
		target:"#"+target,
		beforeSubmit:function(){
			jQuery("#"+target).html("");
			jQuery("#"+loader).html(loader_img);
		},
		success:function(r){
			jQuery("#"+loader).html("");
			init();
			if(fn!=null){fn(r);}
		}
	});
}
request=function(url,obj,loader,fn){
	if(!loader){loader=obj;}
	if(!obj){obj="contentbox";}
	jQuery("#"+loader).html(loader_img);
	jQuery.get(url,function(res){
		jQuery("#"+loader).html("");
		jQuery("#"+obj).html(res);
		init();
		if(fn!=null){fn();}
	});
}



/*TABLE FIX*/
fixtable=function(table, cellpadding){
	var bgcolor="#f5f5f5";
	var cellpad=cellpadding || 7;
	jQuery(table).attr({
		"cellpadding": cellpad,
		"cellspacing": "0",
		"border": "0",
		"bgcolor": "#cacaca"
	});
	jQuery(table+" thead tr:first").addClass("ui-widget-header");
	jQuery(table+" tfoot tr:first").addClass("ui-widget-header");
	jQuery(table+" tbody tr:even").css({
		"background-color": bgcolor
	});
	jQuery(table+" tbody tr:odd").css({
		"background-color": "#ffffff"
	});
}



/*CUSTOM POPUP*/
jQuery(document).ready(function(){
	jQuery("body").append("<div id='uialert' style='position: fixed; top: 5%; left: 50%; display: none; z-index: 100000; border: 1px solid #ffffff; background: #FFE653; color: #000000; padding: 20px; font-size: 14px; line-height: 1.5em; -moz-border-radius: 5px; -webkit-border-radius: 5px; -khtml-border-radius: 5px; border-radius: 5px; '></div>");
})
uialert=function(msg, onclose) {
	jQuery("#uialert").html(msg).css({
		"left":"50%",
		"top":"5%",
		"marginLeft": "-"+Math.floor((jQuery("#uialert").width()/2)+20)+"px",
		"marginTop": "-"+Math.floor(jQuery("#uialert").height()/2)+"px"
	}).fadeIn();
	setTimeout(
		function(){
			jQuery('#uialert').fadeOut();
			if(onclose!=null){ onclose(); }
		}, 3000
	);
}



/*LIMIT CHARS*/
limitchars=function(textid, limit, infodiv){
	var text=jQuery("#"+textid).val();
	var textlength=text.length;
	if(textlength>limit){
		jQuery("#"+infodiv).html("0");
		jQuery("#"+textid).val(text.substr(0,limit));
		return false;
	}else{
		jQuery("#"+infodiv).html(limit-textlength);
		return true;
	}
}
countchars=function(textid, infodiv){
	var text=jQuery("#"+textid).val();
	var textlength=text.length;
	jQuery("#"+infodiv).html(textlength+" / "+parseInt(((textlength/160))+1)+" sms");
}
