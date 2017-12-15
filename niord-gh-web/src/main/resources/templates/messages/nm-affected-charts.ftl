
<#-- ***************************************  -->
<#-- Returns the sorted chart numbers         -->
<#-- ***************************************  -->
<#function chartNumbersSorted msgs>

    <#assign charts = {} />
    <#list msgs as msg>
        <#if msg.charts?has_content>
            <#list msg.charts as chart>
                <#assign chartNumber = chart.chartNumber />
                <#if !(charts[chartNumber]??)>
                    <#assign charts = charts + { chartNumber : [] } />
                </#if>
            </#list>
        </#if>
    </#list>

    <#assign chartNumbersNumeric = [] />
    <#list charts?keys as chartNumber>
        <#assign chartNumbersNumeric = chartNumbersNumeric + [ chartNumber?number ] />
    </#list>
    <#assign chartNumbersNumeric = chartNumbersNumeric?sort />

    <#assign chartNumbers = [] />
    <#list chartNumbersNumeric as chartNumber>
        <#assign chartNumbers = chartNumbers + [ chartNumber?c ] />
    </#list>
    <#return chartNumbers />
</#function>

<#-- ***************************************  -->
<#-- Returns the messages for a given chart   -->
<#-- ***************************************  -->
<#function messagesForChartNumber msgs chartNumber>

    <#assign chartMessages = [] />
    <#list msgs as msg>
        <#if msg.charts?has_content>
            <#list msg.charts as chart>
                <#if chartNumber == chart.chartNumber>
                    <#assign chartMessages = chartMessages + [ msg ] />
                </#if>
            </#list>
        </#if>
    </#list>
    <#return chartMessages />
</#function>

<#assign chartNumbers = chartNumbersSorted(messages) />

<div style="margin-top: 1cm; width: 100%; text-align: center; color: gray; font-size: 16px; margin-bottom: 10px">
    Affected Charts
</div>

<table style="border: 1px solid gray">
    <tr class="table-header-row">
        <td style="width: 2cm; padding: 5px;"><strong>Chart No</strong></td>
        <td style="width: 8cm; padding: 5px;"><strong>Notice No</strong></td>
    </tr>
    <#list chartNumbers as chartNumber>
        <tr>
            <td style="padding: 5px; border-top: 0.05em solid #eee">${chartNumber}</td>
            <td style="padding: 5px; border-top: 0.05em solid #eee">
                <#assign chartMessages = messagesForChartNumber(messages, chartNumber) />
                <#list chartMessages as msg>
                    ${msg.shortId}<#if !(msg?is_last)>, </#if>
                </#list>
            </td>
        </tr>
    </#list>
</table>
