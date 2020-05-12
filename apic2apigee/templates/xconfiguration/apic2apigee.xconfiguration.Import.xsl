<?xml version="1.0" encoding="utf-8"?>
<!--+	
	|************************************************************	
	|*** Author: Joel Gauci - joelgauci@google.com
	|*** file: apic2apigee.xconfiguration.Import.xsl
	|*** Description: XSL Stylesheet, which imports some common templates to manage extensions
	|*** Revision : 1.0 : initial version
	|************************************************************
	+ -->
<xsl:stylesheet version="3.0" 							
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		extension-element-prefixes="" 							
		exclude-result-prefixes="">
				
	<!-- Import common templates -->
	
	<!-- 'common' template -->
	<xsl:import href="apic2apigee.xconfiguration.Common.xsl"/>
	<!-- 'operation switch' template -->
	<xsl:import href="apic2apigee.xconfiguration.OperationSwitch.xsl"/>
	<!-- 'switch' template -->
	<xsl:import href="apic2apigee.xconfiguration.Switch.xsl"/>
	<!-- 'map' template -->
	<xsl:import href="apic2apigee.xconfiguration.Map.xsl"/>
	<!-- 'gatewayscript' template -->
	<xsl:import href="apic2apigee.xconfiguration.GatewayScript.xsl"/>
	<!-- 'invoke' template -->
	<xsl:import href="apic2apigee.xconfiguration.Invoke.xsl"/>
	<!-- 'proxy' template -->
	<xsl:import href="apic2apigee.xconfiguration.Proxy.xsl"/>
	<!-- 'xml2json' template -->
	<xsl:import href="apic2apigee.xconfiguration.XML2JSON.xsl"/>
	<!-- 'json2xml' template -->
	<xsl:import href="apic2apigee.xconfiguration.JSON2XML.xsl"/>

</xsl:stylesheet>