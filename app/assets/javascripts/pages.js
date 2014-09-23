
$(document).ready(function() {
		 

/******************************* PAYMENT PROVIDERS ALERTS **************************************/

		$( "#providers #bank_transfer" ).click(function() {
		  alert( "Banco BHD\nCuenta: 15216080019\nNombre: Kingsley Edgecombe\n\nDepósitos\nColoca en la nota de depósito tu nombre e email registrado con nosotros.\n\nRetiros\nSolícita tu retiro a hfernandez@kinbar.com.do. Solo se aceptarán solicitudes y se enviarán pagos a cuentas de email que estén registradas con nosotros." );
		});
		
		$( "#providers #paypal" ).click(function() {
		  alert( "Paypal\nCuenta: hfernandez@kinbar.com.do\nNombre: La Funda\n\nDepósitos\nColoca en la nota de depósito tu nombre (e email registrado con nosotros, en caso de no usarlo para realizar el depósito).\n\nRetiros\nSolícita tu retiro a hfernandez@kinbar.com.do. Solo se aceptarán solicitudes y se enviarán pagos a cuentas de email que estén registradas con nosotros. " );
		});

 

});// END DOCUMENT READY


