

<#include "../messages/message-support.ftl"/>

<#assign mapThumbnails = false />
<#assign tpMessages = [] />
<#list messages as msg>
    <#if msg.type == 'PRELIMINARY_NOTICE' || msg.type == 'TEMPORARY_NOTICE'>
        <#assign tpMessages = tpMessages + [msg] />
    </#if>
</#list>

<html>
<head>
    <link rel="stylesheet" type="text/css" href="/css/templates/common.css">
    <link rel="stylesheet" type="text/css" href="/css/templates/mail.css">

    <style type="text/css" media="all">
        td.table-item {
            vertical-align: top;
            width: 100%;
            padding: 5px 0;
        }
    </style>
</head>
<body>

<h1>Active Notices to Mariners T&P</h1>

<#-- T&P messages -->
<#if tpMessages?has_content>

    <table class="message-table">

        <#-- Define column widths (fixed table layout) -->
        <tr>
            <td style="width: 2.5cm"></td>
            <td style="width: 0.5cm"></td>
            <td width="*"></td>
        </tr>

        <#list tpMessages as msg>
            <tr>
                <td class="table-item">
                    <#if msg.shortId?has_content>
                        ${msg.shortId}
                    </#if>
                </td>
                <td class="table-item">
                    <#if msg.type == 'PRELIMINARY_NOTICE'>
                        (P)
                    <#elseif msg.type == 'TEMPORARY_NOTICE'>
                        (T)
                    </#if>
                </td>
                <td class="table-item">
                    <#if msg.descs?has_content && msg.descs[0].title?has_content>
                        ${msg.descs[0].title}
                    </#if>
                </td>
            </tr>
        </#list>
    </table>

</#if>

</body>
</html>

