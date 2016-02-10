<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:variable name="leerzeichen">&#160;</xsl:variable>
	<xsl:variable name="ampersand">&amp;</xsl:variable>	
	<xsl:variable name="komma">&#44;</xsl:variable>
	<xsl:template match="/">
		<script async="async" defer="defer" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyA857r6vc8G0Xr08_FqcsfM0Ox56XAmFac&amp;callback=routeMap"></script>
		<script>
			console.log('Hi');			
		</script>
		<div id="map">
		</div>
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