
//= require date

$(document).ready(function() {
	
  /*************************************** START SLIDER *************************************************/

              $('.bxslider').bxSlider();
	
 /******************************** GET LOTTO WINNING NUMBERS *************************************************/
    
	    
$.getJSON('https://lottery.lafunda.com.do/Lottery/WinningNumbers?key=664cf843-8904-4212-9503-d4733651f519&gobackdays=2&grouped=true&language=es-DO&callback=?').done(function(data) {
		
		var recent_date = new Date(data[0].ClosesOn);
		var date_before = new Date();
		date_before.setDate(recent_date.getDate() - 1);
		
		var slim_recent_date = recent_date.toString('MMMM d, yyyy');
		var slim_date_before = date_before.toString('MMMM d, yyyy');
		
		var $lotto_info = $('.lotto_info');
		
		$lotto_info.append('<li class="date">' + slim_recent_date + '</li>');		
		for (var i = 0; i < data.length; i++) { 
			var close_date = new Date(data[i].ClosesOn);
			if (close_date.setHours(0, 0, 0, 0) == recent_date.setHours(0, 0, 0, 0)) {
    			$lotto_info.append('<li class="lotto_house"><span class="lotto_name">' + data[i].HouseName + '</span><span class="lotto_numbers"></span></li>');
				for (var j = 0; j < data[i].Drawings.length; j++) {
					var $lotto_numbers = $('.lotto_numbers').last();
					$lotto_numbers.append(data[i].Drawings[j].PostedNumbers.replace(/\D/g,''));	
					if (j != data[i].Drawings.length - 1) {$lotto_numbers.append(' / ')}		
				} 
			} 
		}
			
		$lotto_info.append('<li class="date">' + slim_date_before + '</li>');
		for (var i = 0; i < data.length; i++) { 
			var close_date = new Date(data[i].ClosesOn);
			if (close_date.setHours(0, 0, 0, 0) == date_before.setHours(0, 0, 0, 0)) {
    			$lotto_info.append('<li class="lotto_house"><span class="lotto_name">' + data[i].HouseName + '</span><span class="lotto_numbers"></span></li>');
				for (var j = 0; j < data[i].Drawings.length; j++) {
					var $lotto_numbers = $('.lotto_numbers').last();
					$lotto_numbers.append(data[i].Drawings[j].PostedNumbers.replace(/\D/g,''));	
					if (j != data[i].Drawings.length - 1) {$lotto_numbers.append(' / ')}		
				} 
			}
		}
		
		
		/*if(!Modernizr.csstransitions) { // Test if CSS transitions are supported
			function slideLeft() {
				$lotto_info.animate({
					marginLeft: "-6060px"
				}, 60000, "linear", function() {
					$lotto_info.css("margin-left", 0);
					slideLeft();
				});
			}    
			 slideLeft();  
        } */

	})/*.error(function(xhr, status, error) {  alert(xhr.status); });  //End getJSON
*/
});// END DOCUMENT READY