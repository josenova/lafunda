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

// require_tree .
//= require jquery.ui.accordion
//= require heap
//= require ganalytics
//= require bxslider
//= require placeholders.min
//= require iframeresizer.min

// require turbolinks


$(document).ready(function() {
	
/******************************************  MOBILE  **************************************************/

if($(window).width() <= 1024) {

/*Open/Close hamburger menu function*/	
	var status = 0;	
	$('#open_mobile_menu').click(function () {
		if (status == 0) {
		 	$('#mobile_menu').css('display', 'block');
		  	$('#miniheader').css({'position' : 'relative', 'position' : 'absolute', 'background' : 'transparent'});
			$('#main').css('paddingTop', '0px');
			status++;
		}
		else {
	  		$('#miniheader').css({'position' : 'fixed', 'background' : '#030303'});
	  		$('#mobile_menu').css('display', 'none');
			$('#main').css('paddingTop', '64px');
			status=0;
		}
	});


}

/************************************ MINI HEADER *****************************************/
/*
	$(window).scroll(function () {
	if ($(this).scrollTop() > 210) {
		$("#miniheader").css( "margin-top", "0" );
	} else {
		$("#miniheader").css( "margin-top", "-59px" );
	}
   });
*/
/********************************* MAIN DIV HEIGHT **************************************/
	  
   divResize();	
 
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
	

 
}); // END DOCUMENT READY


 /******************************** MAIN DIV RESIZER *************************************************/ 


	function divResize() {
	  $('#main').css('min-height', $(window).height());
	}
	
	$(window).bind('resize', function () { 
    	setTimeout(function(){
      		divResize();
		},150);	
	});


 /******************************** MOBILE SAFARI IN STANDALONE *************************************************/ 

if(("standalone" in window.navigator) && window.navigator.standalone){
	$( document ).on(
    "click",
    "a",
		function( event ){
			event.preventDefault();
			location.href = $( event.target ).attr( "href" );
		}
	);
}