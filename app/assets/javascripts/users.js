
$(document).ready(function() {

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

 /******************************* DISABLE PASTE IN INPUTS ******************************************/
 

	 $('#user_email_confirmation').bind("cut copy paste",function(e) {
	   e.preventDefault();
	 });
	 


});// END DOCUMENT READY


