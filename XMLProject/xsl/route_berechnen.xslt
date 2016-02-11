<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:variable name="leerzeichen">&#160;</xsl:variable>
	<xsl:variable name="ampersand">&amp;</xsl:variable>	
	<xsl:variable name="komma">&#44;</xsl:variable>
	<xsl:variable name="delimeter">&#35;</xsl:variable>
	<xsl:template match="/">
		<style type="text/css">
			#routeTo { height: 5%; }
			#map { height: 95%; }	
		</style>	
		
		<label for="destination">Bitte wählen Sie das Ziel: </label>
		<select id="destination" class="eingabe" name="destination">
			<!-- Vermeiden von Duplikaten -->
			<xsl:for-each select="//objektAdresse">
				<xsl:element name="option">
					<xsl:attribute name="value">
						<xsl:value-of select="./koordinate_x"/>
						<xsl:value-of select="$delimeter"/>
						<xsl:value-of select="./koordinate_y"/>
					</xsl:attribute>
					<xsl:value-of select="./@strasse"/> 
					<xsl:value-of select="$leerzeichen"/>
					<xsl:value-of select="./@hausnummer"/>
				</xsl:element>
			</xsl:for-each>
		</select>
		<button class="button" onclick="showRouteAndMap()">Route anzeigen</button>
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