<?xml version="1.0" encoding="utf-8"?>
<!--+	
	|************************************************************	
	|*** Author: Joel Gauci - joelgauci@google.com
	|*** file: apic2apigee.policies.AM-NoTargetCopyPathSuffix.xsl
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
	|*** Name: apigee:setNoTargetCopyPathSuffix
	|******************************************************
	+-->
    <!-- apigee 'setNoTargetCopyPathSuffix' function used to create an AM Policy -->
    <xsl:function name="apigee:setNoTargetCopyPathSuffix">
        <xsl:param name="aPolicyName"/>
        
        <xsl:sequence>

            <!-- AM POLICY -->
            <AssignMessage async="false" continueOnError="false" enabled="true" name="{$aPolicyName}">
                <DisplayName><xsl:value-of select="$aPolicyName"/></DisplayName>
                <AssignVariable>
                    <Name>target.copy.pathsuffix</Name>
                    <Value>false</Value>
                </AssignVariable>
                <IgnoreUnresolvedVariables>true</IgnoreUnresolvedVariables>
            </AssignMessage>

        </xsl:sequence>
    </xsl:function>
    
</xsl:stylesheet>