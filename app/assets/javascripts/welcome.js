
$(document).ready(function() {
	
	 /******************************** GET LOTTO WINNING NUMBERS *************************************************/
	
	$.ajax({
	  type:'GET',
	  url: 'https://lottery.lafunda.com.do/Lottery/WinningNumbers?key=664cf843-8904-4212-9503-d4733651f519',
	  accept: 'application/json',  
	  dataType: 'json',
	  success: function(data) {
			//alert(data[1].HouseName);
			//alert(data[1].PostedNumbers);
		}
	});

});// END DOCUMENT READY


