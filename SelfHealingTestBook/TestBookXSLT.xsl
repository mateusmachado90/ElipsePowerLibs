<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fn="http://www.w3.org/2005/xpath-functions">
  <xsl:output method="html"/>
  <xsl:template match="/">

    <html>
      <body>
        <xsl:for-each select="SelfHealingTestBook/SelfHealingTest">

          <h2>
            Teste #<xsl:value-of select="./@index" /> - <xsl:value-of select="./TriggerType/@desc" /> no <xsl:call-template name="EquipClassMeaning">
              <xsl:with-param name="EquipClass" select="./TriggerEquip/@class"></xsl:with-param>
            </xsl:call-template>&#160;<xsl:value-of select="./TriggerEquip" />
          </h2>
          <h3>Preparação do teste:</h3>
          <table style="border: 1px solid black;">
            <tbody>
              <tr>
                <td style="text-align: center; border: 1px solid black;">
                  <p>
                    <strong>Ação</strong>
                  </p>
                </td>
                <td style="text-align: center; border: 1px solid black;">
                  <p>
                    <strong>Resultado esperado</strong>
                  </p>
                </td>
                <td style="text-align: center; border: 1px solid black;">
                  <p>
                    <strong>Resultado alcançado?</strong>
                  </p>
                </td>
              </tr>
              <tr>
                <td style="border: 1px solid black;" >
                  <p>Rodar a aplicação através do botão "!!!" no Studio</p>
                </td>
                <td style="border: 1px solid black;">
                  <p>Aplicação atualizada</p>
                </td>
                <td style="text-align: center; border: 1px solid black;">
                  <xsl:call-template name="YesNoCheckboxes" />
                </td>
              </tr>
              <tr>
                <td style="border: 1px solid black;" >
                  <p>Clicar no botão "Carregar Cenário Inicial"</p>
                </td>
                <td style="border: 1px solid black;" >
                  <p>Todos os equipamentos disponíveis para o Self-healing.</p>
                </td>
                <td style="text-align: center; border: 1px solid black;">
                  <xsl:call-template name="YesNoCheckboxes" />
                </td>
              </tr>
              <xsl:for-each select="./PreconditionSteps/InputStep">
                <tr>
                  <td style="border: 1px solid black;">
                    <p>
                      Executar '<xsl:value-of select="./Command"/>' com a ação '<xsl:value-of select="./Action"/>' no equipamento <xsl:value-of select="./Equipment"/>
                    </p>
                  </td>
                  <td style="border: 1px solid black;">
                    <p>[digite o resultado esperado]</p>
                  </td>
                  <td style="text-align: center; border: 1px solid black;">
                    <xsl:call-template name="YesNoCheckboxes" />
                  </td>
                </tr>
              </xsl:for-each>
              <tr>
                <td style="border: 1px solid black;">
                  <p>Selecionar cenário "Carga Leve" e aguardar 5 segundos</p>
                </td>
                <td style="border: 1px solid black;" >
                  <p>Carga leve carregada</p>
                </td>
                <td style="text-align: center; border: 1px solid black;">
                  <xsl:call-template name="YesNoCheckboxes" />
                </td>
              </tr>
              <tr style="border: 1px solid black;">
                <td style="border: 1px solid black;" >
                  <p>
                    Executar o comando de "Simular Restoration" em <xsl:value-of select="./TriggerEquip" />.
                  </p>
                </td>
                <td style="border: 1px solid black;" >
                  <p>Início da execução do Self-healing.</p>
                </td>
                <td style="text-align: center; border: 1px solid black;">
                  <xsl:call-template name="YesNoCheckboxes" />
                </td>
              </tr>
            </tbody>
          </table>
          <xsl:if test="./StatusCode = 1">
            <h3>Manobra esperada pelo Self-healing:</h3>
            <table style="text-align: center; border: 1px solid black;">
              <tbody>
                <tr>
                  <td style="text-align: center; border: 1px solid black;">
                    <p>
                      <strong>Ação a ser executada</strong>
                    </p>
                  </td>
                  <td style="text-align: center; border: 1px solid black;">
                    <p>
                      <strong>Resultado alcançado?</strong>
                    </p>
                  </td>
                </tr>
                <xsl:for-each select="./ExpectedResults/OutputStep">
                  <tr>
                    <td style="text-align: center; border: 1px solid black;">
                      <p>
                        '<xsl:value-of select="./CommandType"/>:&#160;<xsl:value-of select="./CommandUnit"/>' em <xsl:value-of select="./Equipment"/>
                      </p>
                    </td>
                    <td style="text-align: center; border: 1px solid black;">
                      <xsl:call-template name="YesNoCheckboxes" />
                    </td>
                  </tr>
                </xsl:for-each>
              </tbody>
            </table>
          </xsl:if>
          <xsl:if test="./StatusCode = -1">
            <h3>Mensagem de erro a ser retornada pelo Self-healing:</h3>
            <p style="color:rgb(255, 0, 0);">
              <i>
                <xsl:value-of select="./ResultCode/@desc"/>
              </i>
            </p>
            <p> Retornou?</p>
            <xsl:call-template name="YesNoCheckboxes" />
            <br/>
          </xsl:if>
          <p>
            <!--<textarea id="testComment" cols="40" name="testComment" rows="4">Deixe um comentário sobre o teste (opcional)</textarea> -->
            <h3>Comentários adicionais sobre o teste:</h3>
            <div class='textarea' contenteditable='true' style='border: 1px solid black;'>

            </div>
          </p>
        </xsl:for-each>

      </body>
    </html>

  </xsl:template>

  <xsl:template name="YesNoCheckboxes">
    <xsl:element name="input">
      <xsl:attribute name="type">checkbox</xsl:attribute>
      <xsl:attribute name="id">yes</xsl:attribute>
      <xsl:attribute name="name">yes</xsl:attribute>
      <xsl:attribute name="value">Sim</xsl:attribute>
      <xsl:attribute name="style">float: left; line-height: 1.6em; height: 1.6em; padding: 0; margin: 0px 2px; *overflow: hidden;</xsl:attribute>
    </xsl:element>
    <label style="float: left;" for="yes">Sim</label>
    <xsl:element name="input">
      <xsl:attribute name="type">checkbox</xsl:attribute>
      <xsl:attribute name="id">no</xsl:attribute>
      <xsl:attribute name="name">no</xsl:attribute>
      <xsl:attribute name="value">Não</xsl:attribute>
      <xsl:attribute name="style">float: left; line-height: 1.6em; height: 1.6em; padding: 0; margin: 0px 2px; *overflow: hidden;</xsl:attribute>
    </xsl:element>
    <label style="float: left;" for="no">Não</label>
  </xsl:template>

  <xsl:template name="EquipClassMeaning">
    <xsl:param name ="EquipClass"/>
    <xsl:choose>
      <xsl:when test="$EquipClass = 'PowerRecloser'">Religador</xsl:when>
      <xsl:when test="$EquipClass = 'PowerBreaker'">Disjuntor</xsl:when>
      <xsl:when test="$EquipClass = 'PowerSwitch'">Chave</xsl:when>
      <xsl:otherwise>Equipamento</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>


