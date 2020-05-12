<?xml version="1.0" encoding="utf-8"?>
<!--+	
	|************************************************************	
	|*** Author: Joel Gauci - joelgauci@google.com
	|*** file: apic2apigee.xconfiguration.OperationSwitch.xsl
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
    |*** Element: operation-switch
    |*** Mode: x-configuration
    |********************************
    +-->
    <!-- This template matches the 'operation-switch' element of the document -->
    <xsl:template match="operation-switch" mode="x-configuration">
        <xsl:param name="aApiProxyName"/>
        <xsl:param name="aBasePath"/>
        <xsl:param name="aCors"/>
        <xsl:param name="aCondition"/>
        <xsl:param name="aType"/>

        <!-- Apply templates and push some data at the same time... -->
        <xsl:apply-templates select="case" mode="x-configuration">
            <xsl:with-param name="aApiProxyName" select="$aApiProxyName"/>
            <xsl:with-param name="aBasePath" select="$aBasePath"/>
            <xsl:with-param name="aCors" select="$aCors"/>
            <xsl:with-param name="aCondition" select="$aCondition"/>
            <xsl:with-param name="aType" select="$aType"/>
        </xsl:apply-templates>
        
    </xsl:template>
<!--+
    |********************************
    |*** Matching Template
    |*** Element: case
    |*** Mode: x-configuration
    |********************************
    +-->
    <!-- This template matches the 'case' element of the document -->
    <xsl:template match="case[parent::operation-switch]" mode="x-configuration">
        <xsl:param name="aApiProxyName"/>
        <xsl:param name="aBasePath"/>
        <xsl:param name="aCors"/>
        <xsl:param name="aCondition"/>
        <xsl:param name="aType"/>

        <!-- set a resource for specific processing on this resource -->
        <resource>
            <!-- get some useful info about the resource... -->
            <xsl:variable name="_id" select="./operations/text()"/>
            <xsl:attribute name="id" select="$_id"/>
            
            <xsl:variable name="_httpMethod" select="//*[./operationId/text() = $_id]"/>
            <xsl:attribute name="verb" select="$_httpMethod/local-name()"/>
            
            <xsl:variable name="_path" select="apigee:translateResourcePath($_httpMethod,$_httpMethod/../local-name())"/>
            <xsl:attribute name="path" select="$_path"/>

            <!-- Apply templates ... -->
            <xsl:apply-templates mode="x-configuration">
                <xsl:with-param name="aApiProxyName" select="$aApiProxyName"/>
                <xsl:with-param name="aBasePath" select="$aBasePath"/>
                <xsl:with-param name="aCors" select="$aCors"/>
                <xsl:with-param name="aCondition" select="$aCondition"/>
                <xsl:with-param name="aType" select="$aType"/>
            </xsl:apply-templates>
         </resource>
        
    </xsl:template>

<!--+
    |********************************
    |*** Matching Template
    |*** Element: operations
    |*** Mode: x-configuration
    |********************************
    +-->
    <!-- This template matches the 'operations' element of the document -->
    <xsl:template match="operations" mode="x-configuration">
        <xsl:param name="aApiProxyName"/>
        <xsl:param name="aBasePath"/>
        <xsl:param name="aCors"/>
        <xsl:param name="aCondition"/>
        <xsl:param name="aType"/>

        <!-- Apply templates and push some data at the same time... -->
        <xsl:apply-templates mode="x-configuration">
            <xsl:with-param name="aApiProxyName" select="$aApiProxyName"/>
            <xsl:with-param name="aBasePath" select="$aBasePath"/>
            <xsl:with-param name="aCors" select="$aCors"/>
            <xsl:with-param name="aCondition" select="$aCondition"/>
            <xsl:with-param name="aType" select="$aType"/>
        </xsl:apply-templates>
       
    </xsl:template>
				
</xsl:stylesheet>