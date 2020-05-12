<?xml version="1.0" encoding="utf-8"?>
<!--+	
	|************************************************************	
	|*** Author: Joel Gauci - joelgauci@google.com
	|*** file: apic2apigee.Proxy-Endpoint.xsl
	|*** Description: Proxy Endpoint templates of the migration transformation
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
    <xsl:import href="./templates/proxy-endpoint/apic2apigee.proxy-endpoint.Import.xsl"/>

<!--+
    |********************************
    |*** Matching Template
    |*** Element: steps
    |*** Mode: proxy-endpoint
    |********************************
    +-->
    <!-- This template matches the 'steps' element of the processing document -->
    <xsl:template match="steps" mode="proxy-endpoint">
        <xsl:param name="aApiProxyName"/>
        <xsl:param name="aBasePath"/>
        <xsl:param name="aSecurityNodeSet"/>
        <xsl:param name="aPathsNodeSet"/>
        
        <!-- CORS status -->
        <xsl:variable name="_cors" select="$aSecurityNodeSet/security/cors/text()"/>

        <!-- Create an Apigee ProxyEndpoint element and its childs -->
        <ProxyEndpoint name="default">
            <Description/>
            <FaultRules/>
            <PreFlow>
                <Request>
                    <!-- set security policies at the PreFlow level if necessary -->
                    <xsl:apply-templates select="$aSecurityNodeSet/security/*" mode="security-flows">
                        <xsl:with-param name="aCors" select="$_cors"/>
                        <xsl:with-param name="aSecurityNodeSet" select="$aSecurityNodeSet"/>
                    </xsl:apply-templates>
                    <!-- set PreFlow policies for request -->
                    <xsl:apply-templates select="*[(@type = 'request') or (@type = 'no-target')]" mode="proxy-endpoint"/>
                    <!-- set routing policies -->
                    <xsl:apply-templates select="./*[@type = 'route']" mode="proxy-endpoint"/>
                </Request>
                <Response>
                    <!-- set PreFlow policies for response -->
                    <xsl:apply-templates select="*[@type = 'response']" mode="proxy-endpoint"/>
                    <!-- add cors if it is enabled -->
                    <xsl:if test="$_cors = 'true'">
                        <Step>
                            <Name><xsl:value-of select="$__APIGEE_POLICY_AM_CORS_NAME"/></Name>
                        </Step>
                    </xsl:if>
                </Response>
            </PreFlow>
            <PostFlow>
            </PostFlow>
            <!-- set flows -->
            <Flows>
                <xsl:apply-templates select="resource" mode="flows">
                    <xsl:with-param name="aApiProxyName" select="$aApiProxyName"/>
                    <xsl:with-param name="aBasePath" select="$aBasePath"/>
                    <xsl:with-param name="aSecurityNodeSet" select="$aSecurityNodeSet"/>
                </xsl:apply-templates>
                <!-- add paths not concerned by any processing -->
                <xsl:apply-templates select="$aPathsNodeSet" mode="flows"/>
                <!-- add the CORS preflight if CORS is enabled -->
                <xsl:if test="$_cors = 'true'">
                    <xsl:copy-of select="apigee:addCorsPreflightFlow()"/>
                </xsl:if>
                <!-- add 404 Not Found flow -->
                <xsl:copy-of select="apigee:add404NotFoundFlow()"/>
            </Flows>
            <!-- set HTTP connection -->
            <HTTPProxyConnection>
                <Properties/>
                <BasePath><xsl:value-of select="$aBasePath"/></BasePath>
                <VirtualHost><xsl:value-of select="$__APIGEE_VIRTUAL_HOST_SECURE"/></VirtualHost>
            </HTTPProxyConnection>
            <!-- Add noRoute if CORS is enabled -->
            <xsl:if test="$_cors = 'true'">
                <RouteRule name="noRoute">
                    <Condition><xsl:value-of select="$__APIGEE_POLICY_AM_CORS_CONDITION_EQUAL"/></Condition>
                </RouteRule>
            </xsl:if>
            <!-- set routes -->
            <xsl:copy-of select="apigee:addRouteRules(.)"/>
            
        </ProxyEndpoint>

    </xsl:template>
	
</xsl:stylesheet>