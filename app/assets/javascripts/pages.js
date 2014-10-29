
$(document).ready(function() {
		 

/******************************* PAYMENT PROVIDERS ALERTS **************************************/

		$( "#providers #bank_transfer" ).click(function() {
		  alert( "Banco BHD\nCuenta: 15216080019\nNombre: Kingsley Edgecombe\n\nDepósitos\nColoca en la nota de depósito tu nombre e email registrado con nosotros.\n\nRetiros\nSolícita tu retiro a finances@lafunda.do. Solo se aceptarán solicitudes y se enviarán pagos a cuentas de email que estén registradas con nosotros." );
		});
		
		$( "#providers #paypal" ).click(function() {
		  alert( "Paypal\nCuenta: finances@lafunda.do\n\nDepósitos\nColoca en la nota de depósito tu nombre e email registrado con nosotros.\n\nRetiros\nSolícita tu retiro a finances@lafunda.do. Solo se aceptarán solicitudes y se enviarán pagos a cuentas de email que estén registradas con nosotros. " );
		});

 
 
  /******************************* BONUS PROGRESS BAR ******************************************/		 
			 
	var percent = $(".bar_liquid").attr('percent');	
	if (percent > 5) {	 
		$('.bar_liquid').css("width", percent + "%");
	}
	if (percent == 100) {
	  $('.bar_liquid').css({
   			"background" : "#dfab3e",
  			 "border-radius" : "5px"
	  });
	  $('span.meter_amount').css("color", "#dfab3e");
	}

});// END DOCUMENT READY


