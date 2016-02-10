<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:variable name="ampersand">&amp;</xsl:variable>
	<xsl:variable name="leerzeichen">&#160;</xsl:variable>
	<xsl:variable name="komma">&#44;</xsl:variable>
	<xsl:template match="/">
		<html>	
			<xsl:apply-templates/>
		</html>
	</xsl:template>

	<!-- Main page -->
	<xsl:template match="sicherheitsDienst">
		<head> 
			<title><xsl:value-of select="./@title"/></title> 
			<!-- Here are all styles! -->
			<link rel="stylesheet" type="text/css" href="css/document.css"/>
			<!-- Here are all js scripts! -->
			<script src="js/jquery-2.2.0.js"></script>
			<script src="js/custom.js"></script>
			<script async="async" defer="defer" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyA857r6vc8G0Xr08_FqcsfM0Ox56XAmFac"></script>
		</head>
		<body> 	
			<div id="wrapper">
				<div id="header">
					<div><button class="button" onclick="alleMitarbeiter()">Alle Mitarbeiter</button></div>
					<div><button class="button" onclick="alleKunden()">Alle Kunden</button></div>
					<!-- Schutzobjekte nach Kunden -->	
					<div><xsl:call-template name="schutzobjekte" /></div>
					<!-- Rechnung erstellen -->	
					<div><xsl:call-template name="rechnungErstellen" /></div>
					<div><button class="button" onclick="alleUnfaelle()">Alle Unfaelle</button></div>
					<div><button class="button" onclick="routeBerechnen()">Route berechnen</button></div>
				</div>
				<div id="content">					
				</div>	
				<div id="footer">
					<span><xsl:call-template name="footer" /></span>
				</div>
			</div>
		</body>
	</xsl:template>
	
	<!-- Footer -->	
	<xsl:template name="footer">	
		<xsl:value-of select="//sicherheitsUnternehmen/@name"/><xsl:value-of select="$komma"/><xsl:value-of select="$leerzeichen"/>
		<xsl:value-of select="//sicherheitsUnternehmen/adresse/@strasse"/><xsl:value-of select="$leerzeichen"/>
		<xsl:value-of select="//sicherheitsUnternehmen/adresse/@hausnummer"/><xsl:value-of select="$komma"/><xsl:value-of select="$leerzeichen"/>
		<xsl:value-of select="//sicherheitsUnternehmen/adresse/@zip"/><xsl:value-of select="$komma"/><xsl:value-of select="$leerzeichen"/>
		<xsl:value-of select="//sicherheitsUnternehmen/adresse/@stadt"/><xsl:value-of select="$komma"/><xsl:value-of select="$leerzeichen"/>
		<xsl:choose>
			<xsl:when test="//sicherheitsUnternehmen/adresse/@land">
				<xsl:value-of select="//sicherheitsUnternehmen/adresse/@land"/><xsl:value-of select="$komma"/><xsl:value-of select="$leerzeichen"/>
			</xsl:when>
			<xsl:otherwise>Deutschland<xsl:value-of select="$komma"/><xsl:value-of select="$leerzeichen"/></xsl:otherwise>
		</xsl:choose>
		<xsl:value-of select="//sicherheitsUnternehmen/@email"/><xsl:value-of select="$komma"/><xsl:value-of select="$leerzeichen"/>
		<xsl:value-of select="//sicherheitsUnternehmen/@telefon"/>
	</xsl:template>
	

	<!-- Alle Schutzobjekte nach Kunde anzeigen-->	
	<xsl:template name="schutzobjekte">
		<form id="schutzobjekte" method="POST" action="schutzobjekte.html" ajax="true">
			<label for="kunde">Bitte wählen Sie die Kunden-ID: </label>
			<select class="eingabe" name="kunde">
				<!-- Vermeiden von Duplikaten -->
				<xsl:for-each select="//kunden/kunde/@id[not(.=../preceding-sibling::kunde/@id)]">
					<xsl:element name="option">
						<xsl:attribute name="value">
							<xsl:value-of select="."/> 
						</xsl:attribute>
						<xsl:value-of select="."/>
					</xsl:element>
				</xsl:for-each>
			</select>
			<input class="button" type="submit" value="Schutzobjekte anzeigen" />
		</form>
	</xsl:template>

	<!-- Rechnung erstellen-->	
	<xsl:template name="rechnungErstellen">
		<form method="get" action="rechnung.pdf" target="ausgabe">
			<label for="unfall">Bitte wählen Sie die Unfall-ID: </label>
			<select class="eingabe" name="unfall">
				<!-- Vermeiden von Duplikaten -->
				<xsl:for-each select="//unfaelle/unfall/@id[not(.=../preceding-sibling::unfall/@id)]">
					<xsl:element name="option">
						<xsl:attribute name="value">
							<xsl:value-of select="."/>
						</xsl:attribute>
						<xsl:value-of select="."/>
					</xsl:element>
				</xsl:for-each>
			</select>
			<input class="button" type="submit" value="Rechnung erstellen" />
		</form>
	</xsl:template>

</xsl:stylesheet>

