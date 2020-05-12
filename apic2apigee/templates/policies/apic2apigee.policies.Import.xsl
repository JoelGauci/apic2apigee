<?xml version="1.0" encoding="utf-8"?>
<!--+	
	|************************************************************	
	|*** Author: Joel Gauci - joelgauci@google.com
	|*** file: apic2apigee.policies.Import.xsl
	|*** Description: XSL Stylesheet, which imports Apigee policies templates
	|*** Revision : 1.0 : initial version
	|************************************************************
	+ -->
<xsl:stylesheet version="3.0" 							
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		extension-element-prefixes="" 							
		exclude-result-prefixes="">
				
	<!-- Import Apigee Policies templates -->
	
	<!-- 'VAK' template -->
	<xsl:import href="apic2apigee.policies.VAK-VerifyAPIKey.xsl"/>
	<!-- 'RF - Verify API Secret' template -->
	<xsl:import href="apic2apigee.policies.RF-VerifyAPISecret.xsl"/>
    <!-- 'CORS' template -->
	<xsl:import href="apic2apigee.policies.AM-Cors.xsl"/>
	<!-- 'DoNotCopyPathSuffix' template -->
	<xsl:import href="apic2apigee.policies.AM-NoTargetCopyPathSuffix.xsl"/>
	<!-- 'Assign Message' template -->
	<xsl:import href="apic2apigee.policies.AM-Mapping.xsl"/>
	<!-- 'ExtractVariable' template -->
	<xsl:import href="apic2apigee.policies.EV-Mapping.xsl"/>
	<!-- 'RF - 404 Not Found' template -->
	<xsl:import href="apic2apigee.policies.RF-404-NotFound.xsl"/>
	<!-- 'Common' templates -->
	<xsl:import href="apic2apigee.policies.Common.xsl"/>
	<!-- 'JavaScript' templates -->
	<xsl:import href="apic2apigee.policies.JS-Script.xsl"/>
	<!-- 'AM - no target' templates -->
	<xsl:import href="apic2apigee.policies.AM-NoTarget.xsl"/>
	<!-- 'AM - set target' templates -->
	<xsl:import href="apic2apigee.policies.AM-SetTarget.xsl"/>
	<!-- 'AM - set target URL' templates -->
	<xsl:import href="apic2apigee.policies.AM-SetTargetUrl.xsl"/>
	<!-- 'J2X - transformation' templates -->
	<xsl:import href="apic2apigee.policies.J2X-Transformation.xsl"/>
	<!-- 'X2J - transformation' templates -->
	<xsl:import href="apic2apigee.policies.X2J-Transformation.xsl"/>
				
</xsl:stylesheet>