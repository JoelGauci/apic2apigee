<?xml version="1.0" encoding="utf-8"?>
<!--+	
	|************************************************************	
	|*** Author: Joel Gauci - joelgauci@google.com
	|*** file: apic2apigee.security.cors.xsl
	|*** Description: cors specific (security) templates of the migration transformation
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
	|*** Name: apigee:isCorsEnabled
	|******************************************************
	+-->
    <!-- apigee 'isCorsEnabled' function used to know if CORS is enabbled or not -->
    <xsl:function name="apigee:isCorsEnabled">
        <xsl:param name="aNodeSet"/>

        <!-- test if cors is enabled or not -->
        <xsl:choose>
            <xsl:when test="$aNodeSet/spec/x-ibm-configuration/cors/enabled/text() = 'true'"><xsl:value-of select="'true'"/></xsl:when>
            <xsl:otherwise><xsl:value-of select="'false'"/></xsl:otherwise>
        </xsl:choose> 
       
    </xsl:function>
    
</xsl:stylesheet>