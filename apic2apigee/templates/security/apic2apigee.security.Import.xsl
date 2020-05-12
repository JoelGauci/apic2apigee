<?xml version="1.0" encoding="utf-8"?>
<!--+	
	|************************************************************	
	|*** Author: Joel Gauci - joelgauci@google.com
	|*** file: apic2apigee.security.Import.xsl
	|*** Description: XSL Stylesheet, which imports templates to manage Open API Spec security related elements
	|*** Revision : 1.0 : initial version
	|************************************************************
	+ -->
<xsl:stylesheet version="3.0" 							
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		extension-element-prefixes="" 							
		exclude-result-prefixes="">
				
	<!-- Import security templates -->
	
	<!-- 'paths' templates -->
	<xsl:import href="apic2apigee.security.securityDefinitions.xsl"/>
    <xsl:import href="apic2apigee.security.cors.xsl"/>
				
</xsl:stylesheet>