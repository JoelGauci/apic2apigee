<?xml version="1.0" encoding="utf-8"?>
<!--+	
	|************************************************************	
	|*** Author: Joel Gauci - joelgauci@google.com
	|*** file: apic2apigee.Main.xsl
	|*** Description: XSL Stylesheet, which implements the main processing for apic 2 apigee migration.
	|*** Revision : 1.0 : initial version
	|************************************************************
	+-->
<xsl:stylesheet version="3.0" 							
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:apigee="http://migration.apigee.com/"
		extension-element-prefixes="apigee" 							
		exclude-result-prefixes="apigee">
	
	<!-- Import some common XSL Stylesheets -->
	<xsl:import href="apic2apigee.Import.xsl"/>
	
	<!-- Define the output as an indented XML content -->
	<xsl:output method="xml" indent="yes" encoding="UTF-8"/>
	
<!--+
	|********************************
	|*** Matching Template
	|*** Element: ROOT
	|********************************
	+-->
	<!-- This template matches the Root element of the document -->
	<xsl:template match="/">
		
		<!-- Get Info required to set basic API Proxy data -->
		<xsl:variable name="_apiProxyName" select="apigee:getAPIProxyName(.)"/>
		<xsl:variable name="_apiProxyDescription" select="apigee:getAPIProxyDescription(.)"/>

		<!-- Get base path from the spec -->
		<xsl:variable name="_basePath" select="apigee:getBasePathFromSpec(.)"/>

		<!-- Create the API Proxy File at the root of the archive - name of the file is the name of the proxy -->
		<xsl:call-template name="ntCreateFile">
			<xsl:with-param name="aFileName" select="concat($__APIGEE_PATH_APIPROXY_ROOT,$_apiProxyName,'.xml')"/>
			<xsl:with-param name="aContent" select="apigee:setProxyFileContent($_apiProxyName,$_basePath,$_apiProxyDescription)"/>
		</xsl:call-template>
		
		<!-- Debug Traces 
		<xsl:value-of select="apigee:debug('api proxy name',$_apiProxyName)"/>
		<xsl:value-of select="apigee:debug('api proxy description',$_apiProxyDescription)"/>
		<xsl:value-of select="apigee:debug('api proxy basePath',$_basePath)"/>
		-->

		<!--+***************************
			*** - APPLY TEMPLATES - **** 
			***************************+-->

		<!-- *** 0. READ API PROPERTIES SPECIFIC TO APIC *** -->

		<!-- *** 1. READ SECURITY DEFINITIONS *** -->
		<!--+
			|
			| Variable : $_security
			|
			+-->
		<!--
		<security>
			<cors apiKey="X-IBM-Client-Id" apiSecret="X-IBM-Client-Secret">true</cors>
			<profiles>
				<profile type="apikey" name="clientIdHeader" scope="all">
					<type>apiKey</type>
					<in>header</in>
					<name>X-IBM-Client-Id</name>
				</profile>
				<profile type="apisecret" name="clientSecretHeader" scope="resources">
					<type>apiKey</type>
					<in>header</in>
					<name>X-IBM-Client-Secret</name>
				</profile>
			</profiles>
		</security> 
		-->
		<xsl:variable name="_security">
			<xsl:apply-templates mode="security">
				<xsl:with-param name="isCorsEnabled" select="apigee:isCorsEnabled(.)"/>
			</xsl:apply-templates>
		</xsl:variable>
		<!-- xsl:copy-of select="$_security"/ -->

		<!-- *** 2. READ THE X-CONFIGURATION TO KNOW WHAT POLICIES MUST BE CREATED *** -->
		<!--+
			|
			| Variable : $_processing
			|
			+-->
		<!--
		<steps>
			<proxy>
				<timeout>60</timeout>
				<verb>keep</verb>
				<target-url>$(backend_url)$(request.path)$(api.operation.path)</target-url>
			</proxy>
		</steps> 
		-->
		<xsl:variable name="_processing">
			<xsl:apply-templates mode="x-configuration">
				<xsl:with-param name="aApiProxyName" select="$_apiProxyName"/>
				<xsl:with-param name="aBasePath" select="$_basePath"/>
			</xsl:apply-templates>
		</xsl:variable>
		<!-- xsl:copy-of select="$_processing"/ -->

		<!-- *** 2.bis READ THE PATHS TO KNOW WHAT RESOURCES MUST BE CREATED *** -->
		<!--+
			|
			| Variable : $_paths
			|
			+-->
		<!--
		<paths>
			<path>
				<verb>get</verb>
				<resource>/orders/{id}</resource>
				<condition>(proxy.pathsuffix MatchesPath "/orders/*") and (request.verb = "GET")</condition>
			</path>
		</path> 
		-->
		<xsl:variable name="_paths">
			<xsl:apply-templates mode="paths">
				<xsl:with-param name="aProcessingNodeSet" select="$_processing"/>
			</xsl:apply-templates>
		</xsl:variable>
		<!-- xsl:copy-of select="$_paths"/ -->

		<!-- *** 3. PROCESS RESULT... *** -->
		<!-- * 3.1 - Security Policies * -->
		<xsl:apply-templates select="$_security/security/*" mode="security-inside"/>
		<xsl:apply-templates select="$_processing/steps" mode="processing-inside"/>

		<!-- * 3.2 - Other types of policies... *-->
		
		<!-- *** 4. READ THE PROCESSING NODE SETS AND CREATE THE CONFIGURATION *** -->
		<!-- * 4.1 - ProxyEndpoint configuration * -->
		<xsl:variable name="_proxyEndpoint">
			<xsl:apply-templates select="$_processing" mode="proxy-endpoint">
				<xsl:with-param name="aApiProxyName" select="$_apiProxyName"/>
				<xsl:with-param name="aBasePath" select="$_basePath"/>
				<xsl:with-param name="aSecurityNodeSet" select="$_security"/>
				<xsl:with-param name="aPathsNodeSet" select="$_paths"/>
			</xsl:apply-templates>
		</xsl:variable>
		<!-- Create the target endpoint file of the API Proxy -->
		<xsl:call-template name="ntCreateFile">
			<xsl:with-param name="aFileName" select="concat($__APIGEE_PATH_APIPROXY_PROXYENDPOINT,'default.xml')"/>
			<xsl:with-param name="aContent" select="$_proxyEndpoint"/>
		</xsl:call-template>
		<!-- Create AM No Target policy if there is at least one 'no-target' element -->
		<xsl:if test="count($_processing//*[@type = 'no-target']) &gt; 0">
			<!-- ### create the AM policy file -->
			<xsl:call-template name="ntCreateFile">
				<xsl:with-param name="aFileName" select="concat($__APIGEE_PATH_APIPROXY_POLICIES,$__APIGEE_POLICY_AM_NO_TARGET,'.xml')"/>
				<xsl:with-param name="aContent" select="apigee:setAMNoTargetPolicy($__APIGEE_POLICY_AM_NO_TARGET)"/>
			</xsl:call-template>
		</xsl:if>
		<!-- ### Create RF 404 Not Found policy -->
		<xsl:call-template name="ntCreateFile">
			<xsl:with-param name="aFileName" select="concat($__APIGEE_PATH_APIPROXY_POLICIES,$__APIGEE_POLICY_RF_404_NOTFOUND_NAME,'.xml')"/>
			<xsl:with-param name="aContent" select="apigee:setRF404NotFoundPolicy($__APIGEE_POLICY_RF_404_NOTFOUND_NAME)"/>
		</xsl:call-template> 
		
		<!-- * 4.2 - TargetEndpoint configuration * -->
		<xsl:variable name="_targetEndpoint">
			<xsl:apply-templates select="$_processing" mode="target-endpoint">
				<xsl:with-param name="aApiProxyName" select="$_apiProxyName"/>
				<xsl:with-param name="aBasePath" select="$_basePath"/>
				<xsl:with-param name="aSecurityNodeSet" select="$_security"/>
			</xsl:apply-templates>
		</xsl:variable>
		<!-- Create the target endpoint file of the API Proxy, only if there is a least 1 target -->
        <xsl:if test="count($_targetEndpoint/TargetEndpoint/*) &gt; 0">
            <xsl:call-template name="ntCreateFile">
                <xsl:with-param name="aFileName" select="concat($__APIGEE_PATH_APIPROXY_TARGETENDPOINT,'default.xml')"/>
                <xsl:with-param name="aContent" select="$_targetEndpoint"/>
            </xsl:call-template>
			<!-- ### create the AM Set Target URL policy file -->
            <xsl:call-template name="ntCreateFile">
                <xsl:with-param name="aFileName" select="concat($__APIGEE_PATH_APIPROXY_POLICIES,$__APIGEE_POLICY_AM_SET_TARGET_URL,'.xml')"/>
                <xsl:with-param name="aContent" select="apigee:setAMNoTargetUrlPolicy($__APIGEE_POLICY_AM_SET_TARGET_URL)"/>
            </xsl:call-template> 
        </xsl:if> 

		<!-- Create a logs variable containing security and procesing data traces -->
		<xsl:variable name="_logs" select="apigee:setLogs($_apiProxyName,
			$_apiProxyDescription,
			$_basePath,
			$_security,
			$_processing,
			$_paths)"/>

		<!-- Create log file with content that have been generated...-->
		<xsl:call-template name="ntCreateFile">
			<xsl:with-param name="aFileName" select="$__APIGEE_PATH_LOGS_FILE"/>
			<xsl:with-param name="aContent" select="$_logs"/>
		</xsl:call-template>

	</xsl:template>
			
</xsl:stylesheet>