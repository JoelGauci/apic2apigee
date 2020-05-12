<?xml version="1.0" encoding="utf-8"?>
<!--+	
	|************************************************************	
	|*** Author: Joel Gauci - joelgauci@google.com
	|*** file: apic2apigee.target-endpoint.Import.xsl
	|*** Description: XSL Stylesheet, which imports some common templates to manage target endpoint configuration
	|*** Revision : 1.0 : initial version
	|************************************************************
	+ -->
<xsl:stylesheet version="3.0" 							
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		extension-element-prefixes="" 							
		exclude-result-prefixes="">
				
	<!-- Import common templates -->
	
	<!-- 'resources' templates -->
	<xsl:import href="apic2apigee.target-endpoint.Resources.xsl"/>

	<!-- Common target endpoint related templates -->
	<xsl:import href="apic2apigee.target-endpoint.Common.xsl"/>
				
</xsl:stylesheet>