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
			<title>Route</title> 
		</head>
		<body> 	
			<!-- Alle Unternehmen -->	
		   	<h1>Route</h1>
		   	<table border="1">
				<tr>
					<th>Name</th>
					<th>Adresse</th>
					<th>E-mail</th>
					<th>Telefon</th>
				</tr>
				<xsl:for-each select="//sicherheitsUnternehmen/unternehmen[not(@name=../preceding-sibling::unternehmen/@name)]">
				<tr>
					<td><xsl:value-of select="./@name"/></td>
					<td><xsl:call-template name="adresse">
							<xsl:with-param name="name"><xsl:value-of select="./@name"/></xsl:with-param>
						</xsl:call-template>
					</td>
					<td><xsl:value-of select="./@email"/></td>
					<td><xsl:value-of select="./@telefon"/></td>
					
				</tr>
				</xsl:for-each>
			</table>
		   
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