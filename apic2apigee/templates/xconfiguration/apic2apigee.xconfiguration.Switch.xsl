<?xml version="1.0" encoding="utf-8"?>
<!--+	
	|************************************************************	
	|*** Author: Joel Gauci - joelgauci@google.com
	|*** file: apic2apigee.xconfiguration.Switch.xsl
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
    |*** Element: switch
    |*** Mode: x-configuration
    |********************************
    +-->
    <!-- This template matches the 'switch' element of the document -->
    <xsl:template match="switch" mode="x-configuration">
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
    |*** Element: case[parent::switch]
    |*** Mode: x-configuration
    |********************************
    +-->
    <!-- This template matches the 'case' element of the document -->
    <xsl:template match="case[parent::switch]" mode="x-configuration">
        <xsl:param name="aApiProxyName"/>
        <xsl:param name="aBasePath"/>
        <xsl:param name="aCors"/>
        <xsl:param name="aCondition"/>
        <xsl:param name="aType"/>

        <!-- set the expression '_condition' variable -->
        <xsl:variable name="_condition">
            <xsl:apply-templates select="condition|otherwise" mode="expression">
                <xsl:with-param name="aApiProxyName" select="$aApiProxyName"/>
                <xsl:with-param name="aBasePath" select="$aBasePath"/>
                <xsl:with-param name="aCors" select="$aCors"/>
                <xsl:with-param name="aCondition" select="$aCondition"/>
                <xsl:with-param name="aType" select="$aType"/>
            </xsl:apply-templates>
        </xsl:variable>

        <!-- Apply templates and push some data at the same time... -->
        <xsl:apply-templates mode="x-configuration">
            <xsl:with-param name="aApiProxyName" select="$aApiProxyName"/>
            <xsl:with-param name="aBasePath" select="$aBasePath"/>
            <xsl:with-param name="aCors" select="$aCors"/>
            <xsl:with-param name="aCondition" select="$_condition"/>
            <xsl:with-param name="aType" select="$aType"/>
        </xsl:apply-templates>
        
    </xsl:template>

<!--+
    |********************************
    |*** Matching Template
    |*** Element: condition
    |*** Mode: x-configuration
    |********************************
    +-->
    <!-- This template matches the 'operations' element of the document -->
    <xsl:template match="condition" mode="x-configuration">
        <xsl:param name="aApiProxyName"/>
        <xsl:param name="aBasePath"/>
        <xsl:param name="aCors"/>
        <xsl:param name="aCondition"/>
        <xsl:param name="aType"/>

        <!-- set a resource for specific processing on this resource -->
        <!-- condition -->

        <!-- translate the condition in order to make it usable on apigee -->
        <!-- xsl:value-of select="apigee:translateSwitchCondition( text() )"/ -->
        
        <!-- Apply templates and push some data at the same time... -->
        <xsl:apply-templates mode="x-configuration">
            <xsl:with-param name="aApiProxyName" select="$aApiProxyName"/>
            <xsl:with-param name="aBasePath" select="$aBasePath"/>
            <xsl:with-param name="aCors" select="$aCors"/>
            <xsl:with-param name="aCondition" select="$aCondition"/>
            <xsl:with-param name="aType" select="$aType"/>
        </xsl:apply-templates>

        <!-- /condition -->

    </xsl:template>
<!--+
    |********************************
    |*** Matching Template
    |*** Element: otherwise
    |*** Mode: x-configuration
    |********************************
    +-->
    <!-- This template matches the 'operations' element of the document -->
    <xsl:template match="otherwise" mode="x-configuration">
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
            <xsl:with-param name="aCondition" select="'otherwise'"/>
            <xsl:with-param name="aType" select="$aType"/>
        </xsl:apply-templates>

    </xsl:template>

<!--+
    |********************************
    |*** Matching Template
    |*** Element: condition
    |*** Mode: expression
    |********************************
    +-->
    <!-- This template matches the 'operations' element of the document -->
    <xsl:template match="condition" mode="expression">
        <xsl:param name="aApiProxyName"/>
        <xsl:param name="aBasePath"/>
        <xsl:param name="aCors"/>
        <xsl:param name="aCondition"/>
        <xsl:param name="aType"/>

        <!-- translate the condition in order to make it usable on apigee -->
        <xsl:variable name="_condition" select="apigee:translateSwitchCondition( text() )"/>

        <!-- cumulate condition or not -->
        <xsl:choose>
            <xsl:when test="$aCondition = 'none'">
                <xsl:value-of select="$_condition"/> 
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat($aCondition,' and ',$_condition)"/> 
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

<!--+
	|******************************************************
	|*** XSLT Function
	|*** Name: apigee:translateSwitchCondition
	|******************************************************
	+-->
    <!-- apigee 'translateSwitchCondition' function used to translate apic to apigee switch condition -->
    <!-- apigee docs: https://docs.apigee.com/api-platform/reference/variables-reference -->
    <xsl:function name="apigee:translateSwitchCondition">
        <xsl:param name="aCondition"/>
        
	    <!-- translate a string containing a switch / apim.getvariable('') condition -->
        <xsl:variable name="firstReplace" select="replace($aCondition,$__APIC_APIM_GET_VARIABLE_PREFIX,'')"/>
        <xsl:sequence>
            <xsl:value-of select="apigee:translateContextVariable(replace($firstReplace,$__APIC_APIM_GET_VARIABLE_SUFFIX,''))"/>
        </xsl:sequence>

    </xsl:function>
				
</xsl:stylesheet>