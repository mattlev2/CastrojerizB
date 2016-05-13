<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml" xmlns:tei="http://www.tei-c.org/ns/1.0">
    <xsl:output method="text" omit-xml-declaration="yes" encoding="ISO-8859-1"/>


    <xsl:template match="tei:text/text()">
        <xsl:variable name="sub1" select="replace(., ' e ', ' \\&amp; ')"/>
        <!--Faire la même chose avec les guillemets ouvrants et fermants-->
        <xsl:variable name="sub2" select="replace($sub1, '-', '--')"/>
        <xsl:variable name="sub3" select="replace($sub2, '\.', '. ')"/>
        <xsl:variable name="sub4" select="replace($sub3, ' \. ', '.')"/>
        <xsl:variable name="sub5" select="replace($sub4, ' ,', ',')"/>
        <xsl:variable name="sub6" select="replace($sub5, ';', ';~')"/>
        <xsl:variable name="sub7" select="replace($sub6, '~~', '~')"/>
        <xsl:variable name="sub8" select="replace($sub7, '~ ', '~')"/>
        <xsl:variable name="sub9" select="replace($sub8, ' mente', 'mente')"/>
        <!--Permet de cibler les notes de bas de page et de laisser les espaces pour l'italique p.e-->
        <xsl:variable name="sub10" select="replace($sub9, ' \\foot', '\\foot')"/>
        <!--Permet de cibler les notes de bas de page et de laisser les espaces pour l'italique p.e-->
        <xsl:value-of select="$sub10"/>
    </xsl:template>

</xsl:stylesheet>
