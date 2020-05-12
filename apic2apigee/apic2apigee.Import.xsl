<?xml version="1.0" encoding="utf-8"?>
<!--+	
	|************************************************************	
	|*** Author: Joel Gauci - joelgauci@google.com
	|*** file: apic2apigee.Import.xsl
	|*** Description: XSL Stylesheet, which imports some common templates
	|*** Revision : 1.0 : initial version
	|************************************************************
	+ -->
<xsl:stylesheet version="3.0" 							
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		extension-element-prefixes="" 							
		exclude-result-prefixes="">
				
	<!-- Import common templates -->
	
	<!-- Variables template -->
	<xsl:import href="apic2apigee.Variables.xsl"/>

	<!-- Debug template -->
	<xsl:import href="apic2apigee.Debug.xsl"/>

	<!-- Common templates -->
	<xsl:import href="apic2apigee.Common-Templates.xsl"/>

	<!-- Import policy templates-->
	<xsl:import href="apic2apigee.Policies.xsl"/>

	<!-- API Proxy Info template -->
	<xsl:import href="apic2apigee.Info.xsl"/>

	<!-- 'import' template that imports all the other templates that match security elements as defined in Open API Spec -->
    <xsl:import href="apic2apigee.Security.xsl"/>

	<!-- Manage APIC extension -->
	<xsl:import href="apic2apigee.xConfiguration.xsl"/>

	<!-- Manage Path -->
	<xsl:import href="apic2apigee.Paths.xsl"/>
	
	<!-- Manage ProxyEndpoint -->
	<xsl:import href="apic2apigee.Proxy-Endpoint.xsl"/>

	<!-- Manage ProxyEndpoint -->
	<xsl:import href="apic2apigee.Target-Endpoint.xsl"/>
		
</xsl:stylesheet>