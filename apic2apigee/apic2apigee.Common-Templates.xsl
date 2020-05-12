<?xml version="1.0" encoding="utf-8"?>
<!--+	
	|************************************************************	
	|*** Author: Joel Gauci - joelgauci@google.com
	|*** file: apic2apigee.Common-Templates.xsl
	|*** Description: common templates of the migration transformation
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
	|*** Element: text and attributes
	|********************************
	+-->
	<!-- This template matches text and attributes of current document -->
	<xsl:template match="text()|@*|comment()">
		<!-- DO NOR RECOPY TEXT VALUES OR ATTRIBUTES OF THE ORIGINAL DOCUMENT -->
	</xsl:template>

<!--+
	|********************************
	|*** Matching Template
	|*** Element: text and attributes
	|*** Mode: paths
	|********************************
	+-->
	<!-- This template matches text and attributes of current document -->
	<xsl:template match="text()|@*|comment()" mode="paths">
		<!-- DO NOR RECOPY TEXT VALUES OR ATTRIBUTES OF THE ORIGINAL DOCUMENT -->
	</xsl:template>

<!--+
	|********************************
	|*** Matching Template
	|*** Element: text and attributes
	|*** Mode: x-configuration
	|********************************
	+-->
	<!-- This template matches text and attributes of current document -->
	<xsl:template match="text()|@*|comment()" mode="x-configuration">
		<!-- DO NOR RECOPY TEXT VALUES OR ATTRIBUTES OF THE ORIGINAL DOCUMENT -->
	</xsl:template>

<!--+
	|********************************
	|*** Matching Template
	|*** Element: text and attributes
	|*** Mode: security
	|********************************
	+-->
	<!-- This template matches text and attributes of current document -->
	<xsl:template match="text()|@*|comment()" mode="security">
		<!-- DO NOR RECOPY TEXT VALUES OR ATTRIBUTES OF THE ORIGINAL DOCUMENT -->
	</xsl:template>

<!--+
	|********************************
	|*** Matching Template
	|*** Element: text and attributes
	|*** Mode: security-inside
	|********************************
	+-->
	<!-- This template matches text and attributes of current document -->
	<xsl:template match="text()|@*|comment()" mode="security-inside">
		<!-- DO NOR RECOPY TEXT VALUES OR ATTRIBUTES OF THE ORIGINAL DOCUMENT -->
	</xsl:template>

<!--+
	|********************************
	|*** Matching Template
	|*** Element: text and attributes
	|*** Mode: processing-inside
	|********************************
	+-->
	<!-- This template matches text and attributes of current document -->
	<xsl:template match="text()|@*|comment()" mode="processing-inside">
		<!-- DO NOR RECOPY TEXT VALUES OR ATTRIBUTES OF THE ORIGINAL DOCUMENT -->
	</xsl:template>

<!--+
	|********************************
	|*** Matching Template
	|*** Element: text and attributes
	|*** Mode: security-flows
	|********************************
	+-->
	<!-- This template matches text and attributes of current document -->
	<xsl:template match="text()|@*|comment()" mode="security-flows">
		<!-- DO NOR RECOPY TEXT VALUES OR ATTRIBUTES OF THE ORIGINAL DOCUMENT -->
	</xsl:template>

<!--+
	|********************************
	|*** Matching Template
	|*** Element: text and attributes
	|*** Mode: proxy-endpoint
	|********************************
	+-->
	<!-- This template matches text and attributes of current document -->
	<xsl:template match="text()|@*|comment()" mode="proxy-endpoint">
		<!-- DO NOR RECOPY TEXT VALUES OR ATTRIBUTES OF THE ORIGINAL DOCUMENT -->
	</xsl:template>

<!--+
	|********************************
	|*** Matching Template
	|*** Element: text and attributes
	|*** Mode: flows
	|********************************
	+-->
	<!-- This template matches text and attributes of current document -->
	<xsl:template match="text()|@*|comment()" mode="flows">
		<!-- DO NOR RECOPY TEXT VALUES OR ATTRIBUTES OF THE ORIGINAL DOCUMENT -->
	</xsl:template>

