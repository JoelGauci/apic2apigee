<?xml version="1.0" encoding="utf-8"?>
<!--+	
	|************************************************************	
	|*** Author: Joel Gauci - joelgauci@google.com
	|*** file: apic2apigee.paths.Resources.xsl
	|*** Description: resources templates of the migration transformation
	|*** Revision : 1.0 : initial version
	|************************************************************
	+-->
<xsl:stylesheet version="3.0" 							
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:apigee="http://migration.apigee.com/"
		extension-element-prefixes="apigee" 							
		exclude-result-prefixes="apigee xs">

<!--+
    |**********************************************
    |*** Matching Template
    |*** Element: *[starts-with(local-name(), '_ic_')]
    |*** Mode: paths
    |**********************************************
    +-->
    <!-- This template matches the '_ic_xxx' resources element of the document -->
    <!-- ic: invalid character identified during the JSON 2 XML transformation -->
    <xsl:template match="*[starts-with(local-name(), $__SLASH_REPLACEMENT_VARIABLE)]" mode="paths">
        <xsl:param name="aProcessingNodeSet"/>

        <!-- Set the resource path -->
        <xsl:variable name="_resourcePath" select="replace(local-name(),'_ic_','/')"/>

        <!-- Apply templates and push some data at the same time... -->
        <xsl:apply-templates mode="paths">
            <xsl:with-param name="aResourcePath" select="$_resourcePath"/>
            <xsl:with-param name="aProcessingNodeSet" select="$aProcessingNodeSet"/>
        </xsl:apply-templates>

    </xsl:template>

<!--+
    |*******************************************************************************************************************
    |*** Matching Template
    |*** Element: get|Get|GET|post|Post|POST|delete|Delete|DELETE|put|Put|PUT|options|Options|OPTIONS|patch|Patch|PATCH
    |*** Mode: paths
    |*******************************************************************************************************************
    +-->
    <!-- This template matches the 'get|Get|GET' resources element of the document -->
    <xsl:template match="get|Get|GET|post|Post|POST|delete|Delete|DELETE|put|Put|PUT|options|Options|OPTIONS|patch|Patch|PATCH" mode="paths">
        <xsl:param name="aResourcePath"/>
        <xsl:param name="aProcessingNodeSet"/>

        <!-- replace path parameters in the current path -->
        <xsl:variable name="_tmpResourcePath">
            <xsl:for-each select="./parameters[(./in/text() = 'path')]">
                <xsl:variable name="pathName" select="./name/text()"/>
                <xsl:value-of select="replace($aResourcePath,$pathName,'*')"/>
            </xsl:for-each>
        </xsl:variable>

        <!-- use the right path: original or modified -->
        <xsl:variable name="_resourcePath">
            <xsl:choose>
                <xsl:when test="string-length($_tmpResourcePath) &gt; 0">
                    <!-- remove the trailing slash '/' -->
                    <xsl:choose>
                        <xsl:when test="ends-with($_tmpResourcePath,'/')">
                            <xsl:value-of select="substring($_tmpResourcePath, 1, string-length($_tmpResourcePath) - 1)"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$_tmpResourcePath"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$aResourcePath"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <!-- get context info from the current path -->
        <xsl:variable name="_verb" select="local-name()"/>
        <xsl:variable name="_operationId" select="./operationId/text()"/>

        <!-- if the resource has not already been identified through an operation switch in the assembly -->
        <xsl:if test="(count($aProcessingNodeSet/steps/resource[@id=$_operationId]) &lt;= 0 ) and ( count($aProcessingNodeSet/steps/resource[@verb=$_verb and @path=$_resourcePath]) &lt;= 0 )">
            <path>
                <verb><xsl:value-of select="$_verb"/></verb>
                <condition><xsl:value-of select="concat($__APIGEE_CONDITION_PREFIX_MATCHESPATH,$_resourcePath,$__APIGEE_CONDITION_SUFFIX,$__APIGEE_CONDITION_PREFIX_METHOD,upper-case(./local-name()),$__APIGEE_CONDITION_SUFFIX)"/></condition>
                <resource><xsl:value-of select="$_resourcePath"/></resource>
            </path>
        </xsl:if>

    </xsl:template>

<!--+
    |********************************
    |*** Matching Template
    |*** Element: paths
    |*** Mode: flows
    |********************************
    +-->
    <!-- This template matches the 'paths' element of the paths document -->
    <xsl:template match="paths" mode="flows">
        <!-- apply templates on each 'path' element -->
        <xsl:apply-templates select="path" mode="flows"/>
    </xsl:template>

<!--+
    |********************************
    |*** Matching Template
    |*** Element: path
    |*** Mode: flows
    |********************************
    +-->
    <!-- This template matches the 'path' element of the paths document -->
    <xsl:template match="path" mode="flows">
        <Flow>
            <xsl:attribute name="name">
                <xsl:value-of select="concat(upper-case(./verb/text()),' ',./resource/text())"/>
            </xsl:attribute>
            <Request/>
            <Response/>
            <Condition><xsl:value-of select="./condition/text()"/></Condition>
        </Flow>
    </xsl:template>
			
</xsl:stylesheet>