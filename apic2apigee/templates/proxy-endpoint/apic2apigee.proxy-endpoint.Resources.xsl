<?xml version="1.0" encoding="utf-8"?>
<!--+	
	|************************************************************	
	|*** Author: Joel Gauci - joelgauci@google.com
	|*** file: apic2apigee.proxy-endpoint.Resources.xsl
	|*** Description: resources templates of the migration transformation
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
    |*** Element: resource
    |*** Mode: flows
    |********************************
    +-->
    <!-- This template matches the 'resource' element of the processing document -->
    <xsl:template match="resource" mode="flows">
        <Flow>
            <xsl:attribute name="name">
                <xsl:value-of select="concat(upper-case(@verb),' ',@path)"/>
            </xsl:attribute>
            <Description><xsl:value-of select="@id"/></Description>
            <Request>
                <xsl:apply-templates select="./*[@type = 'request' or @type = 'no-target']" mode="proxy-endpoint"/>
                <xsl:apply-templates select="./*[@type = 'route']" mode="proxy-endpoint"/>
            </Request>
            <Response>
                <xsl:apply-templates select="./*[@type = 'response']" mode="proxy-endpoint"/>
            </Response>
            <Condition><xsl:value-of select="concat($__APIGEE_CONDITION_PREFIX_MATCHESPATH,@path,$__APIGEE_CONDITION_SUFFIX,$__APIGEE_CONDITION_PREFIX_METHOD,upper-case(@verb),$__APIGEE_CONDITION_SUFFIX)"/></Condition>
        </Flow>
    </xsl:template>

<!--+
    |**********************************************************
    |*** Matching Template
    |*** Element: map[@type = 'request' or @type = 'response']
    |*** Mode: proxy-endpoint
    |**********************************************************
    +-->
    <!-- This template matches the 'map' element of the processing document -->
    <xsl:template match="map[@type = 'request' or @type = 'response']" mode="proxy-endpoint">

        <!-- JSON 2 JSON mapping consists in Extract Variable + Assign Message Variable policies -->
        <Step>
            <Name><xsl:value-of select="concat($__APIGEE_POLICY_EV_MAPPING_NAME,@id)"/></Name>
            <xsl:if test="@condition != 'none'">
                <Condition><xsl:value-of select="@condition"/></Condition>
            </xsl:if>
        </Step>
        <Step>
            <Name><xsl:value-of select="concat($__APIGEE_POLICY_AM_MAPPING_NAME,@id)"/></Name>
            <xsl:if test="@condition != 'none'">
                <Condition><xsl:value-of select="@condition"/></Condition>
            </xsl:if>
        </Step>

    </xsl:template>

<!--+
    |**********************************************************
    |*** Matching Template
    |*** Element: map[@type = 'request' or @type = 'response']
    |*** Mode: processing-inside
    |**********************************************************
    +-->
    <!-- This template matches the 'map' element of the processing document -->
    <!-- Create policies -->
    <xsl:template match="map[@type = 'request' or @type = 'response']" mode="processing-inside">

        <!-- Create the JSON 2 JSON mapping policies -->
        <!-- Extract Variable -->
		<xsl:call-template name="ntCreateFile">
			<xsl:with-param name="aFileName" select="concat($__APIGEE_PATH_APIPROXY_POLICIES,$__APIGEE_POLICY_EV_MAPPING_NAME,@id,'.xml')"/>
			<xsl:with-param name="aContent" select="apigee:setEvMappingPolicy( concat($__APIGEE_POLICY_EV_MAPPING_NAME,@id) )"/>
		</xsl:call-template>
        <!-- Assign Variable -->
		<xsl:call-template name="ntCreateFile">
			<xsl:with-param name="aFileName" select="concat($__APIGEE_PATH_APIPROXY_POLICIES,$__APIGEE_POLICY_AM_MAPPING_NAME,@id,'.xml')"/>
			<xsl:with-param name="aContent" select="apigee:setAmMappingPolicy( concat($__APIGEE_POLICY_AM_MAPPING_NAME,@id) )"/>
		</xsl:call-template>

    </xsl:template>


