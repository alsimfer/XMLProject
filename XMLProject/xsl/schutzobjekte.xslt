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
  				#map { height: 100%; }
  			</style>	
			<title>Schutzobjekte nach Kunden</title> 
			<script async="async" defer="defer" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyA857r6vc8G0Xr08_FqcsfM0Ox56XAmFac&amp;callback=initMap"></script>
			<script type="text/javascript">	
				<![CDATA[
					function initMap() {
					// Create empty LatLngBounds object.
					var bounds = new google.maps.LatLngBounds();
					var coord1 = new google.maps.LatLng(53.05541494, 8.78298998);
					var coord2 = new google.maps.LatLng(53.05041494, 8.78598998);
					var mapOptions = {
					    center: coord1,
					    scrollwheel: false,
					    zoom: 15
					    // mapTypeId: google.maps.MapTypeId.SATELLITE
				  	};

					// Create a map object and specify the DOM element for display.
					var map = new google.maps.Map(document.getElementById('map'), mapOptions);

					var marker1 = new google.maps.Marker({
					    position: coord1,
					    map: map
				    })	
				    var marker2 = new google.maps.Marker({
					    position: coord2,
					    map: map
				    })	

					/* Find out how to pass the array from xml to JS and use following to see all objects of a client.
					for (i = 0; i < locations.length; i++) {  
					  	var marker = new google.maps.Marker({
					    	position: new google.maps.LatLng(locations[i][1], locations[i][2]),
					    	map: map
					  	});

					  	//extend the bounds to include each marker's position
					 	bounds.extend(marker.position);
				 	}	
			
					//now fit the map to the newly inclusive bounds
					map.fitBounds(bounds);
					*/
					}
				]]>
			</script>
		</head>
		<body> 	
			<!-- Schutzobjekte -->	
		   	<h1>Schutzobjekte nach Kunden</h1>
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