<?xml version="1.0" encoding="utf-8"?>
<!--+	
	|************************************************************	
	|*** Author: Joel Gauci - joelgauci@google.com
	|*** file: apic2apigee.proxy-endpoint.Import.xsl
	|*** Description: XSL Stylesheet, which imports some common templates to manage proxy endpoint configuration
	|*** Revision : 1.0 : initial version
	|************************************************************
	+ -->
<xsl:stylesheet version="3.0" 							
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		extension-element-prefixes="" 							
		exclude-result-prefixes="">
				
	<!-- Import common templates -->
	
	<!-- 'paths' templates -->
	<xsl:import href="apic2apigee.proxy-endpoint.Resources.xsl"/>

	<!-- Common path related templates -->
	<xsl:import href="apic2apigee.proxy-endpoint.Common.xsl"/>
				
</xsl:stylesheet>