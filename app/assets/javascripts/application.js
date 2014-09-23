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

if($(window).width() <= 568) {

/*Height for cover layer*/		
	  $('#layer').css('height', $(window).height());

/*Open hamburger menu function*/		
	$('#open_mobile_menu').click(function () {
	  $('#main').css('width', $('#main').width());
	  $('#all').toggleClass('open');
	  $('#layer').toggleClass('hidden');
	  $('#all').bind('touchmove', function(e){e.preventDefault()});
    });

/*Close hamburger menu function*/		
	$('#layer').click(function () {	  
	  $('#all').toggleClass('open');
	  setTimeout( "$('#main').css('width', 'auto');",200 );
	  $('#layer').toggleClass('hidden');
	  $('#all').unbind('touchmove');
	 
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

