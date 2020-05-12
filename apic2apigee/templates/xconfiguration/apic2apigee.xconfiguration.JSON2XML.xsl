<?xml version="1.0" encoding="utf-8"?>
<!--+	
	|************************************************************	
	|*** Author: Joel Gauci - joelgauci@google.com
	|*** file: apic2apigee.xconfiguration.JSON2XML.xsl
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
    |*** Element: json-to-xml
    |*** Mode: x-configuration
    |********************************
    +-->
    <!-- This template matches the 'json-to-xml' element of the document -->
    <xsl:template match="json-to-xml" mode="x-configuration">
        <xsl:param name="aApiProxyName"/>
        <xsl:param name="aBasePath"/>
        <xsl:param name="aCors"/>
        <xsl:param name="aCondition"/>
        <xsl:param name="aType"/>

        <!-- generate a unique identifier for the mapping -->
        <xsl:variable name="_id" select="generate-id()"/>

        <!-- create a unique map element -->
        <json2xml>
            <!-- set the '@id' attribute on the 'script' element -->
            <xsl:attribute name="id" select="$_id"/>
            <!-- set the '@condition' attribute on the 'script' element -->
            <xsl:attribute name="condition" select="$aCondition"/>
            <!-- set the '@type' attribute on the 'script' element -->
           <xsl:attribute name="type" select="apigee:setTypeScript(.)"/>

            <!-- get the script's title and replace <space> with '-' character -->
            <xsl:value-of select="translate(./title/text(),' ','-')"/>
        
            <!-- Apply templates and push some data at the same time... -->
            <xsl:apply-templates mode="x-configuration">
                <xsl:with-param name="aApiProxyName" select="$aApiProxyName"/>
                <xsl:with-param name="aBasePath" select="$aBasePath"/>
                <xsl:with-param name="aCors" select="$aCors"/>
                <xsl:with-param name="aCondition" select="$aCondition"/>
                <xsl:with-param name="aType" select="$aType"/>
            </xsl:apply-templates>
        </json2xml>
        
    </xsl:template>

</xsl:stylesheet>