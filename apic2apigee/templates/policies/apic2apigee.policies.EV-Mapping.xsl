<?xml version="1.0" encoding="utf-8"?>
<!--+	
	|************************************************************	
	|*** Author: Joel Gauci - joelgauci@google.com
	|*** file: apic2apigee.policies.EV-Mapping.xsl
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
	|*** Name: apigee:setEvMappingPolicy
	|******************************************************
	+-->
    <!-- apigee 'setEvMappingPolicy' function used to create a EV Policy for mapping -->
    <xsl:function name="apigee:setEvMappingPolicy">
        <xsl:param name="aPolicyName"/>
        
        <xsl:sequence>
            <!-- EV Mapping POLICY -->
            <ExtractVariables async="false" continueOnError="false" enabled="true" name="{$aPolicyName}">
                <DisplayName><xsl:value-of select="$aPolicyName"/></DisplayName>
                <Properties/>
                <IgnoreUnresolvedVariables>true</IgnoreUnresolvedVariables>
                <JSONPayload>
                    <Variable name="name">
                        <JSONPath>{example}</JSONPath>
                    </Variable>
                </JSONPayload>
                <Source clearPayload="false">request</Source>
                <VariablePrefix>apigee</VariablePrefix>
            </ExtractVariables>
        </xsl:sequence>
    </xsl:function>
    
</xsl:stylesheet>