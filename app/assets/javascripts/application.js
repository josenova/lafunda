// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
// require jquery.turbolinks
//= require jquery_ujs

//= require_tree .
//= require jquery.ui.accordion

// require turbolinks



$(document).ready(function() {
	if($(window).width() < 480) {
	  if ($('#race_frame').length > 0) {
		  var url = $("#race_frame").attr('src');
		  var urlarray = url.split('stoken=');
		  $('#race_frame').attr("src","http://wagering.lafunda.com.do/BOSSWagering/Racebook/MobileBetTaker?siteid=lafunda&stoken=" + urlarray[1]);
	  }
	  if ($('#sport_frame').length > 0) {
		  var url = $("#sport_frame").attr('src');
		  var urlarray = url.split('stoken=');
		  $('#sport_frame').attr("src","http://wagering.lafunda.com.do/BOSSWagering/Sportsbook/MobileBetTaker?siteid=lafunda&stoken=" + urlarray[1]);
	  }
	}
});
/************************************ MINI HEADER *****************************************/


$(document).ready(function(){
//	if($(window).width() > 480) {
		$(window).scroll(function () {
		if ($(this).scrollTop() > 210) {
			$("#miniheader").css( "margin-top", "0" );
		} else {
			$("#miniheader").css( "margin-top", "-74px" );
		}
	   });
//	}
});    


/********************************** TAG MENU *******************************************/

$(document).ready(function(){

	$('#tagarrow').click(function () {
	  $('#tagmenu').show();
   });

	$(document).mouseup(function() {
	  $("#tagmenu").hide();
   });

});    

/********************************** MOBILE SIGN IN *******************************************/

$(document).ready(function(){

	$('#mobilesignin').click(function () {
	  $('#topright').show();
    });
	
	var mainheight = $('#main').height()
	$('#mobile_menu').css('height', mainheight);
	$('#open_mobile_menu').click(function () {
	  $('#main').toggleClass( "open" );
    });
	

});    

/*********************************** ACCORDION *********************************************/

$(document).ready(function(){

$(function() {
    $( ".accordion" ).accordion({
      heightStyle: "content",
	  collapsible: true,
	  active: false
    });
  });

}); 