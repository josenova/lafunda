
$(document).ready(function() {
		 

if($(window).width() <= 768) {

/*Replace Colchian URL for Mobile*/	  	 
		  var url = $("#sport_frame").attr('src');
		  var urlarray = url.split('=lafunda');
		  $('#sport_frame').attr("src","https://wagering.lafunda.com.do/BOSSWagering/Sportsbook/MobileBetTaker?siteid=lafunda" + urlarray[1]);
		  //$('#sport_frame').attr("src","http://www.colchian.eu/BOSS_DEMO/BOSSWagering/Sportsbook/MobileBetTaker/?SiteID=LaFunda&stoken=" + urlarray[1]);


} else {



  $('#sport_frame').iFrameResize({
	  enablePublicMethods: true                  
  });
  
}
 

});// END DOCUMENT READY


