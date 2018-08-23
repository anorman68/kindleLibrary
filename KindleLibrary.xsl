<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output encoding="utf-8" indent="yes" method="html"/>

  <xsl:template match="/">
    <html>
      <head>
        <title>My Kindle Library</title>
      </head>
      <body>
        <h1>Book Titles</h1>
        <table>
          <thead>
            <td>Title</td>
            <td>Date Published</td>
            <td>Date Purchased</td>
            <td>Publisher</td>
            <td>ASIN</td>
          </thead>
          <xsl:for-each select="//meta_data">
            <xsl:sort select="title/text()"/>
            <xsl:apply-templates select="." mode="titles"/>
          </xsl:for-each>
        </table>
        <h1>Authors</h1>
        <table>
          <thead>
            <td>Author</td>
            <td>Titles</td>
          </thead>
          <xsl:for-each select="//meta_data/authors/author">
            <xsl:sort select="text()"/>
            <xsl:apply-templates select="."/>
          </xsl:for-each>
        </table>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="meta_data" mode="titles">
    <xsl:choose>
      <xsl:when test="substring(title/text(), 1, 5) ne '-----'">
        <tr>
          <td>
            <xsl:value-of select="title/text()"/>
          </td>
          <td>
            <xsl:value-of select="substring(publication_date, 1, 10)"/>
          </td>
          <td>
            <xsl:value-of select="substring(purchase_date, 1, 10)"/>
          </td>
          <td>
              <xsl:value-of select="publishers"/>
          </td>
          <td>
            <xsl:value-of select="ASIN"/>
          </td>
        </tr>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="publishers">
    <p>
      <xsl:value-of select="publisher"/>
    </p>
  </xsl:template>

  <xsl:template match="author">
    <xsl:choose>
      <xsl:when test="substring(author/text(), 1, 5) ne '-----'">

        <tr>
          <td>
            <xsl:value-of select="text()"/>
          </td>
          <td>
            <xsl:value-of select="../../title/text()"/>
          </td>
        </tr>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>