<!--+
    |***********************************************************************************
    |*** Matching Template
    |*** Element: script[@type = 'request' or @type = 'response' or @type = 'no-target']
    |*** Mode: proxy-endpoint
    |***********************************************************************************
    +-->
    <!-- This template matches the 'script' element of the processing document -->
    <xsl:template match="script[(@type = 'request') or (@type = 'response') or (@type = 'no-target')]" mode="proxy-endpoint">

        <!-- JavaScript -->
        <Step>
            <Name><xsl:value-of select="concat($__APIGEE_POLICY_JAVASCRIPT_NAME,@id)"/></Name>
            <xsl:if test="@condition != 'none'">
                <Condition><xsl:value-of select="@condition"/></Condition>
            </xsl:if>
        </Step>
        <!-- if type is 'no-target' -->
        <xsl:if test="@type = 'no-target'">
            <!-- Assign Message - set 'flow.no-target' to 'true' -->
            <Step>
                <Name><xsl:value-of select="$__APIGEE_POLICY_AM_NO_TARGET"/></Name>
                <xsl:if test="@condition != 'none'">
                    <Condition><xsl:value-of select="@condition"/></Condition>
                </xsl:if>
            </Step>
        </xsl:if>

    </xsl:template>

<!--+
    |***********************************************************************************
    |*** Matching Template
    |*** Element: script[@type = 'request' or @type = 'response' or @type = 'no-target']
    |*** Mode: processing-inside
    |***********************************************************************************
    +-->
    <!-- This template matches the 'script' element of the processing document -->
    <!-- Create policies -->
    <xsl:template match="script[(@type = 'request') or (@type = 'response') or (@type = 'no-target')]" mode="processing-inside">

        <!-- JavaScript Policy -->
		<xsl:call-template name="ntCreateFile">
			<xsl:with-param name="aFileName" select="concat($__APIGEE_PATH_APIPROXY_POLICIES,$__APIGEE_POLICY_JAVASCRIPT_NAME,@id,'.xml')"/>
			<xsl:with-param name="aContent" select="apigee:setJavaScriptPolicy( concat($__APIGEE_POLICY_JAVASCRIPT_NAME,@id) )"/>
		</xsl:call-template>

        <!-- JavaScript Resource -->
		<xsl:call-template name="ntCreateJSCFile">
			<xsl:with-param name="aFileName" select="concat($__APIGEE_PATH_APIPROXY_RESOURCES_JSC,$__APIGEE_POLICY_JAVASCRIPT_NAME,@id,'.js')"/>
			<xsl:with-param name="aContent" select="./script-content/text()"/>
		</xsl:call-template>

    </xsl:template>

<!--+
    |***********************************
    |*** Matching Template
    |*** Element: *[@type = 'route']
    |*** Mode: proxy-endpoint
    |***********************************
    +-->
    <!-- This template matches the 'invoke' and 'proxy' elements with @type = 'route' - of the processing document -->
    <xsl:template match="*[@type = 'route']" mode="proxy-endpoint">

        <!-- JavaScript -->
        <Step>
            <Name><xsl:value-of select="concat($__APIGEE_POLICY_AM_SET_TARGET,@id)"/></Name>
            <xsl:if test="@condition != 'none'">
                <Condition><xsl:value-of select="@condition"/></Condition>
            </xsl:if>
        </Step>

    </xsl:template>

