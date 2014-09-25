
$(document).ready(function() {
		 

if($(window).width() <= 568) {

/*Replace Colchian URL for Mobile*/	  
		  var url = $("#race_frame").attr('src');
		  var urlarray = url.split('=lafunda');
		  $('#race_frame').attr("src","https://wagering.lafunda.com.do/BOSSWagering/Racebook/MobileBetTaker?siteid=lafunda" + urlarray[1]);
		  //$('#race_frame').attr("src","http://www.colchian.eu/BOSS_DEMO/BOSSWagering/Racebook/MobileBetTaker/?SiteID=LaFunda&stoken=" + urlarray[1]);

} else {



  $('#race_frame').iFrameResize({
	  enablePublicMethods: true                  
  });
  
}

});// END DOCUMENT READY


