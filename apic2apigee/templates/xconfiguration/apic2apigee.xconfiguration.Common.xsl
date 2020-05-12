<?xml version="1.0" encoding="utf-8"?>
<!--+	
	|************************************************************	
	|*** Author: Joel Gauci - joelgauci@google.com
	|*** file: apic2apigee.xconfiguration.Common.xsl
	|*** Description: x-configuration templates of the migration transformation
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
	|******************************************************
	|*** XSLT Function
	|*** Name: apigee:translateResourcePath
	|******************************************************
	+-->
    <!-- apigee 'translateResourcePath' function used to translate resource Path -->
    <xsl:function name="apigee:translateResourcePath">
        <xsl:param name="aNodeMethod"/>
        <xsl:param name="aResourcePath"/>
        
	    <!-- Create a preflight flow to manage CORS -->
        <xsl:sequence>

            <!-- Set the resource path -->
            <xsl:variable name="_resourcePath" select="replace($aResourcePath,'_ic_','/')"/>

            <!-- Create a variable for replacements on the same string -->
            <xsl:variable name="regexes">
                 <xsl:for-each select="$aNodeMethod/parameters[(./in/text() = 'path')]">
                    <regex><find><xsl:value-of select="concat('/',./name/text())"/></find><change>/*</change></regex>
                </xsl:for-each>
            </xsl:variable>

            <!-- Common templates for x-configuration -->
            <!-- replace path parameters in the current path -->
            <xsl:variable name="_tmpResourcePath">
                <xsl:call-template name="applyRegexes">
                    <xsl:with-param name="nodeText" select="$_resourcePath"/>
                    <xsl:with-param name="regex" select="$regexes/regex"/>
                </xsl:call-template>
            </xsl:variable>
            <!-- Set the result -->
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
                    <xsl:value-of select="$_resourcePath"/>
                </xsl:otherwise>
            </xsl:choose>
            
        </xsl:sequence>

    </xsl:function>

<!--+
	|******************************************************
	|*** XSLT Function
	|*** Name: apigee:setType
	|******************************************************
	+-->
    <!-- apigee 'setType' function used to set type attribute for tags -->
    <xsl:function name="apigee:setType">
        <xsl:param name="aCurrentNodeSet"/>
        <xsl:param name="aType"/>
        
        <xsl:sequence>
            <!-- set the '@type' attribute: request (default) | response | route -->
            <xsl:choose>    
                <xsl:when test="(count($aCurrentNodeSet/../following-sibling::execute//invoke) &gt; 0) or (count($aCurrentNodeSet/../following-sibling::execute//proxy) &gt; 0)">
                    <xsl:value-of select="'request'"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:choose>
                        <xsl:when test="( $aType = 'proxy' ) or ( $aType = 'invoke' )">
                            <xsl:value-of select="'route'"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="'response'"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>

        </xsl:sequence>

    </xsl:function>

<!--+
	|******************************************************
	|*** XSLT Function
	|*** Name: apigee:setTypeScript
	|******************************************************
	+-->
    <!-- apigee 'setTypeScript' function used to set type attribute for script tag (coming from GatewayScript) -->
    <xsl:function name="apigee:setTypeScript">
        <xsl:param name="aCurrentNodeSet"/>
        
        <xsl:sequence>
            <!-- set the '@type' attribute: request (default) | response | route -->
            <xsl:choose>    
                <xsl:when test="(count($aCurrentNodeSet/../following-sibling::execute//invoke) &gt; 0) or (count($aCurrentNodeSet/../following-sibling::execute//proxy) &gt; 0)">
                    <xsl:value-of select="'request'"/>
                </xsl:when>
                <!-- no execute node after the current node (script) and nor invoke nor proxy tag before -->
                <xsl:when test="( count($aCurrentNodeSet/../following-sibling::execute) &lt;= 0 ) and ( (count($aCurrentNodeSet/../preceding-sibling::execute//invoke) &lt;= 0) and (count($aCurrentNodeSet/../preceding-sibling::execute//proxy) &lt;= 0) )">
                    <xsl:value-of select="'no-target'"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="'response'"/>
                </xsl:otherwise>
            </xsl:choose>

        </xsl:sequence>

    </xsl:function>

<!--+
	|******************************************************
	|*** XSLT Named template
	|*** Name: applyRegexes
	|******************************************************
	+-->
    <!-- apigee 'applyRegexes' named template used for recursive replacements on a string -->
    <xsl:template name="applyRegexes">
        <xsl:param name="nodeText"/>
        <xsl:param name="regex"/>
        
        <xsl:choose>
            <xsl:when test="$regex">
                <xsl:call-template name="applyRegexes">
                    <xsl:with-param name="nodeText" select="replace($nodeText,$regex[1]/find,$regex[1]/change)"/>
                    <xsl:with-param name="regex" select="$regex[position()>1]"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$nodeText"/>
            </xsl:otherwise>
        </xsl:choose>

     </xsl:template>
				
</xsl:stylesheet>