var ADD_VALUE = 99999;

$("#save").click(function(event) {
	event.preventDefault();

	if (validateData()) {

		var date = $("#date").val();
		var quantity = $("#quantity").val().replace(",", ".");
		var number = (($("#number").val() == "") ? "null" : $("#number").val());
		var concept = $("#concept").val();

		var company_id = $("#company").val();
		var paymethod_id = $("#paymethod").val();
		var payer_id = $("#payer").val();
		var passbook_id = $("#passbook").val();

		var data = {};

		data.date = date;
		data.quantity = quantity;
		data.number = number;
		data.concept = concept;
		data.company_id = company_id;
		data.paymethod_id = paymethod_id;
		data.payer_id = payer_id;
		data.passbook_id = passbook_id;

		var json = JSON.stringify(data);
	
		console.log(json);

		$.post( "/payment/new", {date: date, concept: concept, quantity: quantity, number: number, company_id: company_id,
								 paymethod_id: paymethod_id, payer_id: payer_id, passbook_id: passbook_id})
				.done(function( data ) {
					var received = $.parseJSON(data);
					if (received.status == "Ok") {
						window.location.href = "/";
					} else {
						alert("Error creando nueva empresa");
					}
				});
	} else {
		alert("Hay que rellenar los campos Fecha, Empresa, Forma de Pago, Concepto y Pago");
	}
});

$("#update").click(function(event) {
	event.preventDefault();

	if (validateData()) {

		var link = $(this).attr('href');

		var date = $("#date").val();
		var quantity = $("#quantity").val().replace(",", ".");
		console.log(quantity);
		var number = (($("#number").val() == "") ? "null" : $("#number").val());
		var concept = $("#concept").val();

		var company_id = $("#company").val();
		var paymethod_id = $("#paymethod").val();
		var payer_id = $("#payer").val();
		var passbook_id = $("#passbook").val();

		$.post( link, { date: date, concept: concept, quantity: quantity,
								  number: number, company_id: company_id,
								  paymethod_id: paymethod_id, payer_id: payer_id,
								  passbook_id: passbook_id})
				.done(function( data ) {
					var received = $.parseJSON(data);
					if (received.status == "Ok") {
						window.location.href = "/";
					} else {
						alert("Error creando nueva empresa");
					}
				});
	} else {
		alert("Hay que rellenar los campos Fecha, Empresa, Forma de Pago, Concepto y Pago");
	}
});

$("#cancel").click(function(event) {
	event.preventDefault();
	window.location.href = "/";
});

$("#addAnother").click(function(event) {
	event.preventDefault();

	if (validateData()) {

		var date = $("#date").val();
		var quantity = $("#quantity").val().replace(",", ".");
		var number = (($("#number").val() == "") ? "null" : $("#number").val());
		var concept = $("#concept").val();

		var company_id = $("#company").val();
		var paymethod_id = $("#paymethod").val();
		var payer_id = $("#payer").val();
		var passbook_id = $("#passbook").val();

		var data = {};

		data.date = date;
		data.quantity = quantity;
		data.number = number;
		data.concept = concept;
		data.company_id = company_id;
		data.paymethod_id = paymethod_id;
		data.payer_id = payer_id;
		data.passbook_id = passbook_id;

		var json = JSON.stringify(data);
	
		console.log(json);

		$.post( "/payment/new", {date: date, concept: concept, quantity: quantity, number: number, company_id: company_id,
								 paymethod_id: paymethod_id, payer_id: payer_id, passbook_id: passbook_id})
				.done(function( data ) {
					var received = $.parseJSON(data);
					if (received.status == "Ok") {
						window.location.href = "/payment/new";
					} else {
						alert("Error creando nueva empresa");
					}
				});
	} else {
		alert("Hay que rellenar los campos Fecha, Empresa, Forma de Pago, Concepto y Pago");
	}
});

function validateData() {
	return ((date.value != "") &&
		    (company.value != "") &&
		    (paymethod.value != "") &&
		    (concept.value != "") &&
		    (quantity.value != ""));
}

$("#company").change(function(event) {
	if ($("#company").val() == ADD_VALUE) {
		var newCompany = prompt("Introduce el nombre de la nueva empresa");

		if (newCompany != null) {
			$.post( "/company/new", { company: newCompany })
				.done(function( data ) {
					var received = $.parseJSON(data);
					if (received.status == "Ok") {
						$("#companies").append("<option value=\"" + received.id + "\">" + received.company + "</option>");
						$("#company option[value=" + received.id + "]").attr("selected", true);
					} else {
						alert("Error creando nueva empresa");
					}
				});
		}
	}
});

$("#paymethod").change(function(event) {
	if ($("#paymethod").val() == ADD_VALUE) {
		var newPaymethod = prompt("Introduce la nueva forma de pago");

		if (newPaymethod != null) {
			$.post( "/paymethod/new", { paymethod: newPaymethod })
				.done(function( data ) {
					var received = $.parseJSON(data);
					if (received.status == "Ok") {
						$("#paymethods").append("<option value=\"" + received.id + "\">" + received.paymethod + "</option>");
						$("#paymethod option[value=" + received.id + "]").attr("selected", true);
					} else {
						alert("Error creando nueva método de pago");
					}
				});
		}
	}
});

