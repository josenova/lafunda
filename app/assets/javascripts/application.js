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
	
/******************************************  MOBILE  **************************************************/
	
if($(window).width() <= 568) {

/*Height for divs*/		
	  $('#layer').css('height', $(window).height());
	  $('#main').css('min-height', $(window).height());

/*Replace Colchian URL for Mobile*/	  
	  if ($('#race_frame').length > 0) {
		  var url = $("#race_frame").attr('src');
		  var urlarray = url.split('stoken=');
		  //$('#race_frame').attr("src","http://wagering.lafunda.com.do/BOSSWagering/Racebook/MobileBetTaker?siteid=lafunda&stoken=" + urlarray[1]);
		  $('#race_frame').attr("src","http://www.colchian.eu/BOSS_DEMO/BOSSWagering/Racebook/MobileBetTaker/?SiteID=LaFunda&stoken=" + urlarray[1]);
		  $('#race_frame').height(568);
	  }
	  if ($('#sport_frame').length > 0) {
		  var url = $("#sport_frame").attr('src');
		  var urlarray = url.split('stoken=');
		  //$('#sport_frame').attr("src","http://wagering.lafunda.com.do/BOSSWagering/Sportsbook/MobileBetTaker?siteid=lafunda&stoken=" + urlarray[1]);
		  $('#sport_frame').attr("src","http://www.colchian.eu/BOSS_DEMO/BOSSWagering/Sportsbook/MobileBetTaker/?SiteID=LaFunda&stoken=" + urlarray[1]);
		  $('#sport_frame').height(568);
		  
	  }

/*Open hamburger menu function*/		
	$('#open_mobile_menu').click(function () {
	  $('#main').css('width', $('#main').width());
	  $('#all').toggleClass('open');
	  $('#layer').toggleClass('hidden');
	  $('#all').bind('touchmove', function(e){e.preventDefault()});
    });

/*Close hamburger menu function*/		
	$('#layer').click(function () {
	  $('#main').css('width', 'auto');
	  $('#all').toggleClass('open');
	  $('#layer').toggleClass('hidden');
	  $('#all').unbind('touchmove');
	 
	});

}

/************************************ MINI HEADER *****************************************/

		$(window).scroll(function () {
		if ($(this).scrollTop() > 210) {
			$("#miniheader").css( "margin-top", "0" );
		} else {
			$("#miniheader").css( "margin-top", "-64px" );
		}
	   });
 
/********************************** TAG MENU *******************************************/

	$('#tagarrow').click(function () {
	  $('#tagmenu').show();
   });

	$(document).mouseup(function() {
	  $("#tagmenu").hide();
   });


/*********************************** ACCORDION *********************************************/

	$(function() {
		$( ".accordion" ).accordion({
		  heightStyle: "content",
		  collapsible: true,
		  active: false
		});
	  });
	
	}); 