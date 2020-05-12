<?xml version="1.0" encoding="utf-8"?>
<!--+	
	|************************************************************	
	|*** Author: Joel Gauci - joelgauci@google.com
	|*** file: apic2apigee.policies.X2J-Transformation.xsl
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
	|*** Name: apigee:setX2JTransformation
	|******************************************************
	+-->
    <!-- apigee 'setX2JTransformation' function used to transform XML into JSON -->
    <xsl:function name="apigee:setX2JTransformation">
        <xsl:param name="aPolicyName"/>
        <xsl:param name="aType"/>
        
        <xsl:sequence>
            <!-- XML 2 JSON POLICY -->
            <XMLToJSON async="false" continueOnError="false" enabled="true" name="{$aPolicyName}">
                <DisplayName><xsl:value-of select="$aPolicyName"/></DisplayName>
                <Properties/>
                <!-- 'yahoo' is the default format -->
                <Format>yahoo</Format>
                <OutputVariable><xsl:value-of select="$aType"/></OutputVariable>
                <Source><xsl:value-of select="$aType"/></Source>
            </XMLToJSON>
        </xsl:sequence>
    </xsl:function>
    
</xsl:stylesheet>