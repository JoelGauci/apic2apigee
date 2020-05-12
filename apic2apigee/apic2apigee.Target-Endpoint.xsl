<?xml version="1.0" encoding="utf-8"?>
<!--+	
	|************************************************************	
	|*** Author: Joel Gauci - joelgauci@google.com
	|*** file: apic2apigee.Target-Endpoint.xsl
	|*** Description: Target Endpoint templates of the migration transformation
	|*** Revision : 1.0 : initial version
	|************************************************************
	+-->
<xsl:stylesheet version="3.0" 							
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:apigee="http://migration.apigee.com/"
		extension-element-prefixes="apigee" 							
		exclude-result-prefixes="apigee xs">
    
    <!-- 'import' template that imports all the other templates to create proxy endpoint -->
    <xsl:import href="./templates/target-endpoint/apic2apigee.target-endpoint.Import.xsl"/>

<!--+
    |********************************
    |*** Matching Template
    |*** Element: steps
    |*** Mode: target-endpoint
    |********************************
    +-->
    <!-- This template matches the 'steps' element of the processing document -->
    <xsl:template match="steps" mode="target-endpoint">
        <xsl:param name="aApiProxyName"/>
        <xsl:param name="aBasePath"/>
        <xsl:param name="aSecurityNodeSet"/>

        <!-- Create an Apigee TargetEndpoint element and its childs -->
        <TargetEndpoint name="default">
            <Description/>
            <FaultRules/>
            <PreFlow>
                <Request name="PreFlow">
                    <!-- Set the Target URL based on the information set at the Proxy Endpoint level -->
                    <Step>
                        <Name><xsl:value-of select="$__APIGEE_POLICY_AM_SET_TARGET_URL"/></Name>
                    </Step>
                </Request>
                <Response/>
            </PreFlow>
            <!-- set flows -->
            <Flows/>
            <PostFlow name="PostFlow">
                <Request/>
                <Response/>
            </PostFlow>
            <!-- set HTTP Target Connection - not used as target is defined at the Proxy Endpoint level -->
            <HTTPTargetConnection>
                <xsl:comment>*** this value is not used ***</xsl:comment>
                <xsl:comment>*** Target is defined at the Proxy Endpoint level ***</xsl:comment>
                <URL>http://target</URL>
            </HTTPTargetConnection>
            
        </TargetEndpoint>

    </xsl:template>
	
</xsl:stylesheet>