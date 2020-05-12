<?xml version="1.0" encoding="utf-8"?>
<!--+	
	|************************************************************	
	|*** Author: Joel Gauci - joelgauci@google.com
	|*** file: apic2apigee.policies.RF-404-NotFound.xsl
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
	|*** Name: apigee:setRF404NotFoundPolicy
	|******************************************************
	+-->
    <!-- apigee 'setRF404NotFoundPolicy' function used to create a 404 not found RF policy -->
    <xsl:function name="apigee:setRF404NotFoundPolicy">
        <xsl:param name="aPolicyName"/>
        
        <xsl:sequence>
            <!-- RAISE FAULT - 404 NOT FOUND POLICY -->
            <RaiseFault async="false" continueOnError="false" enabled="true" name="{$aPolicyName}">
                <DisplayName><xsl:value-of select="$aPolicyName"/></DisplayName>
                <FaultResponse>
                    <Set>
                        <Headers/>
                        <Payload contentType="application/json">{"message":"Invalid request: {request.verb} {proxy.basepath}{proxy.pathsuffix}"}</Payload>
                        <StatusCode>404</StatusCode>
                        <ReasonPhrase>Not Found</ReasonPhrase>
                    </Set>
                </FaultResponse>
                <IgnoreUnresolvedVariables>true</IgnoreUnresolvedVariables>
            </RaiseFault>
        </xsl:sequence>

    </xsl:function>
    
</xsl:stylesheet>