<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="html" encoding="utf-8" standalone="no" media-type="text/html" />
    <xsl:param name="product"/>
    <xsl:param name="version"/>
    <xsl:variable name="lowercase" select="'abcdefghijklmnopqrstuvwxyz'" />
    <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

    <xsl:template match="/">
        <html>
            <head>
                <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
                <link rel="stylesheet" type="text/css" href="licenses.css"/>
            </head>
            <body>
                <h2><xsl:value-of select="$product"/><xsl:text> </xsl:text><xsl:value-of select="$version"/></h2>
                <p>The following material has been provided for informational purposes only, and should not be relied upon or construed as a legal opinion or legal advice.</p>
                <!-- Read matching templates -->
                <table>
                    <tr>
                        <th>Package Group</th>
                        <th>Package Artifact</th>
                        <th>Package Version</th>
                        <th>Remote Licenses</th>
                        <th>Local Licenses</th>
                    </tr>
                    <xsl:for-each select="licenseSummary/dependencies/dependency">
                        <xsl:sort select="concat(groupId, '.', artifactId)"/>
                        <tr>
                            <td><xsl:value-of select="groupId"/></td>
                            <td><xsl:value-of select="artifactId"/></td>
                            <td><xsl:value-of select="version"/></td>
                            <td>
                                <xsl:for-each select="licenses/license">
                                    <a href="{./url}"><xsl:value-of select="name"/></a><br/>
                                </xsl:for-each>
                            </td>
                            <td>
                                <xsl:for-each select="licenses/license">
                                    <xsl:variable name="name" select="translate(name,$uppercase,$lowercase)" />
                                    <xsl:variable name="last-index">
                                        <xsl:call-template name="last-index-of">
                                            <xsl:with-param name="txt" select="url"/>
                                            <xsl:with-param name="delimiter" select="'/'"></xsl:with-param>
                                        </xsl:call-template>
                                    </xsl:variable>
                                    <xsl:variable name="prefix" select="concat($name,' - ')" />
                                    <xsl:variable name="postfix" select="substring(url,$last-index+1)" />
                                    <xsl:variable name="filename">
                                        <xsl:call-template name="remap-local-filename">
                                            <xsl:with-param name="filename" select="concat($prefix,translate($postfix,$uppercase,$lowercase))" />
                                        </xsl:call-template>
                                    </xsl:variable>
                                    <a href="{$filename}"><xsl:value-of select="$filename"/></a><br/>
                                </xsl:for-each>
                            </td>
                        </tr>
                    </xsl:for-each>
                </table>
            </body>
        </html>
    </xsl:template>

    <xsl:template name="last-index-of">
        <xsl:param name="txt"/>
        <xsl:param name="remainder" select="$txt"/>
        <xsl:param name="delimiter" select="' '"/>

        <xsl:choose>
            <xsl:when test="contains($remainder, $delimiter)">
                <xsl:call-template name="last-index-of">
                    <xsl:with-param name="txt" select="$txt"/>
                    <xsl:with-param name="remainder" select="substring-after($remainder, $delimiter)"/>
                    <xsl:with-param name="delimiter" select="$delimiter"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="lastIndex" select="string-length(substring($txt, 1, string-length($txt)-string-length($remainder)))+1"/>
                <xsl:choose>
                    <xsl:when test="string-length($remainder)=0">
                        <xsl:value-of select="string-length($txt)"/>
                    </xsl:when>
                    <xsl:when test="$lastIndex>0">
                        <xsl:value-of select="($lastIndex - string-length($delimiter))"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="0"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="remap-local-filename">
        <xsl:param name="filename"/>

        <xsl:choose>
            <xsl:when test="contains($filename, 'apache') and contains($filename, 'version 2.0')">
                <xsl:text>apache license, version 2.0.txt</xsl:text>
            </xsl:when>
            <xsl:when test="contains($filename, 'apache') and contains($filename, 'license-2.0')">
                <xsl:text>apache license, version 2.0.txt</xsl:text>
            </xsl:when>
            <xsl:when test="contains($filename, 'jsr-000107')">
                <xsl:text>apache license, version 2.0.txt</xsl:text>
            </xsl:when>
            <xsl:when test="contains($filename, 'cddl') and contains($filename, 'gplv2')">
                <xsl:text>cddl-gplv2-classpath.txt</xsl:text>
            </xsl:when>
            <xsl:when test="contains($filename, 'cddl+gpl_1_1')">
                <xsl:text>cddl-1.1-gpl-1-1.txt</xsl:text>
            </xsl:when>
            <xsl:when test="contains($filename, 'cddl.txt')">
                <xsl:text>cddl.txt</xsl:text>
            </xsl:when>
            <xsl:when test="contains($filename, 'lgpl-2.1')">
                <xsl:text>lgpl-2.1.txt</xsl:text>
            </xsl:when>
            <xsl:when test="contains($filename, 'gpl-2.0-ce')">
                <xsl:text>gpl-2.0-ce.txt</xsl:text>
            </xsl:when>
            <xsl:when test="contains($filename, 'epl-v10')">
                <xsl:text>epl-1.0.txt</xsl:text>
            </xsl:when>
            <xsl:when test="contains($filename, 'mit license')">
                <xsl:text>mit.txt</xsl:text>
            </xsl:when>
            <xsl:when test="contains($filename, 'new bsd license')">
                <xsl:text>bsd-license.txt</xsl:text>
            </xsl:when>
            <xsl:when test="contains($filename, 'bsd style - license')">
                <xsl:text>xstream-bsd.txt</xsl:text>
            </xsl:when>
            <xsl:when test="contains($filename, 'bsd license - license')">
                <xsl:text>antlr-bsd.txt</xsl:text>
            </xsl:when>
            <xsl:when test="contains($filename, 'public domain')">
                <xsl:text>cc0-1.0.txt</xsl:text>
            </xsl:when>
            <!--xsl:when test="contains($filename, 'public domain')">
                <xsl:text>xmlpull.txt</xsl:text>
            </xsl:when -->
            <xsl:otherwise>
                <xsl:value-of select="$filename"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>