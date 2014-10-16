
$(document).ready(function() {
		 

if($(window).width() <= 768) {

/*Replace Colchian URL for Mobile*/	  
		  var url = $("#casino_frame").attr('src');
		  //var urlarray = url.split('=lafunda');
		  $('#casino_frame').attr("src","https://wagering.lafunda.com.do/BOSSWagering/Casino/InternetGaming?siteID=mobile&ssc=1014");
		  //$('#race_frame').attr("src","http://www.colchian.eu/BOSS_DEMO/BOSSWagering/Racebook/MobileBetTaker/?SiteID=LaFunda&stoken=" + urlarray[1]);

} else {



  $('#casino_frame').iFrameResize({
	  enablePublicMethods: true                  
  });
  
}

});// END DOCUMENT READY


