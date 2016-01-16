<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:variable name="leerzeichen">&#160;</xsl:variable>
	<xsl:variable name="komma">&#44;</xsl:variable>
	<xsl:template match="/">
		<html>	
			<xsl:apply-templates/>
		</html>
	</xsl:template>
	<xsl:template match="sicherheitsDienst">
		<head> 
			<link rel="stylesheet" type="text/css" href="css/document.css"/>	
			<title>Alle Unternehmen</title> 
		</head>
		<body> 	
			<!-- Alle Unfaelle -->	
		   	<h1>Alle Unfaelle</h1>
		   	<table border="1">
				<tr>
					<th>ID</th>
					<th>Kunden-ID</th>
					<th>Objekt</th>
					<th>Datum</th>
					<th>Uhrzeit</th>
					<th>Ursache</th>
				</tr>
				<xsl:for-each select="//unfaelle/unfall[not(@id=../preceding-sibling::unfall/@id)]">
				<tr>
					<td><xsl:value-of select="./@id"/></td>
					<td><xsl:value-of select="./kunde_id"/></td>
					<td>
						<xsl:call-template name="objekt">
							<xsl:with-param name="objektId"><xsl:value-of select="./objekt_id"/></xsl:with-param>
						</xsl:call-template>
					</td>
					<td><xsl:value-of select="./datum"/></td>
					<td><xsl:value-of select="./uhrzeit"/></td>
					<td><xsl:value-of select="./ursache"/></td>
				</tr>
				</xsl:for-each>
			</table>
		   
		</body>
	</xsl:template>
	
	<xsl:template name="objekt">
	<xsl:param name="objektId"/>
	
	<xsl:for-each select="//schutzObjekte/objekt[@id=$objektId]">
			<div><xsl:value-of select="./objektAdresse/@strasse"/>
				<xsl:value-of select="$leerzeichen"/>
				<xsl:value-of select="./objektAdresse/@hausnummer"/>
			</div>
			<div>
				<xsl:value-of select="./objektAdresse/@zip"/>
				<xsl:value-of select="$leerzeichen"/>
				<xsl:value-of select="./objektAdresse/@stadt"/>
				<xsl:value-of select="$komma"/>
				<xsl:value-of select="$leerzeichen"/>
				<xsl:choose>
					<xsl:when test="./objektAdresse/@land">
						<xsl:value-of select="./objektAdresse/@land"/>
					</xsl:when>
					<xsl:otherwise>Deutschland</xsl:otherwise>
				</xsl:choose>
			</div>
	</xsl:for-each>

	</xsl:template>
	
</xsl:stylesheet>