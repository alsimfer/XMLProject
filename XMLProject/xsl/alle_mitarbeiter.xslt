<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:variable name="leerzeichen">&#160;</xsl:variable>
	<xsl:template match="/">
		<html>	
			<xsl:apply-templates/>
		</html>
	</xsl:template>
	<xsl:template match="sicherheitsDienst">
		<head> 
			<link rel="stylesheet" type="text/css" href="css/document.css"/>	
			<title>Alle Mitarbeiter</title> 
		</head>
		<body> 	
			<!-- Alle Mitarbeiter -->	
		   	<h1>Alle Mitarbeiter</h1>
		   	<table border="1">
				<tr>
					<th>ID</th>
					<th>Name</th>
					<th>Vorname</th>
					<th>Dienstalter (in Monaten)</th>
					<th>Fuehrerschein</th>
					<th>Schutzgebiet-ID</th>
				</tr>
				<xsl:for-each select="//alleMitarbeiter/mitarbeiter[not(@id=../preceding-sibling::mitarbeiter/@id)]">
				<tr>
					<td><xsl:value-of select="./@id"/></td>
					<td><xsl:value-of select="./@name"/></td>
					<td><xsl:value-of select="./@vorname"/></td>
					<td><xsl:value-of select="./dienstalter_monate"/></td>
					<td><xsl:value-of select="./fuehrerschein"/></td>
					<td>
					<xsl:call-template name="gebiet">
					<xsl:with-param name="mitarbeiter">
					<xsl:value-of select="./@id"/>
					</xsl:with-param>
					</xsl:call-template>
					</td>
				</tr>
				</xsl:for-each>
			</table>
		   
		</body>
	</xsl:template>
	
	<xsl:template name="gebiet">
		<xsl:param name="mitarbeiter"/>
		<xsl:value-of select="//gebiete/gebiet/@id[//gebiete/gebiet/mitarbeiter_id=$mitarbeiter]"/>
	</xsl:template>
</xsl:stylesheet>