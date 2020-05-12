<?xml version="1.0" encoding="utf-8"?>
<!--+	
	|************************************************************	
	|*** Author: Joel Gauci - joelgauci@google.com
	|*** file: apic2apigee.xconfiguration.Invoke.xsl
	|*** Description: x-configuration templates of the migration transformation
	|*** Revision : 1.0 : initial version
	|************************************************************
	+-->
<xsl:stylesheet version="3.0" 							
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:apigee="http://migration.apigee.com/"
		extension-element-prefixes="apigee" 							
		exclude-result-prefixes="apigee xs">

<!--+
    |********************************
    |*** Matching Template
    |*** Element: invoke
    |*** Mode: x-configuration
    |********************************
    +-->
    <!-- This template matches the 'invoke' element of the document -->
    <xsl:template match="invoke" mode="x-configuration">
        <xsl:param name="aApiProxyName"/>
        <xsl:param name="aBasePath"/>
        <xsl:param name="aCors"/>
        <xsl:param name="aCondition"/>
        <xsl:param name="aType"/>

        <!-- set the '@type' attribute: request (default) | response | route -->
        <xsl:variable name="_type" select="apigee:setType(.,local-name())"/>

        <!-- generate a unique identifier the element -->
        <xsl:variable name="_id" select="generate-id()"/>

        <!-- set the invoke element to be processed -->
        <invoke condition="{$aCondition}" id="{$_id}">
            <!-- add '@type' attribute to the invoke element -->
            <xsl:attribute name="type" select="$_type"/>
            <!-- simple copy of the element -->
            <xsl:copy-of select="./*"/>

             <!-- Apply templates and push some data at the same time... -->
            <xsl:apply-templates mode="x-configuration">
                <xsl:with-param name="aApiProxyName" select="$aApiProxyName"/>
                <xsl:with-param name="aBasePath" select="$aBasePath"/>
                <xsl:with-param name="aCors" select="$aCors"/>
                <xsl:with-param name="aCondition" select="$aCondition"/>
                <xsl:with-param name="aType" select="$aType"/>
            </xsl:apply-templates>
        </invoke>

    </xsl:template>
				
</xsl:stylesheet>