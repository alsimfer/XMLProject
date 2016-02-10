/**
 * When ready
 */
$(document).ready(function() {
    console.log("Ready!");

	$('#schutzobjekte').submit(function (e) {
	    $.ajax({
	        type: $('#schutzobjekte').attr('method'),
	        url: $('#schutzobjekte').attr('action'),
	        data: $('#schutzobjekte').serialize(),

	        success: function(html) {
	       		$("#content").empty().append(html);
	       		getObjectsByClient(
	       			$('#schutzobjekte').serialize()
       			);
	       	},
	       	error: function(result)	{
	       		alert(result);
	       	}
	    });
		e.preventDefault();
	});

});

/**
 * Ajax functions
 */
function alleKunden() {
    $.ajax({
	  	url: "alle_kunden.html"
	})
  	.done(function(html) {
    	$("#content").empty().append(html);
  	});
}

function alleMitarbeiter() {
    $.ajax({
	  	url: "alle_mitarbeiter.html"
	})
  	.done(function(html) {
    	$("#content").empty().append(html);
  	});
}

function alleUnfaelle() {
    $.ajax({
	  	url: "alle_unfaelle.html"
	})
  	.done(function(html) {
    	$("#content").empty().append(html);
  	});
}

function routeBerechnen() {
    $.ajax({
	  	url: "route_berechnen.html"
	})
  	.done(function(html) {
    	$("#content").empty().append(html);
  	});
}

function getObjectsByClient(params) {
	$.ajax({
        method: "POST",
        url: "objectsByClient.xml",
        data: params,

        success: function(xml) {
       		showObjectsAndMap(xml);
       	},
       	error: function(result)	{
       		alert("Something wrong");
       	}
    });
}

/**
 * Maps
 */
function routeMap() {
	var directionsDisplay;
	var directionsService = new google.maps.DirectionsService();
	var map;
	var start = new google.maps.LatLng(53.05541494, 8.78298998);
	var end = new google.maps.LatLng(53.08697516, 8.81777287);

	directionsDisplay = new google.maps.DirectionsRenderer();
	var bremen = new google.maps.LatLng(53.0792962, 8.8016937);
	var mapOptions = {
		zoom:15,
		center: bremen
	}
	map = new google.maps.Map(document.getElementById("map"), mapOptions);
	directionsDisplay.setMap(map);

	var request = {
		origin:start,
		destination:end,
		travelMode: google.maps.TravelMode.DRIVING
	};

	directionsService.route(request, function(result, status) {
		if (status == google.maps.DirectionsStatus.OK) {
			directionsDisplay.setDirections(result);
		}
	});
}

function showObjectsAndMap(xml) {
	console.log(xml);
	var bounds = new google.maps.LatLngBounds();
	var centerIn = new google.maps.LatLng(53.08697516, 8.81777287);
	var mapOptions = {
	    center: centerIn,
	    scrollwheel: false,
	    zoom: 15
	    // mapTypeId: google.maps.MapTypeId.SATELLITE
  	};

	// Create a map object and specify the DOM element for display.
	var map = new google.maps.Map(document.getElementById('map'), mapOptions);
}
