<?xml version="1.0" encoding="utf-8"?>
<!--+	
	|************************************************************	
	|*** Author: Joel Gauci - joelgauci@google.com
	|*** file: apic2apigee.policies.RF-VerifyAPISecret.xsl
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
	|*** Name: apigee:setRFVerifyAPISecretPolicy
	|******************************************************
	+-->
    <!-- apigee 'setRFVerifyAPISecretPolicy' function used to create Verify API Secret Policy (Raise Fault based) -->
    <xsl:function name="apigee:setRFVerifyAPISecretPolicy">
        <xsl:param name="aPolicyName"/>
    
        <xsl:sequence>

            <!-- RAISE FAULT - VERIFY API SECRET POLICY -->
            <RaiseFault async="false" continueOnError="false" enabled="true" name="{$aPolicyName}">
                <DisplayName><xsl:value-of select="$aPolicyName"/></DisplayName>
                <Properties/>
                <FaultResponse>
                    <Set>
                        <Headers/>
                        <Payload contentType="application/json">{"error":"unauthorized","code":"401"}</Payload>
                        <StatusCode>401</StatusCode>
                        <ReasonPhrase>Unauthorized</ReasonPhrase>
                    </Set>
                </FaultResponse>
                <IgnoreUnresolvedVariables>true</IgnoreUnresolvedVariables>
            </RaiseFault>

        </xsl:sequence>

    </xsl:function>
    
</xsl:stylesheet>