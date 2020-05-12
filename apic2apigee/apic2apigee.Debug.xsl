<?xml version="1.0" encoding="utf-8"?>
<!--+	
	|************************************************************	
	|*** Author: Joel Gauci - joelgauci@google.com
	|*** file: apic2apigee.Debug.xsl
	|*** Description: debugging templates of the migration transformation
	|*** Revision : 1.0 : initial version
	|************************************************************
	+-->
<xsl:stylesheet version="3.0" 							
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:apigee="http://migration.apigee.com/"
		extension-element-prefixes="apigee" 							
		exclude-result-prefixes="apigee xs">

	<!-- debug parameter - debug or not ? default value MUST be false (true for testing...) -->
	<!-- add: '-p debug=true' on your command line to debug -->
	<xsl:param name="debug" select="'false'" as="xs:string"/>
				
<!--+
		|********************************
		|*** Named Template
		|*** Name: __debug
		|********************************
		+-->
	<!-- This template is used to perform debugging from the other XSL Stylesheets. -->
	<xsl:template name="__debug">
		<xsl:param name="aMessage"/>
		<xsl:param name="aValue"/>
		
		<xsl:if test="$debug = 'true'">
			<xsl:message><xsl:value-of select="concat($__LOG_PREFIX,' ',$aMessage,':',$aValue)"/></xsl:message>
		</xsl:if>
		
	</xsl:template>

<!--+
    | #====================XSLT Functions====================#
    +-->
             
<!--+
		|******************************************************
		|*** XSLT Function
		|*** Name: apigee:debug
		|******************************************************
		+-->
    <!-- apigee debug function-->
    <xsl:function name="apigee:debug">
		<xsl:param name="message" as="xs:string"/>
		<xsl:param name="value" as="xs:string"/>
		
		<!-- trace the message and its value -->
		<xsl:if test="$debug = 'true'">
			<xsl:sequence select="concat($__LOG_PREFIX,' ',$message,':',$value)"></xsl:sequence>
		</xsl:if>
		
	</xsl:function>
				
</xsl:stylesheet>