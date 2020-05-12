<?xml version="1.0" encoding="utf-8"?>
<!--+	
	|************************************************************	
	|*** Author: Joel Gauci - joelgauci@google.com
	|*** file: apic2apigee.policies.Common.xsl
	|*** Description: common policy templates of the migration transformation
	|*** Revision : 1.0 : initial version
	|************************************************************
	+-->
<xsl:stylesheet version="3.0" 							
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:apigee="http://migration.apigee.com/"
		extension-element-prefixes="apigee" 							
        exclude-result-prefixes="apigee xs">
        
    <!-- Define the output as an indented XML content -->
    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>

<!--+
    |********************************
    |*** Matching Template
    |*** Element: cors
    |*** Mode: security-inside
    |********************************
    +-->
    <!-- This template matches the 'cors' element of the document -->
    <xsl:template match="cors[text() = 'true']" mode="security-inside">

        <!-- Set the CORS policy -->
        <xsl:variable name="_corsPolicy" select="apigee:setCORSPolicy(@apiKey,@apiSecret,$__APIGEE_POLICY_AM_CORS_NAME)"/>

        <!-- Create the API Proxy File at the root of the archive - name of the file is the name of the proxy -->
		<xsl:call-template name="ntCreateFile">
			<xsl:with-param name="aFileName" select="concat($__APIGEE_PATH_APIPROXY_POLICIES,$__APIGEE_POLICY_AM_CORS_NAME,'.xml')"/>
			<xsl:with-param name="aContent" select="$_corsPolicy"/>
		</xsl:call-template>

    </xsl:template>

<!--+
    |********************************
    |*** Matching Template
    |*** Element: profile[@type = 'apikey']
    |*** Mode: security-inside
    |********************************
    +-->
    <!-- This template matches the 'proxy' element of the document -->
    <xsl:template match="profile[@type = 'apikey']" mode="security-inside">
    
        <!-- Create the API Proxy File at the root of the archive - name of the file is the name of the proxy -->
		<xsl:call-template name="ntCreateFile">
			<xsl:with-param name="aFileName" select="concat($__APIGEE_PATH_APIPROXY_POLICIES,$__APIGEE_POLICY_VAK_VERIFYAPIKEY_NAME,'.xml')"/>
			<xsl:with-param name="aContent" select="apigee:setVAKPolicy(./in/text(),./name/text(),$__APIGEE_POLICY_VAK_VERIFYAPIKEY_NAME)"/>
		</xsl:call-template>

    </xsl:template>
<!--+
    |********************************
    |*** Matching Template
    |*** Element: profiles
    |*** Mode: security-flows
    |********************************
    +-->
    <!-- This template matches the 'profiles' element of the security node-set -->
    <xsl:template match="profiles" mode="security-flows">
        <xsl:param name="aCors"/>
        <xsl:param name="aSecurityNodeSet"/>

        <!-- Request definition -->
        <xsl:apply-templates select="profile[@scope = 'all']" mode="security-flows">
            <xsl:with-param name="aCors" select="$aCors"/>
            <xsl:with-param name="aSecurityNodeSet" select="$aSecurityNodeSet"/>
        </xsl:apply-templates>

    </xsl:template>

<!--+
    |********************************
    |*** Matching Template
    |*** Element: profile[@scope = 'all']
    |*** Mode: security-flows
    |********************************
    +-->
    <!-- This template matches the 'profile' element of the security node-set -->
    <xsl:template match="profile[@scope = 'all']" mode="security-flows">
        <xsl:param name="aCors"/>
        <xsl:param name="aSecurityNodeSet"/>

        <!-- add API Key verification policy -->
        <xsl:if test="@type = 'apikey'">
            <Step>
                <Name><xsl:value-of select="$__APIGEE_POLICY_VAK_VERIFYAPIKEY_NAME"/></Name>
                <xsl:choose>
                    <xsl:when test="$aCors = 'true'">
                        <Condition><xsl:value-of select="$__APIGEE_POLICY_AM_CORS_CONDITION_NOT_EQUAL"/></Condition>
                    </xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>
            </Step>
        </xsl:if>
        <!-- add API Secret verification policy -->
        <xsl:if test="@type = 'apisecret'">

            <!-- extract data related to api secret from securiy node-set -->
            <xsl:variable name="_conditionPrefix" select="$__APIGEE_CONDITION_APISECRET_CHECK_PREFIX_METHOD"/>
            <xsl:variable name="_apikeyIn" select="$aSecurityNodeSet/security/profiles/profile[@type = 'apikey']/in/text()"/>
            <xsl:variable name="_apikeyName" select="$aSecurityNodeSet/security/profiles/profile[@type = 'apikey']/name/text()"/>

            <!-- what is the source from where I can extract the API Key ?-->
            <xsl:variable name="_apikeyContext">
                <xsl:choose>
                    <xsl:when test="contains($_apikeyIn,'header')"><xsl:value-of select="concat('request.header.',$_apikeyName)"/></xsl:when>
                    <xsl:when test="contains($_apikeyIn,'query')"><xsl:value-of select="concat('request.queryparam.',$_apikeyName)"/></xsl:when>
                    <xsl:otherwise><xsl:value-of select="concat('request.queryparam.',$_apikeyName)"/></xsl:otherwise>
                </xsl:choose>
            </xsl:variable>

            <Step>
                <Name><xsl:value-of select="$__APIGEE_POLICY_RF_VERIFYAPISECRET_NAME"/></Name>
                <xsl:choose>
                    <xsl:when test="$aCors = 'true'">
                        <Condition><xsl:value-of select="concat('(',$__APIGEE_POLICY_AM_CORS_CONDITION_NOT_EQUAL,') and (',$_conditionPrefix,$_apikeyContext,')')"/></Condition>
                    </xsl:when>
                    <xsl:otherwise>
                        <Condition><xsl:value-of select="concat($_conditionPrefix,$_apikeyContext)"/></Condition>
                    </xsl:otherwise>
                </xsl:choose>
            </Step>
        </xsl:if>

    </xsl:template>

<!--+
    |********************************
    |*** Matching Template
    |*** Element: profile[@type = 'apisecret']
    |*** Mode: security-inside
    |********************************
    +-->
    <!-- This template matches the 'proxy' element of the document -->
    <xsl:template match="profile[@type = 'apisecret']" mode="security-inside">
    
        <!-- Create the API Proxy File at the root of the archive - name of the file is the name of the proxy -->
		<xsl:call-template name="ntCreateFile">
			<xsl:with-param name="aFileName" select="concat($__APIGEE_PATH_APIPROXY_POLICIES,$__APIGEE_POLICY_RF_VERIFYAPISECRET_NAME,'.xml')"/>
			<xsl:with-param name="aContent" select="apigee:setRFVerifyAPISecretPolicy($__APIGEE_POLICY_RF_VERIFYAPISECRET_NAME)"/>
		</xsl:call-template>

    </xsl:template>
    
</xsl:stylesheet>