<!--+
	|********************************
	|*** Matching Template
	|*** Element: text and attributes
	|*** Mode: routes
	|********************************
	+-->
	<!-- This template matches text and attributes of current document -->
	<xsl:template match="text()|@*|comment()" mode="routes">
		<!-- DO NOR RECOPY TEXT VALUES OR ATTRIBUTES OF THE ORIGINAL DOCUMENT -->
	</xsl:template>

<!--+
	|********************************
	|*** Matching Template
	|*** Element: text and attributes
	|*** Mode: target-endpoint
	|********************************
	+-->
	<!-- This template matches text and attributes of current document -->
	<xsl:template match="text()|@*|comment()" mode="target-endpoint">
		<!-- DO NOR RECOPY TEXT VALUES OR ATTRIBUTES OF THE ORIGINAL DOCUMENT -->
	</xsl:template>

<!--+
	|********************************
	|*** Matching Template
	|*** Element: swagger
	|********************************
	+-->
	<!-- This template matches the swagger element of the document -->
	<xsl:template match="swagger"/>
				
<!--+
	|********************************
	|*** Named Template
	|*** Name: ntCreateFile
	|********************************
	+-->
	<!-- This named template is used to create a file with a specific name and content -->
	<xsl:template name="ntCreateFile">
		<xsl:param name="aFileName"/>
		<xsl:param name="aContent"/>

			<!-- Create a file with a specific name and content, respectively 'aFileName' and 'aContent' -->
			<xsl:result-document href="{$aFileName}"><xsl:copy-of select="$aContent"/></xsl:result-document>
		
	</xsl:template>

<!--+
	|********************************
	|*** Named Template
	|*** Name: ntCreateJSCFile
	|********************************
	+-->
	<!-- This named template is used to create a JavaScript resource file with a specific name and (text) content -->
	<xsl:template name="ntCreateJSCFile">
		<xsl:param name="aFileName"/>
		<xsl:param name="aContent"/>

			<!-- Create a file with a specific name and content, respectively 'aFileName' and 'aContent' -->
			<xsl:result-document href="{$aFileName}" method="text" omit-xml-declaration="yes"><xsl:value-of select="$aContent" disable-output-escaping="yes"/></xsl:result-document>
		
	</xsl:template>

<!--+
	|******************************************************
	|*** XSLT Function
	|*** Name: apigee:setLogs
	|******************************************************
	+-->
	<!-- apigee 'setLogs' function used to set logs and traces of the migration -->
    <xsl:function name="apigee:setLogs">
		<xsl:param name="aProxyName"/>
		<xsl:param name="aProxyDescription"/>
		<xsl:param name="aBasePath"/>
		<xsl:param name="aSecurityNodeSet"/>
		<xsl:param name="aProcessingNodeSet"/>
		<xsl:param name="aPathsNodeSet"/>

		<!-- trace the message and its value -->
        <xsl:sequence>
			<configuration>
				<!-- migration tool version -->
				<xsl:comment>
					<xsl:value-of select="concat('Migration Tool Version:',$__XSLT_VERSION)"/>
				</xsl:comment>
				<!-- aboout the API Proxy... -->
				<apiProxy>
					<name><xsl:value-of select="$aProxyName"/></name>
					<description><xsl:value-of select="$aProxyDescription"/></description>
					<basePath><xsl:value-of select="$aBasePath"/></basePath>
				</apiProxy>
				<!-- security logs -->
				<xsl:copy-of select="$aSecurityNodeSet"/>
				<!-- processing logs -->
				<xsl:copy-of select="$aProcessingNodeSet"/>
				<!-- paths logs -->
				<xsl:copy-of select="$aPathsNodeSet"/>
			</configuration>           
        </xsl:sequence>

	</xsl:function>

