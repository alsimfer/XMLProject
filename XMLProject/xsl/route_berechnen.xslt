<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:variable name="leerzeichen">&#160;</xsl:variable>
	<xsl:variable name="ampersand">&amp;</xsl:variable>	
	<xsl:variable name="komma">&#44;</xsl:variable>
	<xsl:template match="/">
		<html>	
			<xsl:apply-templates/>
		</html>
	</xsl:template>
	<xsl:template match="sicherheitsDienst">
		<head> 
			<style type="text/css">
				html, body { height: 100%; margin: 0; padding: 0; }
  				#map { height: 100%; }
  			</style>	
			<title>Route</title> 
			<script async="async" defer="defer" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyA857r6vc8G0Xr08_FqcsfM0Ox56XAmFac&amp;callback=initMap"></script>
			<script type="text/javascript">	
				<![CDATA[

				function initMap() {
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

				]]>
			</script>
			
		</head>
		<body> 
			<div id="map">
				
			</div>
		</body>
	</xsl:template>

	<!-- Ausgabe der Postadresse von Unternehmen -->	
	<xsl:template name="adresse">
		<xsl:param name="name"/>
		<xsl:if test="//sicherheitsUnternehmen/unternehmen[@name=$name]">
			
			<div><xsl:value-of select="./adresse/@strasse"/>
				<xsl:value-of select="$leerzeichen"/>
				<xsl:value-of select="./adresse/@hausnummer"/>
			</div>
			<div>
				<xsl:value-of select="./adresse/@zip"/>
				<xsl:value-of select="$leerzeichen"/>
				<xsl:value-of select="./adresse/@stadt"/>
			</div>
			<div>
			<xsl:choose>
				<xsl:when test="./adresse/@land">
					<xsl:value-of select="./adresse/@land"/>
				</xsl:when>
				<xsl:otherwise>Deutschland</xsl:otherwise>
			</xsl:choose>
			</div>
			
		</xsl:if>	
	</xsl:template>
</xsl:stylesheet>