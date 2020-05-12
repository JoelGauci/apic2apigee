<?xml version="1.0" encoding="utf-8"?>
<!--+	
	|************************************************************	
	|*** Author: Joel Gauci - joelgauci@google.com
	|*** file: apic2apigee.Info.xsl
	|*** Description: apiproxy info templates of the migration transformation
	|*** Revision : 1.0 : initial version
	|************************************************************
	+ -->
	
<xsl:stylesheet version="3.0" 							
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:apigee="http://migration.apigee.com/"
		extension-element-prefixes="apigee" 							
		exclude-result-prefixes="apigee">
	
	<!-- Define the output as an indented XML content -->
	<xsl:output method="xml" indent="yes" encoding="UTF-8"/>
	
<!--+
		|********************************
		|*** Matching Template
		|*** Element: ROOT
		|********************************
		+-->
	<!-- This template matches the Root element of the document -->
	<xsl:template match="info"/>

<!--+
		|******************************************************
		|*** XSLT Function
		|*** Name: apigee:getAPIProxyName
		|******************************************************
		+-->
    <!-- apigee 'getAPIProxyName' function used to get API Proxy Name -->
    <xsl:function name="apigee:getAPIProxyName">
		<xsl:param name="aNodeSet"/>

			<xsl:value-of select="$aNodeSet/spec/info/x-ibm-name/text()"/>

	</xsl:function>

<!--+
		|******************************************************
		|*** XSLT Function
		|*** Name: apigee:getAPIProxyDescription
		|******************************************************
		+-->
    <!-- apigee 'getAPIProxyDescription' function used to get API Proxy description -->
    <xsl:function name="apigee:getAPIProxyDescription">
		<xsl:param name="aNodeSet"/>

			<xsl:value-of select="concat($aNodeSet/spec/info/title/text(),$__APIGEE_APIPROXY_DESCRIPTION_VERSION_SEPARATOR,$aNodeSet/spec/info/version/text())"/>

	</xsl:function>

<!--+
		|******************************************************
		|*** XSLT Function
		|*** Name: apigee:getBasePathFromSpec
		|******************************************************
		+-->
    <!-- apigee 'getBasePathFromSpec' function used to get base path infornation from the spec -->
    <xsl:function name="apigee:getBasePathFromSpec">
		<xsl:param name="aNodeSet"/>

			<xsl:value-of select="$aNodeSet/spec/basePath/text()"/>

	</xsl:function>

<!--+
	|******************************************************
	|*** XSLT Function
	|*** Name: apigee:setProxyFileContent
	|******************************************************
	+-->
<!-- apigee 'setProxyFileContent' function used to set content of an api proxy file at the root level of the Apigee API Proxy -->
    <xsl:function name="apigee:setProxyFileContent">
			<xsl:param name="aName"/>
			<xsl:param name="aBasePath"/>
			<xsl:param name="aDescription"/>

				<!-- trace the message and its value -->
        <xsl:sequence>
						<!-- Apigee API Proxy content -->
            <APIProxy>
                <!-- Set the name of the API Proxy -->
                <xsl:attribute name="name">
                    <xsl:value-of select="$aName"/>
                </xsl:attribute>
                <xsl:attribute name="revision">
                    <xsl:value-of select="'1'"/>
                </xsl:attribute>
                <Basepaths><xsl:value-of select="$aBasePath"/></Basepaths>
                <ConfigurationVersion>
									<xsl:attribute name="majorVersion">
                    <xsl:value-of select="$__APIGEE_APIPROXY_CONFIGURATION_MAJOR_VERSION"/>
                	</xsl:attribute>
									<xsl:attribute name="minorVersion">
                    <xsl:value-of select="$__APIGEE_APIPROXY_CONFIGURATION_MINOR_VERSION"/>
                	</xsl:attribute>
								</ConfigurationVersion>
                <CreatedAt/>
                <CreatedBy/>
                <Description/>
                <DisplayName><xsl:value-of select="$aName"/></DisplayName>
                <LastModifiedAt/>
                <LastModifiedBy>defaultUser</LastModifiedBy>
                <ManifestVersion/>
                <Policies/>
                <ProxyEndpoints>
                    <ProxyEndpoint>default</ProxyEndpoint>
                </ProxyEndpoints>
                <Resources/>
                <Spec/>
                <TargetServers/>
                <TargetEndpoints>
                    <TargetEndpoint>default</TargetEndpoint>
                </TargetEndpoints>
                <xsl:comment><xsl:value-of select="concat('Migration Tool Version:',$__XSLT_VERSION,' - description: ',$aDescription)"/></xsl:comment>
            </APIProxy>            
        </xsl:sequence>

	</xsl:function>
	
</xsl:stylesheet>