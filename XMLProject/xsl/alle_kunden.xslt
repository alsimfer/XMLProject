<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:variable name="leerzeichen">&#160;</xsl:variable>
	<xsl:variable name="strich">&#45;</xsl:variable>
	<xsl:template match="/">
		<html>	
			<xsl:apply-templates/>
		</html>
	</xsl:template>
	<xsl:template match="sicherheitsDienst">
		<head> 
			<link rel="stylesheet" type="text/css" href="css/document.css"/>	
			<title>Alle Kunden</title> 
		</head>
		<body> 	
			<!-- Alle Kunden -->	
		   	<h1>Alle Kunden</h1>
		   	<table border="1">
				<tr>
					<th>ID</th>
					<th>Name</th>
					<th>Vorname</th>
					<th>Geburtsdatum</th>
					<th>Unternehmen</th>
					<th>E-mail</th>
					<th>Telefon</th>
				</tr>
				<xsl:for-each select="//kunden/kunde[not(@id=../preceding-sibling::unternehmen/@id)]">
				<tr>
					<td><xsl:value-of select="./@id"/></td>
					<td><xsl:value-of select="./@name"/></td>
					<td><xsl:value-of select="./@vorname"/></td>
					<td>
						<xsl:choose>
							<xsl:when test="./geburtsDatum">
								<xsl:value-of select="./geburtsDatum"/>
							</xsl:when>
							<xsl:otherwise><xsl:value-of select="$strich"/></xsl:otherwise>
						</xsl:choose>
					</td>
					<td>
						<xsl:choose>
							<xsl:when test="./unternehmen">
								<xsl:value-of select="./unternehmen"/>
							</xsl:when>
							<xsl:otherwise><xsl:value-of select="$strich"/></xsl:otherwise>
						</xsl:choose>
					</td>
					<td><xsl:value-of select="./email"/></td>
					<td><xsl:value-of select="./telefon"/></td>					
				</tr>
				</xsl:for-each>
			</table>
		   
		</body>
	</xsl:template>
</xsl:stylesheet>