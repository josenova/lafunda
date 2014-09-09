
$(document).ready(function() {
	
  /*************************************** START SLIDER *************************************************/

              $('.bxslider').bxSlider();
	
 /******************************** GET LOTTO WINNING NUMBERS *************************************************/

	
	$.ajax({
	  type:'GET',
	  url: 'https://lottery.lafunda.com.do/Lottery/WinningNumbers?key=664cf843-8904-4212-9503-d4733651f519&gobackdays=1&grouped=true',
	  accept: 'application/json',  
	  dataType: 'json',
	  success: function(data) {
		
		var recent_date = new Date(data[0].ClosesOn);
		var date_before = new Date();
		date_before.setDate(recent_date.getDate() - 1);
		
		var slim_recent_date = recent_date.toString().slice(4,-50);
		var slim_date_before = date_before.toString().slice(4,-50);
		
		$('.lotto_info').append('<li class="date">' + slim_recent_date + '</li>');		
		for (var i = 0; i < data.length; i++) { 
			var close_date = new Date(data[i].ClosesOn);
			if (close_date.setHours(0, 0, 0, 0) == recent_date.setHours(0, 0, 0, 0)) {
    			$('.lotto_info').append('<li class="lotto_house"><span class="lotto_name">' + data[i].HouseName + '</span><span class="lotto_numbers">' + data[i].Drawings[0].PostedNumbers.replace(/\D/g,'') + ' / ' + data[i].Drawings[1].PostedNumbers.replace(/\D/g,'') + ' / ' + data[i].Drawings[2].PostedNumbers.replace(/\D/g,'') + '</span></li>');			
			}
		}
			
		$('.lotto_info').append('<li class="date">' + slim_date_before + '</li>');
		for (var i = 0; i < data.length; i++) { 
			var close_date = new Date(data[i].ClosesOn);
			if (close_date.setHours(0, 0, 0, 0) == date_before.setHours(0, 0, 0, 0)) {
    			$('.lotto_info').append('<li class="lotto_house"><span class="lotto_name">' + data[i].HouseName + '</span><span class="lotto_numbers">' + data[i].Drawings[0].PostedNumbers.replace(/\D/g,'') + ' / ' + data[i].Drawings[1].PostedNumbers.replace(/\D/g,'') + ' / ' + data[i].Drawings[2].PostedNumbers.replace(/\D/g,'') + '</span></li>');			
			}
		}
		
	  }
	});

});// END DOCUMENT READY


