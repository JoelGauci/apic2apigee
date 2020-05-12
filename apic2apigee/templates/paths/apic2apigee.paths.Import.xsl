<?xml version="1.0" encoding="utf-8"?>
<!--+	
	|************************************************************	
	|*** Author: Joel Gauci - joelgauci@google.com
	|*** file: apic2apigee.paths.Import.xsl
	|*** Description: XSL Stylesheet, which imports some common templates to manage Open API Spec paths
	|*** Revision : 1.0 : initial version
	|************************************************************
	+ -->
<xsl:stylesheet version="3.0" 							
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		extension-element-prefixes="" 							
		exclude-result-prefixes="">
				
	<!-- Import common templates -->
	
	<!-- 'paths' templates -->
	<xsl:import href="apic2apigee.paths.Resources.xsl"/>

	<!-- Common path related templates -->
	<xsl:import href="apic2apigee.paths.Common.xsl"/>
				
</xsl:stylesheet>