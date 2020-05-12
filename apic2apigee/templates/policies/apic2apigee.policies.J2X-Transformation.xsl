<?xml version="1.0" encoding="utf-8"?>
<!--+	
	|************************************************************	
	|*** Author: Joel Gauci - joelgauci@google.com
	|*** file: apic2apigee.policies.J2X-Transformation.xsl
	|*** Description: policy templates of the migration transformation
	|*** Revision : 1.0 : initial version
	|************************************************************
	+-->
<xsl:stylesheet version="3.0" 							
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:apigee="http://migration.apigee.com/"
		extension-element-prefixes="apigee" 							
        exclude-result-prefixes="apigee xs">
        
    <!-- Define the output as an indented XML content -->
    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
				
<!--+
    |
    + #====================XSLT Functions====================#
    |
    +-->
             
<!--+
	|******************************************************
	|*** XSLT Function
	|*** Name: apigee:setJ2XTransformation
	|******************************************************
	+-->
    <!-- apigee 'setJ2XTransformation' function used to transform JSON into XML -->
    <xsl:function name="apigee:setJ2XTransformation">
        <xsl:param name="aPolicyName"/>
        <xsl:param name="aType"/>
        
        <xsl:sequence>
            <!-- JSON 2 XML POLICY -->
            <JSONToXML async="false" continueOnError="false" enabled="true" name="{$aPolicyName}">
                <DisplayName><xsl:value-of select="$aPolicyName"/></DisplayName>
                <Properties/>
                <Options>
                    <NullValue>NULL</NullValue>
                    <NamespaceBlockName>#namespaces</NamespaceBlockName>
                    <DefaultNamespaceNodeName>$default</DefaultNamespaceNodeName>
                    <NamespaceSeparator>:</NamespaceSeparator>
                    <TextNodeName>#text</TextNodeName>
                    <AttributeBlockName>#attrs</AttributeBlockName>
                    <AttributePrefix>@</AttributePrefix>
                    <InvalidCharsReplacement>_</InvalidCharsReplacement>
                    <ObjectRootElementName>Root</ObjectRootElementName>
                    <ArrayRootElementName>Array</ArrayRootElementName>
                    <ArrayItemElementName>Item</ArrayItemElementName>
                </Options>
                <OutputVariable><xsl:value-of select="$aType"/></OutputVariable>
                <Source><xsl:value-of select="$aType"/></Source>
            </JSONToXML>

        </xsl:sequence>
    </xsl:function>
    
</xsl:stylesheet>