$("#passbook").change(function(event) {
	if ($("#passbook").val() == ADD_VALUE) {
		var newPassbook = prompt("Introduce el nombre de la nueva libreta");

		if (newPassbook != null) {
			$.post( "/passbook/new", { passbook: newPassbook })
				.done(function( data ) {
					var received = $.parseJSON(data);
					if (received.status == "Ok") {
						$("#passbooks").append("<option value=\"" + received.id + "\">" + received.passbook + "</option>");
						$("#passbook option[value=" + received.id + "]").attr("selected", true);
					} else {
						alert("Error creando nueva libreta");
					}
				});
		}
	}
});

$("#payer").change(function(event) {
	if ($("#payer").val() == ADD_VALUE) {
		var newPayer = prompt("Introduce el nombre del nuevo pagador");

		if (newPayer != null) {
			$.post( "/payer/new", { payer: newPayer })
				.done(function( data ) {
					var received = $.parseJSON(data);
					if (received.status == "Ok") {
						$("#payers").append("<option value=\"" + received.id + "\">" + received.payer + "</option>");
						$("#payer option[value=" + received.id + "]").attr("selected", true);
					} else {
						alert("Error creando nuevo pagador");
					}
				});
		}
	}
});

$(".deletePayment").click(function(event) {
	event.preventDefault();

	var parentElement = $(this).parent();

	var concept = parentElement.siblings(".concept").html();
	var date = parentElement.siblings(".date").html();
	var quantity = parentElement.siblings(".quantity").html();

	var deletePayment = confirm("¿Eliminar pago de " + concept + " del día " + date + " de " + quantity + "€?");

	if (deletePayment == true) {
		window.location.href = this.href;
	}
});


// Javascript companies.erb
$(".addCompany").click(function(event) {
	event.preventDefault();

	var newCompany = prompt("Introduce el nombre de la nueva empresa");

	if (newCompany != null) {
		$.post( "/company/new", { company: newCompany })
			.done(function( data ) {
				var received = $.parseJSON(data);
				if (received.status == "Ok") {
					window.location.href = "/company";
				} else {
					alert("Error creando nueva empresa");
				}
			});
	}
});

$(".deleteCompany").click(function(event) {
	event.preventDefault();

	var element = $(this).parent().siblings(".company");

	var company = element.html();

	var deletePayment = confirm("¿Eliminar compañía " + company + "?");

	if (deletePayment == true) {
		window.location.href = this.href;
	}
});

$(".editCompany").click(function(event) {
	event.preventDefault();

	var link = $(this).attr('href');

	var oldCompany = $(this).parent().siblings(".company").html();

	var newCompany = prompt("Introduce el nuevo nombre para la empresa \"" + oldCompany + "\"", oldCompany);

	if (newCompany != null) {
		$.post( link, { company: newCompany })
			.done(function( data ) {
				var received = $.parseJSON(data);
				if (received.status == "Ok") {
					window.location.href = "/company";
				} else {
					alert("Error modificando empresa");
				}
			});
	}
});

// Javascript passbooks.erb
$(".addPassbook").click(function(event) {
	event.preventDefault();

	var newPassbook = prompt("Introduce el nombre de la nueva libreta");

	if (newPassbook != null) {
		$.post( "/passbook/new", { passbook: newPassbook })
			.done(function( data ) {
				var received = $.parseJSON(data);
				if (received.status == "Ok") {
					window.location.href = "/passbook";
				} else {
					alert("Error creando nueva libreta");
				}
			});
	}
});

// Javascript payers.erb
$(".addPayer").click(function(event) {
	event.preventDefault();

	var newPayer = prompt("Introduce el nombre del nuevo pagador");

	if (newPayer != null) {
		$.post( "/payer/new", { payer: newPayer })
			.done(function( data ) {
				var received = $.parseJSON(data);
				if (received.status == "Ok") {
					window.location.href = "/payer";
				} else {
					alert("Error creando nuevo pagador");
				}
			});
	}
});

// Javascript paymethods.erb
$(".addPaymethod").click(function(event) {
	event.preventDefault();

	var newPaymethod = prompt("Introduce el nombre del nuevo método de pago");

	if (newPaymethod != null) {
		$.post( "/paymethod/new", { paymethod: newPaymethod })
			.done(function( data ) {
				var received = $.parseJSON(data);
				if (received.status == "Ok") {
					window.location.href = "/paymethod";
				} else {
					alert("Error creando nuevo método de pago");
				}
			});
	}
});

$(".editPaymethod").click(function(event) {
	event.preventDefault();

	var link = $(this).attr('href');

	var oldPaymethod = $(this).parent().siblings(".paymethod").html();

	var newPaymethod = prompt("Introduce el nuevo nombre para el método de pago \"" + oldPaymethod + "\"", oldPaymethod);

	if (newPaymethod != null) {
		$.post( link, { paymethod: newPaymethod })
			.done(function( data ) {
				var received = $.parseJSON(data);
				if (received.status == "Ok") {
					window.location.href = "/paymethod";
				} else {
					alert("Error modificando método de pago");
				}
			});
	}
});

