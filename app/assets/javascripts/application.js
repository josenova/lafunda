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
//= require heap
//= require bxslider
//= require placeholders.min
//= require iframeresizer.min

// require turbolinks



$(document).ready(function() {
	
/******************************************  MOBILE  **************************************************/

if($(window).width() <= 568) {

/*Height for cover layer*/		
	  $('#layer').css('height', $(window).height());

/*Replace Colchian URL for Mobile*/	  
	  if ($('#race_frame').length > 0) {
		  var url = $("#race_frame").attr('src');
		  var urlarray = url.split('=lafunda');
		  $('#race_frame').attr("src","https://wagering.lafunda.com.do/BOSSWagering/Racebook/MobileBetTaker?siteid=lafunda" + urlarray[1]);
		  //$('#race_frame').attr("src","http://www.colchian.eu/BOSS_DEMO/BOSSWagering/Racebook/MobileBetTaker/?SiteID=LaFunda&stoken=" + urlarray[1]);
	  }
	  if ($('#sport_frame').length > 0) {
		  var url = $("#sport_frame").attr('src');
		  var urlarray = url.split('=lafunda');
		  $('#sport_frame').attr("src","https://wagering.lafunda.com.do/BOSSWagering/Sportsbook/MobileBetTaker?siteid=lafunda" + urlarray[1]);
		  //$('#sport_frame').attr("src","http://www.colchian.eu/BOSS_DEMO/BOSSWagering/Sportsbook/MobileBetTaker/?SiteID=LaFunda&stoken=" + urlarray[1]);
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
	
/******************************** IFRAME RESIZER *************************************************/

  $('#lottery_frame').iFrameResize({
	  enablePublicMethods: true                  // Enable methods within iframe hosted page
  });
  
 
 
 /******************************** PASSWORD INPUT VALIDATE *************************************************/
 
		$('#new_user #user_password').keyup(function() {
	      var pswd = $(this).val();
		    //validate length
			  if ( pswd.length < 8 ) {
					$('#length').removeClass('valid').addClass('invalid');
			  } else {
					$('#length').removeClass('invalid').addClass('valid');
			  }
		    //validate letter
		  	if ( pswd.match(/[A-z]/) ) {
				$('#letter').removeClass('invalid').addClass('valid');
			} else {
				$('#letter').removeClass('valid').addClass('invalid');
			}
			
			//validate capital letter
			if ( pswd.match(/[A-Z]/) ) {
				$('#capital').removeClass('invalid').addClass('valid');
			} else {
				$('#capital').removeClass('valid').addClass('invalid');
			}
			
			//validate number
			if ( pswd.match(/\d/) ) {
				$('#number').removeClass('invalid').addClass('valid');
			} else {
				$('#number').removeClass('valid').addClass('invalid');
			}
			
		}).focus(function() {
			$('#pswd_info').show();
		}).blur(function() {
			$('#pswd_info').hide();
		});
		 
		 

/******************************* PAYMENT PROVIDERS ALERTS **************************************/

		$( "#providers #bank_transfer" ).click(function() {
		  alert( "Banco BHD\nCuenta: 15216080019\nNombre: Kingsley Edgecombe\n\nColoca en la nota de depósito tu nombre e email registrado con nosotros." );
		});
		
		$( "#providers #paypal" ).click(function() {
		  alert( "Cuenta: hfernandez@kinbar.com.do\nNombre: Kinbar International\n\nDepósitos\nColoca en la nota de depósito tu nombre (e email registrado con nosotros, en caso de no usarlo para realizar el depósito).\n\nRetiros\nSolícita tu retiro a hfernandez@kinbar.com.do. Solo se aceptarán solicitudes y se enviarán pagos a cuentas de email que estén registradas con nosotros. " );
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

