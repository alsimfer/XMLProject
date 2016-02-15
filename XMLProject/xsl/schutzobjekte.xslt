<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/>
	
	<xsl:param name="kunde"/>
	<xsl:variable name="leerzeichen">&#160;</xsl:variable>
	<xsl:variable name="strich">&#45;</xsl:variable>
	<xsl:variable name="ampersand">&amp;</xsl:variable>	
	<xsl:variable name="komma">&#44;</xsl:variable>
	<xsl:variable name="klammerAuf">&#40;</xsl:variable>
	<xsl:variable name="klammerZu">&#41;</xsl:variable>
	<xsl:template match="/">
		<style type="text/css">
			#table { height: 10%; overflow-y:auto; }
			#map { height: 83%; }	
		</style>	
		
		<!-- Schutzobjekte -->	
	   	<h1>Schutzobjekte nach Kunden</h1>
	   	<div id="table">
		   	<table>
				<tr>
					<th>ID</th>
					<th>Kunde</th>
					<th>Strasse mit Hausnummer</th>
					<th>Ort</th>
					<th>Verantwortlicher (Verantwortlicher-ID)</th>
				</tr>
				<xsl:for-each select="//kunden/kunde[@id=$kunde and not(schutzObjekte/objekt/@id=../preceding-sibling::schutzObjekte/objekt/@id)]">
					<tr>
						<td><xsl:value-of select="./schutzObjekte/objekt/@id"/></td>
						<td><xsl:value-of select="./unternehmen"/></td>
						<td>
							<xsl:for-each select="./schutzObjekte/objekt">
								<div>
									<xsl:value-of select="./objektAdresse/@strasse"/>
									<xsl:value-of select="$leerzeichen"/>
									<xsl:value-of select="./objektAdresse/@hausnummer"/>
								</div>								
							</xsl:for-each>
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
		</div>		
		<div id="map">
		</div>
	</xsl:template>
	
	<xsl:template name="objektVerantwortlicher">
		<xsl:param name="objekt"/>
		<xsl:for-each select="//gebiete/gebiet[gebietSchutzObjekte/objekt_id=$objekt]">
			<xsl:for-each select="./mitarbeiter_id">
				<xsl:call-template name="mitarbeiter">
					<xsl:with-param name="mr"><xsl:value-of select="." /></xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
		</xsl:for-each>		
	</xsl:template>
	
	<xsl:template name="mitarbeiter">
		<xsl:param name="mr"/>
		<div>
		<xsl:for-each select="//alleMitarbeiter/mitarbeiter[@id=$mr]">
			<xsl:value-of select="./@name"></xsl:value-of>
			<xsl:value-of select="$komma"></xsl:value-of>
			<xsl:value-of select="$leerzeichen"></xsl:value-of>
			<xsl:value-of select="./@vorname"></xsl:value-of>
			<xsl:value-of select="$leerzeichen"></xsl:value-of>
			<xsl:value-of select="$klammerAuf" /><xsl:value-of select="$mr" /><xsl:value-of select="$klammerZu" />
		</xsl:for-each>
		</div>
	</xsl:template>
	
</xsl:stylesheet>