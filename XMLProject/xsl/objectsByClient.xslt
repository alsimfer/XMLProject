<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	
	<xsl:param name="kunde"/>
	<xsl:variable name="leerzeichen">&#160;</xsl:variable>
	<xsl:variable name="strich">&#45;</xsl:variable>
	<xsl:variable name="ampersand">&amp;</xsl:variable>	
	<xsl:variable name="komma">&#44;</xsl:variable>
	<xsl:variable name="klammerAuf">&#40;</xsl:variable>
	<xsl:variable name="klammerZu">&#41;</xsl:variable>
	<xsl:template match="/">
		<objects>
			<xsl:for-each select="//kunden/kunde[@id=$kunde]">
				<xsl:for-each select="./schutzObjekte/objekt">
					<object>
						<x><xsl:value-of select="./objektAdresse/koordinate_x"/></x>
						<y><xsl:value-of select="./objektAdresse/koordinate_y"/></y>
					</object>
				</xsl:for-each>
			</xsl:for-each>
		</objects>
	</xsl:template>
	
</xsl:stylesheet>