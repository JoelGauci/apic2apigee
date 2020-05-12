<?xml version="1.0" encoding="utf-8"?>
<!--+	
	|************************************************************	
	|*** Author: Joel Gauci - joelgauci@google.com
	|*** file: apic2apigee.xConfiguration.xsl
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

    <!-- Import XConfiguration templates -->
	
	<!-- 'import' template that imports all the other templates that match the ibm api connect configuration components: policy, invoke, switch,... -->
	<xsl:import href="./templates/xconfiguration/apic2apigee.xconfiguration.Import.xsl"/>

<!--+
    |********************************
    |*** Matching Template
    |*** Element: x-ibm-configuration
    |*** Mode: x-configuration
    |********************************
    +-->
    <!-- This template matches the 'x-ibm-configuration' element of the document -->
    <!-- 'x-ibm-configuration' means it is an extension to the swagger spec; i.e. something specific to ibm api connect  -->
    <xsl:template match="x-ibm-configuration" mode="x-configuration">
        <xsl:param name="aApiProxyName"/>
        <xsl:param name="aBasePath"/>

        <!-- Are CORS enebled or not ? -->
        <xsl:variable name="_isCorsEnabled" select="./cors/enabled/text()"/>
        <!-- CORS enabled: true or false -->
        <xsl:variable name="_cors">
            <xsl:choose>
                <xsl:when test="$_isCorsEnabled = 'true'">true</xsl:when>
                <xsl:otherwise>false</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <!-- Apply templates and push some data at the same time... -->
        <xsl:apply-templates mode="x-configuration">
            <xsl:with-param name="aApiProxyName" select="$aApiProxyName"/>
            <xsl:with-param name="aBasePath" select="$aBasePath"/>
            <xsl:with-param name="aCors" select="$_cors"/>
            <!-- default type is request . other values are : 'response | route' -->
            <xsl:with-param name="aCondition" select="'none'"/>
            <xsl:with-param name="aType" select="'request'"/>
        </xsl:apply-templates>
        
        <!-- copy properties -->
        <xsl:comment>*** api properties - to be migrated into TargetServers and KVMs ***</xsl:comment>
        <xsl:copy-of select="properties"/>
        
    </xsl:template>

<!--+
    |********************************
    |*** Matching Template
    |*** Element: assembly
    |*** Mode: x-configuration
    |********************************
    +-->
    <!-- This template matches the assembly element of the document -->
    <xsl:template match="assembly" mode="x-configuration">
        <xsl:param name="aApiProxyName"/>
        <xsl:param name="aBasePath"/>
        <xsl:param name="aCors"/>
        <xsl:param name="aCondition"/>
        <xsl:param name="aType"/>

        <!-- set the required steps for processing -->
        <steps>
            <!-- Apply templates and push some data at the same time... -->
            <xsl:apply-templates mode="x-configuration">
                <xsl:with-param name="aApiProxyName" select="$aApiProxyName"/>
                <xsl:with-param name="aBasePath" select="$aBasePath"/>
                <xsl:with-param name="aCors" select="$aCors"/>
                <xsl:with-param name="aCondition" select="$aCondition"/>
                <xsl:with-param name="aType" select="$aType"/>
            </xsl:apply-templates>
        </steps>

    </xsl:template>

<!--+
    |********************************
    |*** Matching Template
    |*** Element: execute
    |*** Mode: x-configuration
    |********************************
    +-->
    <!-- This template matches the execute element of the document -->
    <xsl:template match="execute" mode="x-configuration">
        <xsl:param name="aApiProxyName"/>
        <xsl:param name="aBasePath"/>
        <xsl:param name="aCors"/>
        <xsl:param name="aCondition"/>
        <xsl:param name="aType"/>

        <!-- Apply templates and push some data at the same time... -->
        <!-- *** From here we will match the different possibilities in term of ibm api connect configuration *** -->
        <xsl:apply-templates mode="x-configuration">
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
    |*** Element: testable
    |*** Mode: x-configuration
    |********************************
    +-->
    <!-- This template matches the 'testable' element of the document -->
    <xsl:template match="testable" mode="x-configuration"/>

<!--+
    |********************************
    |*** Matching Template
    |*** Element: enforced
    |*** Mode: x-configuration
    |********************************
    +-->
    <!-- This template matches the 'enforced' element of the document -->
    <xsl:template match="enforced" mode="x-configuration"/>
		
</xsl:stylesheet>