<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:fo="http://www.w3.org/1999/XSL/Format"
				xmlns:java="http://xml.apache.org/xslt/java" 
				exclude-result-prefixes="java">  
	<xsl:param name="unfall"/>
	<xsl:variable name="leerzeichen">&#160;</xsl:variable>
	<xsl:variable name="komma">&#44;</xsl:variable>
	<xsl:variable name="currentDate"><xsl:value-of select="java:format(java:java.text.SimpleDateFormat.new('yyyy-MM-dd'), java:java.util.Date.new())"/></xsl:variable>
	
	<xsl:template match="/">
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
			<fo:layout-master-set>
				<fo:simple-page-master		master-name="A4"
					page-width="210mm"		page-height="297mm"
					margin-top="15mm"		margin-bottom="15mm"
					margin-left="25mm"		margin-right="25mm">
					<fo:region-body margin-top="15mm" margin-bottom="15mm"/>
					<fo:region-before extent="15mm"/>				
					<fo:region-after extent="15mm"/>
				</fo:simple-page-master>
			</fo:layout-master-set>			
			<xsl:apply-templates/>
		</fo:root>
	</xsl:template>
	<xsl:attribute-set name="u1">
		<xsl:attribute name="font-size">14pt</xsl:attribute>
		<xsl:attribute name="font-family">sans-serif</xsl:attribute>
		<xsl:attribute name="color">#aa3333</xsl:attribute>
		<xsl:attribute name="space-before">5mm</xsl:attribute>
		<xsl:attribute name="space-after">2mm</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="u2">
		<xsl:attribute name="font-size">12pt</xsl:attribute>
		<xsl:attribute name="font-family">sans-serif</xsl:attribute>
		<xsl:attribute name="color">#dd3333</xsl:attribute>
		<xsl:attribute name="space-before">5mm</xsl:attribute>
		<xsl:attribute name="space-after">2mm</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="standard">
		<xsl:attribute name="font-size">10pt</xsl:attribute>
		<xsl:attribute name="font-family">sans-serif</xsl:attribute>
		<xsl:attribute name="color">black</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="th">
		<xsl:attribute name="font-size">10pt</xsl:attribute>
		<xsl:attribute name="font-family">sans-serif</xsl:attribute>
		<xsl:attribute name="text-align">center</xsl:attribute>
		<xsl:attribute name="color">black</xsl:attribute>
		<xsl:attribute name="padding">5pt</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="td">
		<xsl:attribute name="font-size">10pt</xsl:attribute>
		<xsl:attribute name="font-family">sans-serif</xsl:attribute>
		<xsl:attribute name="color">black</xsl:attribute>
		<xsl:attribute name="margin">5pt</xsl:attribute>
	</xsl:attribute-set>
		<xsl:attribute-set name="td_zahl">
		<xsl:attribute name="font-size">10pt</xsl:attribute>
		<xsl:attribute name="font-family">sans-serif</xsl:attribute>
		<xsl:attribute name="text-align">right</xsl:attribute>
		<xsl:attribute name="color">black</xsl:attribute>
		<xsl:attribute name="font-weight">bold</xsl:attribute>
		<xsl:attribute name="margin">5pt</xsl:attribute>
		<xsl:attribute name="margin-right">5pt</xsl:attribute>
	</xsl:attribute-set>


	<xsl:template match="sicherheitsDienst">
		<fo:page-sequence  master-reference="A4">
			<fo:static-content flow-name="xsl-region-before">

				<fo:block font-size="9pt"  text-align="center">
						<xsl:value-of select="./@title"/> "<xsl:value-of select="//sicherheitsUnternehmen/@name"/>"
				</fo:block>
				<fo:block font-size="9pt"  text-align="center">
						<xsl:value-of select="//sicherheitsUnternehmen/@email"/>
				</fo:block>
				<fo:block font-size="9pt"  text-align="center">
						<xsl:value-of select="//sicherheitsUnternehmen/@telefon"/>
				<fo:block/>		
				<fo:leader leader-length="160mm" leader-pattern="rule"
						rule-thickness="2pt"/> 
				</fo:block>
				
			</fo:static-content>
			<fo:flow flow-name="xsl-region-body">
				<xsl:element name="fo:block" use-attribute-sets="u1">Rechnung 
					<xsl:for-each select="//rechnungen/rechnung[@unfallId = $unfall]">
					<xsl:value-of select="./@id"/>
					</xsl:for-each>	
				</xsl:element>
				<xsl:element name="fo:block" use-attribute-sets="standard">Datum: <xsl:value-of select="$currentDate"/></xsl:element>
						
				<xsl:element name="fo:block" use-attribute-sets="u2">Kunde</xsl:element>
				<xsl:element name="fo:block" use-attribute-sets="standard">
					<xsl:call-template name="kunde">
					<xsl:with-param name="kundeId">
					<xsl:for-each select="//unfaelle/unfall[@id=$unfall]">
						<xsl:value-of select="./kunde_id" />
					</xsl:for-each>
					</xsl:with-param>
					</xsl:call-template>
				</xsl:element>
				<xsl:element name="fo:block" use-attribute-sets="u2">Unfall</xsl:element>
				<fo:block>
					<fo:table border="5mm" width="170mm" border-style="solid" border-width="2pt">
							<fo:table-column column-width="60mm"/>
							<fo:table-column column-width="30mm"/>
							<fo:table-column column-width="20mm"/>
							<fo:table-column column-width="30mm"/>
							<fo:table-column column-width="30mm"/>
							<fo:table-body>
								<fo:table-row>
									<fo:table-cell border-style="solid" border-width="1pt">
										<xsl:element name="fo:block" use-attribute-sets="th">Objekt</xsl:element>
									</fo:table-cell>
									<fo:table-cell border-style="solid" border-width="1pt">
										<xsl:element name="fo:block" use-attribute-sets="th">Datum</xsl:element>
									</fo:table-cell>
									<fo:table-cell border-style="solid" border-width="1pt">
										<xsl:element name="fo:block" use-attribute-sets="th">Uhrzeit</xsl:element>
									</fo:table-cell>
									<fo:table-cell border-style="solid" border-width="1pt">
										<xsl:element name="fo:block" use-attribute-sets="th">Ursache</xsl:element>
									</fo:table-cell>
									<fo:table-cell border-style="solid" border-width="1pt">
										<xsl:element name="fo:block" use-attribute-sets="th">Betrag</xsl:element>
									</fo:table-cell>
								</fo:table-row>
								<xsl:for-each select="//unfall[@id=$unfall]">
									<fo:table-row>
										<fo:table-cell border-style="solid" border-width="1pt">
											<xsl:element name="fo:block" use-attribute-sets="td">
											<xsl:call-template name="objekt">
												<xsl:with-param name="objektId">
												<xsl:value-of select="./objekt_id" />
												</xsl:with-param>
											</xsl:call-template>
											</xsl:element>	
										</fo:table-cell>
										<fo:table-cell border-style="solid" border-width="1pt" >
											<xsl:element name="fo:block" use-attribute-sets="td">
												<xsl:value-of select="./datum" />
											</xsl:element>	
										</fo:table-cell>
										<fo:table-cell border-style="solid" border-width="1pt" >
											<xsl:element name="fo:block" use-attribute-sets="td">
												<xsl:value-of select="./uhrzeit" />
											</xsl:element>	
										</fo:table-cell>
										<fo:table-cell border-style="solid" border-width="1pt" >
											<xsl:element name="fo:block" use-attribute-sets="td">
												<xsl:value-of select="./ursache" />
											</xsl:element>	
										</fo:table-cell>
										<fo:table-cell border-style="solid" border-width="1pt" >
											<xsl:element name="fo:block" use-attribute-sets="td_zahl">
											<xsl:for-each select="//rechnungen/rechnung[@unfallId = $unfall]">
												<xsl:value-of select="./rechnungsBetrag" />
											</xsl:for-each>
											</xsl:element>	
										</fo:table-cell>
									</fo:table-row>
								</xsl:for-each>
							</fo:table-body>
						</fo:table>
				</fo:block>				
			</fo:flow>
		</fo:page-sequence>
	</xsl:template>	
	
	<xsl:template name="kunde">
		<xsl:param name="kundeId"/>
		<xsl:for-each select="//kunden/kunde[@id = $kundeId]">
			<xsl:element name="fo:block" use-attribute-sets="standard">
				<xsl:value-of select="./@name" />
				<xsl:value-of select="$komma" />
				<xsl:value-of select="$leerzeichen" />
				<xsl:value-of select="./@vorname" />
			</xsl:element>
			<xsl:element name="fo:block" use-attribute-sets="standard">
				<xsl:if test="./geburtsDatum">
					Geburtsdatum: <xsl:value-of select="./geburtsDatum" />
				</xsl:if>
			</xsl:element>
			<xsl:element name="fo:block" use-attribute-sets="standard">
				<xsl:if test="./unternehmen">
					Unternehmen: <xsl:value-of select="./unternehmen" />
				</xsl:if>
			</xsl:element>
			<xsl:element name="fo:block" use-attribute-sets="standard">
				<xsl:value-of select="./email"/>
			</xsl:element>
			<xsl:element name="fo:block" use-attribute-sets="standard">
				<xsl:value-of select="./telefon"/>
			</xsl:element>
		
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template name="objekt">
	<xsl:param name="objektId"/>
	
	<xsl:for-each select="//schutzObjekte/objekt[@id=$objektId]">
			<xsl:element name="fo:block" use-attribute-sets="standard"><xsl:value-of select="./objektAdresse/@strasse"/>
				<xsl:value-of select="$leerzeichen"/>
				<xsl:value-of select="./objektAdresse/@hausnummer"/>
			</xsl:element>
			<xsl:element name="fo:block" use-attribute-sets="standard">
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
			</xsl:element>
	</xsl:for-each>

	</xsl:template>

	
</xsl:stylesheet>
