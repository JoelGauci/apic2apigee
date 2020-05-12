<?xml version="1.0" encoding="utf-8"?>
<!--+	
	|************************************************************	
	|*** Author: Joel Gauci - joelgauci@google.com
	|*** file: apic2apigee.security.securityDefinitions.xsl
	|*** Description: apiproxy security definitions templates of the migration transformation
	|*** Revision : 1.0 : initial version
	|************************************************************
	+ -->
<xsl:stylesheet version="3.0" 							
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:apigee="http://migration.apigee.com/"
		extension-element-prefixes="apigee" 							
		exclude-result-prefixes="apigee">
	
	<!-- Define the output as an indented XML content -->
	<xsl:output method="xml" indent="yes" encoding="UTF-8"/>
	
<!--+
	|********************************
	|*** Matching Template
	|*** Element: securityDefinitions
	|*** Mode: security
	|********************************
	+-->
	<!-- This template matches the 'securityDefinitions' element of the document -->
	<xsl:template match="securityDefinitions" mode="security">
		<xsl:param name="isCorsEnabled"/>

		<!-- APIKey : Extract information from the spec -->
		<xsl:variable name="_typeFirst" select="./*[1]/type/text()"/>
		<xsl:variable name="_inFirst" select="./*[1]/in/text()"/>
		<xsl:variable name="_nameFirst" select="./*[1]/name/text()"/>
		<xsl:variable name="_elementFirst" select="./*[1]/local-name()"/>

		<!-- APISecret : Extract information from the spec -->
		<xsl:variable name="_typeSecond" select="./*[2]/type/text()"/>
		<xsl:variable name="_inSecond" select="./*[2]/in/text()"/>
		<xsl:variable name="_nameSecond" select="./*[2]/name/text()"/>
		<xsl:variable name="_elementSecond" select="./*[2]/local-name()"/>

		<!-- what is the source from where I can extract the API Key ?-->
        <xsl:variable name="_apiKey">
            <xsl:choose>
                <xsl:when test="contains($_inFirst,'header')">request.header.</xsl:when>
                <xsl:when test="contains($_inFirst,'query')">request.queryparam.</xsl:when>
                <xsl:otherwise>request.queryparam.</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

		<!-- what is the source from where I can extract the API Secret ?-->
        <xsl:variable name="_apiSecret">
            <xsl:choose>
                <xsl:when test="contains($_inSecond,'header')">request.header.</xsl:when>
                <xsl:when test="contains($_inSecond,'query')">request.queryparam.</xsl:when>
                <xsl:otherwise>request.queryparam.</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

		<!-- Set the policy name -->
		<xsl:variable name="_policyName" select="concat('SEC-',$_typeFirst)"/>
		<!-- Set the policy file name -->
		<xsl:variable name="_fileName" select="concat($__APIGEE_PATH_APIPROXY_POLICIES,$_policyName,'.xml')"/>

		<!-- create a security element to store result of analysis -->
		<security>
			<!-- CORS enabled (true) or not (false) -->
			<cors>
				<!-- if set in header, add shortcuts into cors to define apiKey and apiSecret header names -->
				<xsl:if test="contains($_inFirst,'header')">
					<xsl:attribute name="apiKey">
						<xsl:value-of select="$_nameFirst"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="contains($_inSecond,'header')">
					<xsl:attribute name="apiSecret">
						<xsl:value-of select="$_nameSecond"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="$isCorsEnabled"/>
			</cors>
			<profiles>
			<!-- Create the security policy bound to the security definition -->
			<xsl:if test="$_typeFirst = $__OAS_SWAGGER_SECURITYDEFINITIONS_APIKEY">
				<!-- an api key has been defined -->
				<profile type="apikey">
					<xsl:attribute name="name"><xsl:value-of select="$_elementFirst"/></xsl:attribute>
					<!-- -set the scope of the api key verification -->
					<xsl:attribute name="scope">
						<xsl:choose>
							<!-- presence of a 'security' element at the same level, which includes a element of the same name -->
							<xsl:when test="following-sibling::security/*[local-name()=$_elementFirst] or preceding-sibling::security/*[local-name()=$_elementFirst]">all</xsl:when>
							<xsl:otherwise>resources</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
					<!-- useful info added -->
					<type><xsl:value-of select="$_typeFirst"/></type>
					<in><xsl:value-of select="$_inFirst"/></in>
					<name><xsl:value-of select="$_nameFirst"/></name>
				</profile>
			</xsl:if>
			<xsl:if test="$_typeSecond = $__OAS_SWAGGER_SECURITYDEFINITIONS_APIKEY">
				<!-- an api secret has been defined -->
				<profile type="apisecret">
					<xsl:attribute name="name"><xsl:value-of select="$_elementSecond"/></xsl:attribute>
					<!-- -set the scope of the api secret verification -->
					<xsl:attribute name="scope">
						<xsl:choose>
							<xsl:when test="following-sibling::security/*[local-name()=$_elementSecond] or preceding-sibling::security/*[local-name()=$_elementSecond]">all</xsl:when>
							<xsl:otherwise>resources</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
					<!-- useful info added -->
					<type><xsl:value-of select="$_typeSecond"/></type>
					<in><xsl:value-of select="$_inSecond"/></in>
					<name><xsl:value-of select="$_nameSecond"/></name>
				</profile>
			</xsl:if>
			</profiles>
		</security>

	</xsl:template>
			
</xsl:stylesheet>