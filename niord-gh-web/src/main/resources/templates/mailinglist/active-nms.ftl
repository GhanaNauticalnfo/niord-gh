

<#include "../messages/message-support.ftl"/>

<#assign areaHeadings = true />
<#assign mapThumbnails = false />
<#assign nmMessages = [] />
<#assign miscMessages = [] />
<#list messages as msg>
    <#if msg.type != 'MISCELLANEOUS_NOTICE'>
        <#assign nmMessages = nmMessages + [msg] />
    <#elseif msg.type == 'MISCELLANEOUS_NOTICE'>
        <#assign miscMessages = miscMessages + [msg] />
    </#if>
</#list>

<html>
<head>
    <link rel="stylesheet" type="text/css" href="/css/templates/common.css">
    <link rel="stylesheet" type="text/css" href="/css/templates/mail.css">
</head>
<body>

<h1>Active Notices to Mariners</h1>

<#-- Permanent and T&P messages -->
<#if nmMessages?has_content>
    <@renderMessageList messages=nmMessages areaHeadings=areaHeadings prefix="nm"/>
</#if>

<#-- Add page break -->
<#if nmMessages?has_content && miscMessages?has_content>
<div class="page-break"></div>
</#if>

<#-- Misc messages -->
<#if miscMessages?has_content>
    <table width="100%">
        <tr>
            <td class="table-header"><h4 id="misc">Announcements, etc.</h4></td>
        </tr>
    </table>
    <@renderMessageList messages=miscMessages areaHeadings=false/>
</#if>

</body>
</html>

