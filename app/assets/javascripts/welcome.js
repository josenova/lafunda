
$(document).ready(function() {
	
  /*************************************** START SLIDER *************************************************/

              $('.bxslider').bxSlider();
	
 /******************************** GET LOTTO WINNING NUMBERS *************************************************/
 
 
 	var sortBy = function(arr) {
		function _sortByAttr(attr) {
			var sortOrder = 1;
			if (attr[0] == "-") {
				sortOrder = -1;
				attr = attr.substr(1);
			}
			return function(a, b) {
				var result = (a[attr] < b[attr]) ? -1 : (a[attr] > b[attr]) ? 1 : 0;
				return result * sortOrder;
			}
		}
		function _getSortFunc() {
			if (arguments.length == 0) {
				throw "Zero length arguments not allowed for Array.sortBy()";
			}
			var args = arguments;
			return function(a, b) {
				for (var result = 0, i = 0; result == 0 && i < args.length; i++) {
					result = _sortByAttr(args[i])(a, b);
				}
				return result;
			}
		}
		return arr.sort(_getSortFunc.apply(null, arguments));
	}
	
	
	$.ajax({
	  type:'GET',
	  url: 'https://lottery.lafunda.com.do/Lottery/WinningNumbers?key=664cf843-8904-4212-9503-d4733651f519&gobackdays=1&grouped=true',
	  accept: 'application/json',  
	  dataType: 'json',
	  success: function(data) {
		  
		//console.log(data);
		  
		var sorted = sortBy(data, "ClosesOn");
				
		for (var i = 0; i < data.length; i++) { 
    		$('.lotto_info').prepend('<li class="lotto_house"><span class="lotto_name">' + data[i].HouseName + '</span><span class="lotto_numbers">' + data[i].Drawings[0].PostedNumbers.replace(/\D/g,'') + ' / ' + data[i].Drawings[1].PostedNumbers.replace(/\D/g,'') + ' / ' + data[i].Drawings[2].PostedNumbers.replace(/\D/g,'') + '</span></li>');
		}
	 }
	});

});// END DOCUMENT READY


