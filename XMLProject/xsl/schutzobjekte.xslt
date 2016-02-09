<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/>
	
	<xsl:param name="kunde"/>
	<xsl:variable name="leerzeichen">&#160;</xsl:variable>
	<xsl:variable name="strich">&#45;</xsl:variable>
	<xsl:variable name="ampersand">&amp;</xsl:variable>	
	<xsl:variable name="komma">&#44;</xsl:variable>
	<xsl:variable name="klammerAuf">&#40;</xsl:variable>
	<xsl:variable name="klammerZu">&#41;</xsl:variable>
	<xsl:template match="/">
		<html>	
			<xsl:apply-templates/>
		</html>
	</xsl:template>
	<xsl:template match="sicherheitsDienst">
		<head> 
			<link rel="stylesheet" type="text/css" href="css/document.css"/>	
			<style type="text/css">
				html, body { height: 100%; margin: 0; padding: 0; }
				#table { height: 10%; overflow-y:auto; }
  				#map { height: 83%; }
  			</style>	
			<title>Schutzobjekte nach Kunden</title> 
			<script async="async" defer="defer" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyA857r6vc8G0Xr08_FqcsfM0Ox56XAmFac&amp;callback=initMap"></script>
			<script type="text/javascript">	
				<![CDATA[
					function initMap() {
						// Get the requested clientId.
						var kundeId = ]]><xsl:value-of select="$kunde"/><![CDATA[;
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

					    loadXML("db.xml", function(xml) {
					    	var kunden = xml.getElementsByTagName('kunde');
					    	
					    	for (var i=0; i < kunden.length; i++) {
					    		if (kunden[i].getAttribute('id') == kundeId) {
					    			var x = kunden[i].getElementsByTagName('koordinate_x');
							    	var y = kunden[i].getElementsByTagName('koordinate_y');
									var locations = [];
									for (var i=0; i<x.length && i<y.length; i++) 
										locations[i] = [x[i].childNodes[0].nodeValue, y[i].childNodes[0].nodeValue];
					    		}
					    	}
							
							for (i = 0; i < locations.length; i++) {  
							  	var marker = new google.maps.Marker({
							    	position: new google.maps.LatLng(locations[i][0], locations[i][1]),
							    	map: map
							  	});

							  	// Extend the bounds to include each marker's position
							 	bounds.extend(marker.position);
						 	}
					
							// Now fit the map to the newly inclusive bounds, but only if there are many objects, else too close.
							if (locations.length > 1) map.fitBounds(bounds); 

							console.log(kundeId);
							console.log(kunden);			
					    });	
		
					}	
									

					function loadXML(path, callback) {
					    var request;

					    // Create a request object. Try Mozilla / Safari method first.
					    if (window.XMLHttpRequest) {
					        request = new XMLHttpRequest();

					    // If that doesn't work, try IE methods.
					    } else if (window.ActiveXObject) {
					        try {
					            request = new ActiveXObject("Msxml2.XMLHTTP");
					        } catch (e1) {
					            try {
					                request = new ActiveXObject("Microsoft.XMLHTTP");
					            } catch (e2) {
					            }
					        }
					    }

					    // If we couldn't make one, abort.
					    if (!request) {
					        window.alert("No ajax support.");
					        return false;
					    }

					    // Upon completion of the request, execute the callback.
					    request.onreadystatechange = function () {
					        if (request.readyState === 4) {
					            if (request.status === 200) {
					                callback(request.responseXML);
					            } else {
					                window.alert("Could not load " + path);
					            }
					        }
					    };

					    request.open("GET", path);
					    request.send();
					}

				]]>
			</script>
		</head>
		<body> 	
			<!-- Schutzobjekte -->	
		   	<h1>Schutzobjekte nach Kunden</h1>
		   	<div id="table">
			   	<table>
					<tr>
						<th>ID</th>
						<th>Strasse mit Hausnummer</th>
						<th>Ort</th>
						<th>Verantwortlicher (Verantwortlicher-ID)</th>
					</tr>
					<xsl:for-each select="//kunden/kunde[@id=$kunde and not(schutzObjekte/objekt/@id=../preceding-sibling::schutzObjekte/objekt/@id)]">
					<tr>
						<td><xsl:value-of select="./schutzObjekte/objekt/@id"/></td>
						<td>
							<xsl:value-of select="./schutzObjekte/objekt/objektAdresse/@strasse"/>
							<xsl:value-of select="$leerzeichen"/>
							<xsl:value-of select="./schutzObjekte/objekt/objektAdresse/@hausnummer"/>
						</td>
						<td>
							<xsl:value-of select="./schutzObjekte/objekt/objektAdresse/@zip"/>
							<xsl:value-of select="$leerzeichen"/>
							<xsl:value-of select="./schutzObjekte/objekt/objektAdresse/@stadt"/>
						</td>
						<td>
							<xsl:call-template name="objektVerantwortlicher">
							<xsl:with-param name="objekt"><xsl:value-of select="./schutzObjekte/objekt/@id"/></xsl:with-param>
							</xsl:call-template>
						</td>		
					</tr>
					</xsl:for-each>
				</table>
			</div>

			
			<div id="map">
			</div>
		   
		</body>
	</xsl:template>
	
	<xsl:template name="objektVerantwortlicher">
		<xsl:param name="objekt"/>
		
		<xsl:for-each select="//gebiete/gebiet[gebietSchutzObjekte/objekt_id=$objekt]">
			<xsl:for-each select="./mitarbeiter_id">
				<xsl:call-template name="mitarbeiter">
					<xsl:with-param name="mr"><xsl:value-of select="." /></xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
		</xsl:for-each>
		
	</xsl:template>
	
	<xsl:template name="mitarbeiter">
		<xsl:param name="mr"/>
		<div>
		<xsl:for-each select="//alleMitarbeiter/mitarbeiter[@id=$mr]">
			<xsl:value-of select="./@name"></xsl:value-of>
			<xsl:value-of select="$komma"></xsl:value-of>
			<xsl:value-of select="$leerzeichen"></xsl:value-of>
			<xsl:value-of select="./@vorname"></xsl:value-of>
			<xsl:value-of select="$leerzeichen"></xsl:value-of>
			<xsl:value-of select="$klammerAuf" /><xsl:value-of select="$mr" /><xsl:value-of select="$klammerZu" />
		</xsl:for-each>
		</div>
	</xsl:template>
	
</xsl:stylesheet>