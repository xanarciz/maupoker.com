// $(document).ready(function(){
//   var mp3 = $('#mediaplayer');
//   mp3[0].pause();
// });

function playToggle(){
  var myAudio = document.getElementById('mediaplayer');
  var mp3 = $('#mediaplayer');

  $('#mediaplayer').stop();
  if (myAudio.duration > 0 && !myAudio.paused) {
    mp3[0].pause();
    $("#audioPlayToggle").html('<span class="fa-stack fa-lg"><i class="fa fa-circle fa-stack-2x"></i><i class="fa fa-play fa-stack-1x"></i></span>');
  } else {
    mp3[0].play();
    $("#audioPlayToggle").html('<span class="fa-stack fa-lg"><i class="fa fa-circle fa-stack-2x"></i><i class="fa fa-pause fa-stack-1x"></i></span>');
  }
}

setInterval(function(){ 
  $(".audio-title span").load('http://dewa.fm/play.php');
  if ($('.audio-title span').text().length > 15) {
    if (!$('.audio-title span').hasClass("m")) {
      $('.audio-title span').addClass('m');
      $('.audio-title span').wrap('<marquee>');
    }
  }else if($('.audio-title span').html() != "Dewa.FM"){
    $('.audio-title span').removeClass('m');
    $('.audio-title').html('<span></span>');
    $(".audio-title span").load('http://dewa.fm/play.php');
  }
}, 3000);

$("#chkChannel").change(function(e){
  var mp3 = $('#mediaplayer');
  e.stopPropagation();
  if ($(this).is(":checked")) {
    $('#mediaplayer').attr("src", "http://180.210.204.202:8090/;stream.mp3");
    mp3[0].load();
    mp3[0].play();
  }else {
    $('#mediaplayer').attr("src", "http://180.210.204.202:8030/;stream.mp3");
    mp3[0].load();
    mp3[0].play();
  }
  $("#audioPlayToggle").html('<span class="fa-stack fa-lg"><i class="fa fa-circle fa-stack-2x"></i><i class="fa fa-play fa-stack-1x"></i></span>');
});

// popup
$('.popup').click(function(event) {
  var width  = 575,
      height = 400,
      left   = ($(window).width()  - width)  / 2,
      top    = ($(window).height() - height) / 2,
      url    = this.href,
      opts   = 'status=1' +
               ',width='  + width  +
               ',height=' + height +
               ',top='    + top    +
               ',left='   + left;
  
  window.open(url, 'twitter', opts);

  return false;
});

// share twitter
var TWEET_URL = "https://twitter.com/intent/tweet";

$(".tweet").each(function() {
  var elem = $(this),
  // Use current page URL as default link
  url = encodeURIComponent(elem.attr("data-url") || document.location.href),
  // Use page title as default tweet message
  text = elem.attr("data-text") || document.title,
  via = elem.attr("data-via") || "",
  related = encodeURIComponent(elem.attr("data-related")) || "",
  hashtags = encodeURIComponent(elem.attr("data-hashtags")) || "";
  
  // Set href to tweet page
  elem.attr({
      href: TWEET_URL + "?hashtags=" + hashtags + "&original_referer=" +
              encodeURIComponent(document.location.href) + "&related=" + related +
              "&source=tweetbutton&text=" + text + "&url=" + url + "&via=" + via,
      target: "_blank"
  });
});

// facebook sdk
(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.6&appId=186588224713881";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));