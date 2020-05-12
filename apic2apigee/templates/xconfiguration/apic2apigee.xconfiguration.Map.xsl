<?xml version="1.0" encoding="utf-8"?>
<!--+	
	|************************************************************	
	|*** Author: Joel Gauci - joelgauci@google.com
	|*** file: apic2apigee.xconfiguration.Map.xsl
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
    |*** Element: map
    |*** Mode: x-configuration
    |********************************
    +-->
    <!-- This template matches the 'map' element of the document -->
    <xsl:template match="map" mode="x-configuration">
        <xsl:param name="aApiProxyName"/>
        <xsl:param name="aBasePath"/>
        <xsl:param name="aCors"/>
        <xsl:param name="aCondition"/>
        <xsl:param name="aType"/>

        <!-- generate a unique identifier for the mapping -->
        <xsl:variable name="_id" select="generate-id()"/>

        <!-- create a unique map element -->
        <map>
            <!-- set the 'id' attribute on the 'map' element -->
            <xsl:attribute name="id" select="$_id"/>
            <!-- set the 'id' attribute on the 'map' element -->
            <xsl:attribute name="condition" select="$aCondition"/>
            <!-- set the '@type' attribute on the 'map' element -->
            <xsl:attribute name="type" select="apigee:setType(.,local-name())"/>

            <!-- get mapping input type (object) -->
            <xsl:variable name="_inputType" select="./inputs/input/schema/type/text()"/>

            <!-- get mapping output type (object) -->
            <xsl:variable name="_outputType" select="./outputs/output/schema/type/text()"/>

            <!-- get mapping actions -->
            <xsl:variable name="_actions" select="./actions"/>

            <!-- check data are ok -->
            <xsl:copy-of select="apigee:setJson2JsonMapping($_inputType,$_outputType,$_actions)"/>

            <!-- Apply templates and push some data at the same time... -->
            <xsl:apply-templates mode="x-configuration">
                <xsl:with-param name="aApiProxyName" select="$aApiProxyName"/>
                <xsl:with-param name="aBasePath" select="$aBasePath"/>
                <xsl:with-param name="aCors" select="$aCors"/>
                <xsl:with-param name="aCondition" select="$aCondition"/>
                <xsl:with-param name="aType" select="$aType"/>
            </xsl:apply-templates>
        </map>
        
    </xsl:template>

<!--+
	|******************************************************
	|*** XSLT Function
	|*** Name: apigee:setJson2JsonMapping
	|******************************************************
	+-->
    <!-- apigee 'setJson2JsonMapping' function used to map json to json -->
    <xsl:function name="apigee:setJson2JsonMapping">
        <xsl:param name="aInputType"/>
        <xsl:param name="aOutputType"/>
        <xsl:param name="aSetOfActions"/>
        
	    <!-- Create a preflight flow to manage CORS -->
        <xsl:sequence>
            <input><xsl:value-of select="$aInputType"/></input>
            <output><xsl:value-of select="$aOutputType"/></output>
            <list>
                <xsl:copy-of select="$aSetOfActions"/>
            </list>
        </xsl:sequence>

    </xsl:function>

</xsl:stylesheet>