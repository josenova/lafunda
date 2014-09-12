$.support.cors = true;

(function(factory) {
  if (typeof define === 'function' && define.amd) {
    // AMD. Register as anonymous module.
    define(['jquery'], factory);
  } else if (typeof exports === 'object') {
    // CommonJS
    module.exports = factory(require('jquery'));
  } else {
    // Browser globals.
    factory(jQuery);
  }
}(function($) {

// Only continue if we're on IE8/IE9 with jQuery 1.5+ (contains the ajaxTransport function)
if ($.support.cors || !$.ajaxTransport || !window.XDomainRequest) {
  return;
}

var httpRegEx = /^https?:\/\//i;
var getOrPostRegEx = /^get|post$/i;
var sameSchemeRegEx = new RegExp('^'+location.protocol, 'i');

// ajaxTransport exists in jQuery 1.5+
$.ajaxTransport('* text html xml json', function(options, userOptions, jqXHR) {
  
  // Only continue if the request is: asynchronous, uses GET or POST method, has HTTP or HTTPS protocol, and has the same scheme as the calling page
  if (!options.crossDomain || !options.async || !getOrPostRegEx.test(options.type) || !httpRegEx.test(options.url) || !sameSchemeRegEx.test(options.url)) {
    return;
  }

  var xdr = null;

  return {
    send: function(headers, complete) {
      var postData = '';
      var userType = (userOptions.dataType || '').toLowerCase();

      xdr = new XDomainRequest();
      if (/^\d+$/.test(userOptions.timeout)) {
        xdr.timeout = userOptions.timeout;
      }

      xdr.ontimeout = function() {
        complete(500, 'timeout');
      };

      xdr.onload = function() {
        var allResponseHeaders = 'Content-Length: ' + xdr.responseText.length + '\r\nContent-Type: ' + xdr.contentType;
        var status = {
          code: 200,
          message: 'success'
        };
        var responses = {
          text: xdr.responseText
        };
        try {
          if (userType === 'html' || /text\/html/i.test(xdr.contentType)) {
            responses.html = xdr.responseText;
          } else if (userType === 'json' || (userType !== 'text' && /\/json/i.test(xdr.contentType))) {
            try {
              responses.json = $.parseJSON(xdr.responseText);
            } catch(e) {
              status.code = 500;
              status.message = 'parseerror';
              //throw 'Invalid JSON: ' + xdr.responseText;
            }
          } else if (userType === 'xml' || (userType !== 'text' && /\/xml/i.test(xdr.contentType))) {
            var doc = new ActiveXObject('Microsoft.XMLDOM');
            doc.async = false;
            try {
              doc.loadXML(xdr.responseText);
            } catch(e) {
              doc = undefined;
            }
            if (!doc || !doc.documentElement || doc.getElementsByTagName('parsererror').length) {
              status.code = 500;
              status.message = 'parseerror';
              throw 'Invalid XML: ' + xdr.responseText;
            }
            responses.xml = doc;
          }
        } catch(parseMessage) {
          throw parseMessage;
        } finally {
          complete(status.code, status.message, responses, allResponseHeaders);
        }
      };

      // set an empty handler for 'onprogress' so requests don't get aborted
      xdr.onprogress = function(){};
      xdr.onerror = function() {
        complete(500, 'error', {
          text: xdr.responseText
        });
      };

      if (userOptions.data) {
        postData = ($.type(userOptions.data) === 'string') ? userOptions.data : $.param(userOptions.data);
      }
      xdr.open(options.type, options.url);
      xdr.send(postData);
    },
    abort: function() {
      if (xdr) {
        xdr.abort();
      }
    }
  };
});

}));

$(document).ready(function() {
	
  /*************************************** START SLIDER *************************************************/

              $('.bxslider').bxSlider();
	
 /******************************** GET LOTTO WINNING NUMBERS *************************************************/
    

	$.getJSON('https://lottery.lafunda.com.do/Lottery/WinningNumbers?key=664cf843-8904-4212-9503-d4733651f519&gobackdays=2&grouped=true').done(function(data) {
		 
		var recent_date = new Date(data[0].ClosesOn);
		var date_before = new Date();
		date_before.setDate(recent_date.getDate() - 1);
		
		var slim_recent_date = recent_date.toString().slice(4,-50);
		var slim_date_before = date_before.toString().slice(4,-50);
		
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
		
		
		if(!Modernizr.csstransitions) { // Test if CSS transitions are supported
			function slideLeft() {
				$lotto_info.animate({
					marginLeft: "-6060px"
				}, 60000, "linear", function() {
					$lotto_info.css("margin-left", 0);
					slideLeft();
				});
			}    
			 slideLeft();  
        }

	}).error(function(xhr, status, error) {  alert(xhr.status); }); //End getJSON

});// END DOCUMENT READY


