<?xml version="1.0" encoding="utf-8"?>
<!--+	
	|************************************************************	
	|*** Author: Joel Gauci - joelgauci@google.com
	|*** file: apic2apigee.policies.AM-SetTarget.xsl
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
	|*** Name: apigee:setAMSetTarget
	|******************************************************
	+-->
    <!-- apigee 'setAMSetTarget' function used to set target -->
    <xsl:function name="apigee:setAMSetTarget">
        <xsl:param name="aPolicyName"/>
        <xsl:param name="aForwardTargetUrl"/>
        
        <xsl:sequence>

            <!-- AM No Target POLICY -->
            <AssignMessage async="false" continueOnError="false" enabled="true" name="{$aPolicyName}">
                <DisplayName><xsl:value-of select="$aPolicyName"/></DisplayName>
                <Properties/>
                <AssignVariable>
                    <Name>forward.target.url</Name>
                    <Template><xsl:value-of select="apigee:translateContextVariable(translate(translate(translate($aForwardTargetUrl,'$',''),')','}'),'(','{'))"/></Template>
                </AssignVariable>
                <IgnoreUnresolvedVariables>true</IgnoreUnresolvedVariables>
                <AssignTo createNew="false" transport="http" type="request"/>
            </AssignMessage>

        </xsl:sequence>
    </xsl:function>
    
</xsl:stylesheet>