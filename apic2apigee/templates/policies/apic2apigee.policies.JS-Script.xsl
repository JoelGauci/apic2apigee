<?xml version="1.0" encoding="utf-8"?>
<!--+	
	|************************************************************	
	|*** Author: Joel Gauci - joelgauci@google.com
	|*** file: apic2apigee.policies.JS-Script.xsl
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
	|*** Name: apigee:setJavaScriptPolicy
	|******************************************************
	+-->
    <!-- apigee 'setVAKPolicy' function used to create VAK Policy (Verify API Key) -->
    <xsl:function name="apigee:setJavaScriptPolicy">
        <xsl:param name="aPolicyName"/>

	    <!-- set the policy configuration -->
        <xsl:sequence>
            <Javascript async="false" continueOnError="false" enabled="true" timeLimit="200" name="{$aPolicyName}">
                <DisplayName><xsl:value-of select="$aPolicyName"/></DisplayName>
                <Properties/>
                <ResourceURL><xsl:value-of select="concat('jsc://',$aPolicyName,'.js')"/></ResourceURL>
            </Javascript>
        </xsl:sequence>

    </xsl:function>
    
</xsl:stylesheet>