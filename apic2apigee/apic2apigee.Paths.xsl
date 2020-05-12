<?xml version="1.0" encoding="utf-8"?>
<!--+	
	|************************************************************	
	|*** Author: Joel Gauci - joelgauci@google.com
	|*** file: apic2apigee.Paths.xsl
	|*** Description: Paths templates of the migration transformation
	|*** Revision : 1.0 : initial version
	|************************************************************
	+-->
<xsl:stylesheet version="3.0" 							
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:apigee="http://migration.apigee.com/"
		extension-element-prefixes="apigee" 							
		exclude-result-prefixes="apigee xs">

    <!-- Import Paths templates -->
        
    <!-- 'import' template that imports all the other telplates that match paths as defined in Open API Spec -->
    <xsl:import href="./templates/paths/apic2apigee.paths.Import.xsl"/>

<!--+
    |********************************
    |*** Matching Template
    |*** Element: paths
    |*** Mode: paths
    |********************************
    +-->
    <!-- This template matches the 'paths' element of the document -->
    <xsl:template match="paths" mode="paths">
        <xsl:param name="aProcessingNodeSet"/>

        <paths>
            <!-- apply templates on paths in the doc -->
            <xsl:apply-templates mode="paths">
                <xsl:with-param name="aProcessingNodeSet" select="$aProcessingNodeSet"/>
            </xsl:apply-templates>
        </paths>

    </xsl:template>
	
</xsl:stylesheet>