<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/">
	<html>
		<head>
			<link rel="stylesheet" type="text/css" href="css/durchmustern.css"/>
			<title>Dokument durchmustern</title>
		</head>
		<body>
			<h1>Durchmustern eines Dokuments</h1>
			<xsl:apply-templates />
		</body>
	</html>
</xsl:template>
<xsl:template match="*">
	<p class="element">Element: <span class="info"><xsl:value-of select="name()"/></span></p>
	<ul>
		
		<xsl:apply-templates select="*|@*|text()|comment()"/>		
		<!--
		<xsl:apply-templates select="comment()"/>
		<xsl:apply-templates select="@*"/>
		<xsl:apply-templates select="text()"/>
		<xsl:apply-templates select="*"/>
		 -->
	</ul>
</xsl:template>
<xsl:template match="@*">
	<div class="attribut">
		Attribut: <span class="info"><xsl:value-of select="name()"/> </span> 
					mit Wert: <span class="info"><xsl:value-of select="."/></span>
	</div>
</xsl:template>
<xsl:template match="text()">
	<div class="text">
		Text: <span class="info"><xsl:value-of select="normalize-space(.)"/></span>
	</div>
</xsl:template>
<xsl:template match="comment()">
	<p class="comment">
		Kommentar: <span class="info"><xsl:value-of select="normalize-space(.)"/></span>
	</p>
</xsl:template>
</xsl:stylesheet>

