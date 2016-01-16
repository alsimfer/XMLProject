<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/>
	
	<xsl:param name="kunde"/>
	<xsl:variable name="leerzeichen">&#160;</xsl:variable>
	<xsl:variable name="strich">&#45;</xsl:variable>
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
			<title>Schutzobjekte nach Kunden</title> 
		</head>
		<body> 	
			<!-- Schutzobjekte -->	
		   	<h1>Schutzobjekte nach Kunden</h1>
		   	<table border="1">
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
		   
		</body>
	</xsl:template>
	
	<xsl:template name="objektVerantwortlicher">
		<xsl:param name="objekt"/>
		
		<xsl:call-template name="mitarbeiter">
			<xsl:with-param name="mr"><xsl:value-of select="//gebiete/gebiet/mitarbeiter_id[//gebiete/gebiet/gebietSchutzObjekte/objekt_id=$objekt]" /></xsl:with-param>
		</xsl:call-template>
		
	</xsl:template>
	
	<xsl:template name="mitarbeiter">
		<xsl:param name="mr"/>
		<div>
			<xsl:value-of select="//alleMitarbeiter/mitarbeiter/@name[//alleMitarbeiter/mitarbeiter/@id=$mr]"></xsl:value-of>
			<xsl:value-of select="$komma"></xsl:value-of>
			<xsl:value-of select="$leerzeichen"></xsl:value-of>
			<xsl:value-of select="//alleMitarbeiter/mitarbeiter/@vorname[//alleMitarbeiter/mitarbeiter/@id=$mr]"></xsl:value-of>
			<xsl:value-of select="$leerzeichen"></xsl:value-of>
			<xsl:value-of select="$klammerAuf" /><xsl:value-of select="$mr" /><xsl:value-of select="$klammerZu" />
		</div>
	</xsl:template>
	
</xsl:stylesheet>