<?xml version="1.0" encoding="utf-8"?>
<!--+	
	|************************************************************	
	|*** Author: Joel Gauci - joelgauci@google.com
	|*** file: apic2apigee.policies.VAK-VerifyAPIKey.xsl
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
	|*** Name: apigee:setVAKPolicy
	|******************************************************
	+-->
    <!-- apigee 'setVAKPolicy' function used to create VAK Policy (Verify API Key) -->
    <xsl:function name="apigee:setVAKPolicy">
        <xsl:param name="aIn"/>
        <xsl:param name="aName"/>
        <xsl:param name="aPolicyName"/>

        <!-- what is the source from where I can extract the API Key ?-->
        <xsl:variable name="_in">
            <xsl:choose>
                <xsl:when test="contains($aIn,'header')">request.header.</xsl:when>
                <xsl:when test="contains($aIn,'query')">request.queryparam.</xsl:when>
                <xsl:otherwise>request.queryparam.</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:sequence>

            <!-- VAK POLICY -->
            <VerifyAPIKey async="false" continueOnError="false" enabled="true" name="{$aPolicyName}">
                <DisplayName><xsl:value-of select="$aPolicyName"/></DisplayName>
                <Properties/>
                <APIKey>
                    <xsl:attribute name="ref">
                        <xsl:value-of select="concat($_in,$aName)"/>
                    </xsl:attribute>
                </APIKey>
            </VerifyAPIKey>

        </xsl:sequence>

    </xsl:function>
    
</xsl:stylesheet>