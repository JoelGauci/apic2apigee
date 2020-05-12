<?xml version="1.0" encoding="utf-8"?>
<!--+	
	|************************************************************	
	|*** Author: Joel Gauci - joelgauci@google.com
	|*** file: apic2apigee.Security.xsl
	|*** Description: XSL Stylesheet, which imports policies templates
	|*** Revision : 1.0 : initial version
	|************************************************************
	+ -->
<xsl:stylesheet version="3.0" 							
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		extension-element-prefixes="" 							
		exclude-result-prefixes="">
				
	<!-- Import common templates -->
	
	<!-- Import policy templates-->
	<xsl:import href="./templates/security/apic2apigee.security.Import.xsl"/>
		
</xsl:stylesheet>