<!--+
	|******************************************************
	|*** XSLT Function
	|*** Name: apigee:translateContextVariable
	|******************************************************
	+-->
    <!-- apigee 'translateContextVariable' function used to translate apic to apigee context variables -->
    <!-- apigee docs: https://docs.apigee.com/api-platform/reference/variables-reference -->
    <xsl:function name="apigee:translateContextVariable">
        <xsl:param name="aApicContextVariable"/>
        
	    <!-- translate a string containing apic context variable -->
        <xsl:sequence>
            <xsl:choose>
                <!-- *** APIC *** <=> *** APIGEE *** -->
                <!-- api.operation.path <=> proxy.pathsuffix -->
                <xsl:when test="contains($aApicContextVariable,'api.operation.path')">
                    <xsl:value-of select="apigee:translateContextVariable(replace($aApicContextVariable,'api.operation.path','proxy.pathsuffix'))"/>
                </xsl:when>
                <!-- request.headers.xxx <=> request.header.xxx -->
                <xsl:when test="contains($aApicContextVariable,'request.headers.')">
                    <xsl:value-of select="apigee:translateContextVariable(replace($aApicContextVariable,'request.headers.','request.header.'))"/>
                </xsl:when>
				<!-- message.headers.xxx <=> request.header.xxx -->
                <xsl:when test="contains($aApicContextVariable,'message.headers.')">
                    <xsl:value-of select="apigee:translateContextVariable(replace($aApicContextVariable,'message.headers.','request.header.'))"/>
                </xsl:when>
                <!-- SAME VARIABLES -->
                <!-- request.path -->
                <xsl:otherwise><xsl:value-of select="$aApicContextVariable"/></xsl:otherwise>
            </xsl:choose>
        </xsl:sequence>

    </xsl:function>

<!--+
	|******************************************************
	|*** XSLT Function
	|*** Name: apigee:addCorsPreflightFlow
	|******************************************************
	+-->
    <!-- apigee 'addCorsPreflightFlow' function used to add CORS preflight as a ProxyEndpoint Conditional Flow -->
    <xsl:function name="apigee:addCorsPreflightFlow">
        
	    <!-- Create a preflight flow to manage CORS -->
        <xsl:sequence>
            <Flow name="CORS preflight">
                <Description>CORS preflight</Description>
                <Request/>
                <Response>
                    <Step>
                        <Name><xsl:value-of select="$__APIGEE_POLICY_AM_CORS_NAME"/></Name>
                    </Step>
                </Response>
                <Condition>request.verb = "OPTIONS"</Condition>
            </Flow>
        </xsl:sequence>

    </xsl:function>

<!--+
	|******************************************************
	|*** XSLT Function
	|*** Name: apigee:add404NotFoundFlow
	|******************************************************
	+-->
    <!-- apigee 'add404NotFoundFlow' function used to add 404 - NotFound Flow -->
    <xsl:function name="apigee:add404NotFoundFlow">
        
	    <!-- Create a preflight flow to manage CORS -->
        <xsl:sequence>
			<Flow name="404 - Not Found">
				<Request>
					<Step>
						<Name><xsl:value-of select="$__APIGEE_POLICY_RF_404_NOTFOUND_NAME"/></Name>
					</Step>
				</Request>
				<Response/>
			</Flow>
        </xsl:sequence>

    </xsl:function>

<!--+
	|******************************************************
	|*** XSLT Function
	|*** Name: apigee:addRouteRules
	|******************************************************
	+-->
    <!-- apigee 'addRouteRules' function used to add route rules -->
    <xsl:function name="apigee:addRouteRules">
		<xsl:param name="aProcessingNodeSet"/>
        
	    <!-- Create a preflight flow to manage CORS -->
        <xsl:sequence>
			<xsl:choose>
                <!-- if nor proxy neither invoke actions, then it means there is no target... -->
                <xsl:when test="( count($aProcessingNodeSet//proxy) = 0 ) and ( count($aProcessingNodeSet//invoke) = 0 )">
                    <RouteRule name="noTarget"/>
                </xsl:when>
				<xsl:when test="count($aProcessingNodeSet//*[@type = 'no-target']) &gt; 0">
                    <RouteRule name="noTarget">
						<Condition><xsl:value-of select="$__APIGEE_CONDITION_NO_TARGET"/></Condition>
					</RouteRule>
					<RouteRule name="default">
                        <TargetEndpoint>default</TargetEndpoint>
                    </RouteRule>
                </xsl:when>
                <!-- otherwise there is at least one target -->
                <xsl:otherwise>
                    <RouteRule name="default">
                        <TargetEndpoint>default</TargetEndpoint>
                    </RouteRule>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:sequence>

    </xsl:function>
				
</xsl:stylesheet>