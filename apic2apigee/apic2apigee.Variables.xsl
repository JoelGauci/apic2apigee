<?xml version="1.0" encoding="utf-8"?>
<!--+
	|************************************************************	
	|*** Author: Joel Gauci - joelgauci@google.com
	|*** file: apic2apigee.Variables.xsl
	|*** Description: XSL Stylesheet, which defines global variables of the apic 2 apigee migration tool
	|*** Revision : 1.0 : initial version
	|************************************************************
	+-->
<xsl:stylesheet version="3.0" 							
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		extension-element-prefixes="" 							
		exclude-result-prefixes="">

	<!--+
    	| #====================Migration Tool Variables====================#
    	+-->

	<!-- XSLT Version -->
	<xsl:variable name="__XSLT_VERSION">0.1.0</xsl:variable>
	
	<!-- Log Prefix -->
	<xsl:variable name="__LOG_PREFIX">***log***</xsl:variable>

	<!-- OpenAPI Spec slash replacement variable - slash is an invalid character (ic) in a XML element -->
	<xsl:variable name="__SLASH_REPLACEMENT_VARIABLE">_ic_</xsl:variable>

	<!--+
    	| #====================Apigee Edge Variables====================#
    	+-->
	
	<!-- 'organization' Value -->
	<xsl:variable name="__APIGEE_ORGANIZATION">organisation</xsl:variable>
	
	<!-- 'environment' Value -->
	<xsl:variable name="__APIGEE_ENVIRONMENT">environment</xsl:variable>

	<!-- 'https virtual host' Value -->
	<xsl:variable name="__APIGEE_VIRTUAL_HOST_SECURE">secure</xsl:variable>

	<!-- 'http virtual host' Value -->
	<xsl:variable name="__APIGEE_VIRTUAL_HOST_DEFAULT">default</xsl:variable>

	<!-- enable SSL on targets -->
	<xsl:variable name="__APIGEE_SSL_ENABLED">true</xsl:variable>

	<!-- disable SSL on targets -->
	<xsl:variable name="__APIGEE_SSL_DISABLED">false</xsl:variable>

	<!-- condition regexp prefix -->
	<xsl:variable name="__APIGEE_CONDITION_PREFIX_REGEXP">(request.path ~~ "</xsl:variable>

	<!-- condition regexp prefix -->
	<xsl:variable name="__APIGEE_CONDITION_PREFIX_MATCHESPATH">(proxy.pathsuffix MatchesPath "</xsl:variable>

	<!-- condition regexp suffix -->
	<xsl:variable name="__APIGEE_CONDITION_SUFFIX">")</xsl:variable>

	<!-- condition regexp suffix -->
	<xsl:variable name="__APIGEE_CONDITION_PREFIX_METHOD"> and (request.verb = "</xsl:variable>

	<!-- condition for api secret verification -->
	<xsl:variable name="__APIGEE_CONDITION_APISECRET_CHECK_PREFIX_METHOD">verifyapikey.VAK-VerifyAPIKey.client_secret != </xsl:variable>

	<!-- condition for api secret verification -->
	<xsl:variable name="__APIGEE_CONDITION_NO_TARGET">flow.no-target = "true"</xsl:variable>

	<!-- API Proxy default revision -->
	<xsl:variable name="__APIGEE_APIPROXY_DEFAULT_REVISION">1</xsl:variable>

	<!-- API Proxy description version separator -->
	<xsl:variable name="__APIGEE_APIPROXY_DESCRIPTION_VERSION_SEPARATOR"> - version: </xsl:variable>

	<!-- Apigee API Proxy Configuration version: MAJOR -->
	<xsl:variable name="__APIGEE_APIPROXY_CONFIGURATION_MAJOR_VERSION">4</xsl:variable>

	<!-- Apigee API Proxy Configuration version: MINOR -->
	<xsl:variable name="__APIGEE_APIPROXY_CONFIGURATION_MINOR_VERSION">0</xsl:variable>

	<!-- PATHS FOR APIGEE POLICY , PROXY , TARGET ..... -->
	<!-- Paths for the content generation -->
	<xsl:variable name="__APIGEE_PATH_APIPROXY_ROOT">./_res_/apiproxy/</xsl:variable>
	<xsl:variable name="__APIGEE_PATH_APIPROXY_PROXYENDPOINT">./_res_/apiproxy/proxies/</xsl:variable>
	<xsl:variable name="__APIGEE_PATH_APIPROXY_TARGETENDPOINT">./_res_/apiproxy/targets/</xsl:variable>
	<xsl:variable name="__APIGEE_PATH_APIPROXY_POLICIES">./_res_/apiproxy/policies/</xsl:variable>
	<xsl:variable name="__APIGEE_PATH_APIPROXY_RESOURCES_JSC">./_res_/apiproxy/resources/jsc/</xsl:variable>
	<xsl:variable name="__APIGEE_PATH_LOGS_FILE">./_res_/logs/logs.xml</xsl:variable>

	<!--+
    	| #====================OpenAPI Spec/Swagger Variables====================#
    	+-->

	<!-- Open API Spec / Swagger: apiKey in securityDefinitions -->
	<xsl:variable name="__OAS_SWAGGER_SECURITYDEFINITIONS_APIKEY">apiKey</xsl:variable>

	<!--+
    	| #====================Apigee Policy Variables====================#
    	+-->

	<!-- Policy file extension -->
	<xsl:variable name="__APIGEE_POLICY_FILE_EXTENSION">.xml</xsl:variable>

	<!-- AM CORS Policy -->
	<xsl:variable name="__APIGEE_POLICY_AM_CORS_ACCESS-CONTROL-ALLOW-ORIGIN">*</xsl:variable>
	<xsl:variable name="__APIGEE_POLICY_AM_CORS_ACCESS-CONTROL-ALLOW-HEADERS">origin, x-requested-with, accept, content-type</xsl:variable>
	<xsl:variable name="__APIGEE_POLICY_AM_CORS_ACCESS-CONTROL-MAX-AGE">3628800</xsl:variable>
	<xsl:variable name="__APIGEE_POLICY_AM_CORS_ACCESS-CONTROL-ALLOW-METHODS">GET, PUT, POST, DELETE</xsl:variable>
	<xsl:variable name="__APIGEE_POLICY_AM_CORS_CONDITION_NOT_EQUAL">request.verb != "OPTIONS"</xsl:variable>
	<xsl:variable name="__APIGEE_POLICY_AM_CORS_CONDITION_EQUAL">request.verb = "OPTIONS"</xsl:variable>

	<!-- Security related policies: names -->
	<xsl:variable name="__APIGEE_POLICY_AM_CORS_NAME">AM-Cors</xsl:variable>
	<xsl:variable name="__APIGEE_POLICY_AM_NO_TARGET">AM-NoTarget</xsl:variable>
	<xsl:variable name="__APIGEE_POLICY_VAK_VERIFYAPIKEY_NAME">VAK-APIKey</xsl:variable>
	<xsl:variable name="__APIGEE_POLICY_RF_VERIFYAPISECRET_NAME">RF-VerifyAPISecret</xsl:variable>
	<xsl:variable name="__APIGEE_POLICY_RF_404_NOTFOUND_NAME">RF-404NotFound</xsl:variable>
	<xsl:variable name="__APIGEE_POLICY_EV_MAPPING_NAME">EV-Mapping-</xsl:variable>
	<xsl:variable name="__APIGEE_POLICY_AM_MAPPING_NAME">AM-Mapping-</xsl:variable>
	<xsl:variable name="__APIGEE_POLICY_JAVASCRIPT_NAME">JS-Script-</xsl:variable>
	<xsl:variable name="__APIGEE_POLICY_AM_SET_TARGET">AM-SetTarget-</xsl:variable>
	<xsl:variable name="__APIGEE_POLICY_AM_SET_TARGET_URL">AM-SetTargetUrl</xsl:variable>
	<xsl:variable name="__APIGEE_POLICY_XML2JSON_NAME">X2J-Xml2Json-</xsl:variable>
	<xsl:variable name="__APIGEE_POLICY_JSON2XML_NAME">J2X-Json2Xml-</xsl:variable>
	
	<!-- Target Endpoint related policies: names -->
	<xsl:variable name="__APIGEE_POLICY_AM_NOCOPYPATHSUFFIX_NAME">AM-NoCopyPathSuffix</xsl:variable>

	<!--+
    	| #====================Target Endpoint Default Values====================#
    	+-->

	<!-- HTTP Target Endpoint URL Default Value -->
	<xsl:variable name="__APIGEE_TARGETENDPOINT_URL_DEFAULT">_no_target_</xsl:variable>

	<!--+
    	| #====================IBM APIC Specific Variables====================#
    	+-->

	<!-- APIC start variable '$(' -->
	<xsl:variable name="__APIC_START_VARIABLE">$(</xsl:variable>
	<!-- APIC end variable ')' -->
	<xsl:variable name="__APIC_END_VARIABLE">)</xsl:variable>
	<!-- APIC - apim get variable prefix -->
	<xsl:variable name="__APIC_APIM_GET_VARIABLE_PREFIX">
		<xsl:text>apim.getvariable\('</xsl:text>
	</xsl:variable>
	<!-- APIC - apim get variable suffix -->
	<xsl:variable name="__APIC_APIM_GET_VARIABLE_SUFFIX">
		<xsl:text>'\)</xsl:text>
	</xsl:variable>

</xsl:stylesheet>