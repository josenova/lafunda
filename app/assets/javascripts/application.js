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

/************************************ MINI HEADER *****************************************/


$(document).ready(function(){

	$(window).scroll(function () {
	if ($(this).scrollTop() > 210) {
		$("#miniheader").css( "margin-top", "0" );
	} else {
		$("#miniheader").css( "margin-top", "-74px" );
	}
   });
});    


/********************************** TAG MENU *******************************************/

$(document).ready(function(){

	$('#tagarrow').click(function () {
	  event.preventDefault();
	  $('#tagmenu').css("display", "inline-block");
   });

	$(document).mouseup(function() {
	  		if ($("#tagmenu").is(':visible')) {
				$("#tagmenu").hide();
			}
   });

});    

/********************************************************************************/

$(document).ready(function(){

$(function() {
    $( ".accordion" ).accordion({
      heightStyle: "content",
	  collapsible: true,
	  active: false
    });
  });

}); 