<?xml version="1.0" encoding="utf-8"?>
<!--+	
	|************************************************************	
	|*** Author: Joel Gauci - joelgauci@google.com
	|*** file: apic2apigee.policies.AM-Cors.xsl
	|*** Description: policy templates of the migration transformation
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
    |
    + #====================XSLT Functions====================#
    |
    +-->
             
<!--+
	|******************************************************
	|*** XSLT Function
	|*** Name: apigee:setCORSPolicy
	|******************************************************
	+-->
    <!-- apigee 'setCORSPolicy' function used to create a CORS Policy -->
    <xsl:function name="apigee:setCORSPolicy">
        <xsl:param name="aAPIKey"/>
        <xsl:param name="aAPISecret"/>
        <xsl:param name="aPolicyName"/>
        
        <xsl:sequence>

            <!-- CORS POLICY -->
            <AssignMessage async="false" continueOnError="false" enabled="true" name="{$aPolicyName}">
                <DisplayName><xsl:value-of select="$aPolicyName"/></DisplayName>
                <Properties/>
                <Set>
                    <Headers>
                        <Header name="Access-Control-Allow-Origin"><xsl:value-of select="$__APIGEE_POLICY_AM_CORS_ACCESS-CONTROL-ALLOW-ORIGIN"/></Header>
                        <Header name="Access-Control-Allow-Headers">
                            <!-- Add API key and secret headers if required -->
                            <xsl:choose>
                                <xsl:when test="($aAPIKey != 'none') and ($aAPISecret != 'none')">
                                    <xsl:value-of select="concat($__APIGEE_POLICY_AM_CORS_ACCESS-CONTROL-ALLOW-HEADERS,',',$aAPIKey,',',$aAPISecret)"/>
                                </xsl:when>
                                <xsl:when test="$aAPIKey != 'none'">
                                    <xsl:value-of select="concat($__APIGEE_POLICY_AM_CORS_ACCESS-CONTROL-ALLOW-HEADERS,',',$aAPIKey)"/>
                                </xsl:when>
                                <xsl:when test="$aAPISecret != 'none'">
                                    <xsl:value-of select="concat($__APIGEE_POLICY_AM_CORS_ACCESS-CONTROL-ALLOW-HEADERS,',',$aAPISecret)"/>
                                </xsl:when>
                                <xsl:otherwise><xsl:value-of select="$__APIGEE_POLICY_AM_CORS_ACCESS-CONTROL-ALLOW-HEADERS"/></xsl:otherwise>
                            </xsl:choose>
                        </Header>
                        <Header name="Access-Control-Max-Age"><xsl:value-of select="$__APIGEE_POLICY_AM_CORS_ACCESS-CONTROL-MAX-AGE"/></Header>
                        <Header name="Access-Control-Allow-Methods"><xsl:value-of select="$__APIGEE_POLICY_AM_CORS_ACCESS-CONTROL-ALLOW-METHODS"/></Header>
                    </Headers>
                </Set>
                <IgnoreUnresolvedVariables>true</IgnoreUnresolvedVariables>
                <AssignTo createNew="false" transport="http" type="response"/>
            </AssignMessage>

        </xsl:sequence>
    </xsl:function>
    
</xsl:stylesheet>