<!--+
    |***********************************
    |*** Matching Template
    |*** Element: *[@type = 'route']
    |*** Mode: processing-inside
    |***********************************
    +-->
    <!-- This template matches the 'invoke' and 'proxy' elements with @type = 'route' - of the processing document -->
    <!-- Create policies -->
    <xsl:template match="*[@type = 'route']" mode="processing-inside">

        <!-- JavaScript Policy -->
		<xsl:call-template name="ntCreateFile">
			<xsl:with-param name="aFileName" select="concat($__APIGEE_PATH_APIPROXY_POLICIES,$__APIGEE_POLICY_AM_SET_TARGET,@id,'.xml')"/>
			<xsl:with-param name="aContent" select="apigee:setAMSetTarget( concat($__APIGEE_POLICY_AM_SET_TARGET,@id), ./target-url/text() )"/>
		</xsl:call-template>

    </xsl:template>

<!--+
    |**********************************************************
    |*** Matching Template
    |*** Element: xml2json[@type = 'request' or @type = 'response']
    |*** Mode: proxy-endpoint
    |**********************************************************
    +-->
    <!-- This template matches the 'xml2json' element of the processing document -->
    <xsl:template match="xml2json[@type = 'request' or @type = 'response']" mode="proxy-endpoint">

        <!-- JSON 2 JSON mapping consists in Extract Variable + Assign Message Variable policies -->
        <Step>
            <Name><xsl:value-of select="concat($__APIGEE_POLICY_XML2JSON_NAME,@id)"/></Name>
            <xsl:if test="@condition != 'none'">
                <Condition><xsl:value-of select="@condition"/></Condition>
            </xsl:if>
        </Step>

    </xsl:template>

<!--+
    |**********************************************************
    |*** Matching Template
    |*** Element: xml2json[@type = 'request' or @type = 'response']
    |*** Mode: processing-inside
    |**********************************************************
    +-->
    <!-- This template matches the 'xml2json' element of the processing document -->
    <xsl:template match="xml2json[@type = 'request' or @type = 'response']" mode="processing-inside">

        <!-- XML2JSON Policy -->
		<xsl:call-template name="ntCreateFile">
			<xsl:with-param name="aFileName" select="concat($__APIGEE_PATH_APIPROXY_POLICIES,$__APIGEE_POLICY_XML2JSON_NAME,@id,'.xml')"/>
			<xsl:with-param name="aContent" select="apigee:setX2JTransformation( concat($__APIGEE_POLICY_XML2JSON_NAME,@id), @type )"/>
		</xsl:call-template>

    </xsl:template>

<!--+
    |**********************************************************
    |*** Matching Template
    |*** Element: json2xml[@type = 'request' or @type = 'response']
    |*** Mode: proxy-endpoint
    |**********************************************************
    +-->
    <!-- This template matches the 'json2xml' element of the processing document -->
    <xsl:template match="json2xml[@type = 'request' or @type = 'response']" mode="proxy-endpoint">

        <!-- JSON 2 JSON mapping consists in Extract Variable + Assign Message Variable policies -->
        <Step>
            <Name><xsl:value-of select="concat($__APIGEE_POLICY_JSON2XML_NAME,@id)"/></Name>
            <xsl:if test="@condition != 'none'">
                <Condition><xsl:value-of select="@condition"/></Condition>
            </xsl:if>
        </Step>

    </xsl:template>

<!--+
    |**********************************************************
    |*** Matching Template
    |*** Element: json2xml[@type = 'request' or @type = 'response']
    |*** Mode: processing-inside
    |**********************************************************
    +-->
    <!-- This template matches the 'json2xml' element of the processing document -->
    <xsl:template match="json2xml[@type = 'request' or @type = 'response']" mode="processing-inside">

        <!-- JSON2XML Policy -->
		<xsl:call-template name="ntCreateFile">
			<xsl:with-param name="aFileName" select="concat($__APIGEE_PATH_APIPROXY_POLICIES,$__APIGEE_POLICY_JSON2XML_NAME,@id,'.xml')"/>
			<xsl:with-param name="aContent" select="apigee:setJ2XTransformation( concat($__APIGEE_POLICY_JSON2XML_NAME,@id), @type )"/>
		</xsl:call-template>

    </xsl:template>

	
</xsl:stylesheet>