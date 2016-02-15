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
	console.log(params);
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

function loadAllObjects() {
	console.log('Loading');
    getObjectsByClient('kunde=0');

}

/**
 * We use always HS Bremen as a start and different destination points. IRL should be implemented automatical recognition with the hardware sensors.
 */
function showRouteAndMap() {
	var directionsDisplay;
	var directionsService = new google.maps.DirectionsService();
	var start = new google.maps.LatLng(53.05541494, 8.78298998);
	var koords = $('#destination').val().split('#');
	console.log(koords);
	var end = new google.maps.LatLng(koords[0], koords[1]);

	directionsDisplay = new google.maps.DirectionsRenderer();
	var bremen = new google.maps.LatLng(53.0792962, 8.8016937);
	var mapOptions = {
		zoom:15,
		center: bremen
	}

	var map = new google.maps.Map(document.getElementById("map"), mapOptions);
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

/**
 * xml-Param is an xml with all guarded objects of a certain client with the structure
 * <objects>
 *  <object>
 *   <x>12345</x>
 *   <y>12345</y>
 *	 <address>asd</address>
 *   <info>qwe</info>
 *  </object>...
 * </objects>
 */
function showObjectsAndMap(xml) {
	console.log(xml);
	var bounds = new google.maps.LatLngBounds();
	// Bremen Mitte.
	var centerIn = new google.maps.LatLng(53.08697516, 8.81777287);
	var mapOptions = {
	    center: centerIn,
	    scrollwheel: false,
	    zoom: 15
  	};

	// Create a map object and specify the DOM element for display.
	var map = new google.maps.Map(document.getElementById('map'), mapOptions);

	// Make an array of all objects.	
	var x = xml.getElementsByTagName('x');
	var y = xml.getElementsByTagName('y');
	var address = xml.getElementsByTagName('address');
	var info = xml.getElementsByTagName('info');

	var locations = [];
	//for (var i=0; i<x.length && i<y.length; i++) locations[i] = [x[i].childNodes[0].nodeValue, y[i].childNodes[0].nodeValue];					
	for (var i=0; i<x.length && i<y.length && i<address.length; i++) 
		locations[i] = [x[i].childNodes[0].nodeValue, y[i].childNodes[0].nodeValue, address[i].childNodes[0].nodeValue, info[i].childNodes[0].nodeValue];					

	// Show each object on the map.
	for (i = 0; i < locations.length; i++) {  
		var infowindow = new google.maps.InfoWindow({
		    content: locations[i][2] + '<br>' + locations[i][3]
		});

	  	var marker = new google.maps.Marker({
    		position: new google.maps.LatLng(locations[i][0], locations[i][1]),
	    	map: map,
	    	title: locations[i][2],
	    	infowindow: infowindow
	  	});
	  	
	  	google.maps.event.addListener(marker, 'click', function() {
        	this.infowindow.open(map, this);
		});

		// Extend the bounds to include each marker's position
	 	bounds.extend(marker.position);
 	}

	// Now fit the map to the newly inclusive bounds, but only if there are many objects, else too close.
	if (locations.length > 1) {
		map.fitBounds(bounds); 
	} else {
		var centerIn = new google.maps.LatLng(locations[0][0], locations[0][1]);
		map.panTo(centerIn);
	}

}
