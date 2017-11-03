<#include "common.ftl"/>

<#macro renderPiracyKind defaultName format='long' lang='en'>
    <#assign result=defaultName!''/>
    <#if params.piracy_kind?has_content>
        <#assign desc=descForLang(params.piracy_kind, lang)!>
        <#if desc?? && format == 'long'>
            <#assign result=desc.longValue/>
        <#elseif desc??>
            <#assign result=desc.value/>
        </#if>
    </#if>
    ${result}
</#macro>


<@defaultSubjectFieldTemplates/>

<field-template field="part.getDesc('en').details" format="html">
    <p>
        Vessel <#if !(params.piracy_confirmed!false)>possibly</#if>
        <@renderPiracyKind defaultName="attacked" format="long" lang="en"/>
        <@renderPositionList geomParam=part lang="en"/>
        <#if params.piracy_date??><@renderDate date=params.piracy_date lang="en" tz="UTC"/></#if>.
    </p>
    <p>Vessels are advised to keep clear of this position and to exercise extreme caution.</p>
    <p>
        Report to MDAT-GOG,<br>
        Phone: +33 2 98 22 88 88<br>
        e-mail: watchkeepers@mdat-gog.org<br>
    </p>
</field-template>

<#if promulgate('navtex')>
    <field-template field="message.promulgation('navtex').text" update="append">
        <@line format="navtex">
            VESSEL <#if !(params.piracy_confirmed!false)>POSSIBLY</#if>
            <@renderPiracyKind defaultName="attacked" format="long" lang="en"/>
            <@renderPositionList geomParam=part format="navtex" lang="en"/>
            <#if params.piracy_date??><@renderDate date=params.piracy_date lang="en" format="navtex"/></#if>.
        </@line>
        <@line format="navtex">
            VESSELS ADVISED TO KEEP CLEAR AND EXERCISE EXTREME CAUTION.
        </@line>
<@line format="navtex">REPORT TO MDAT-GOG,</@line>
<@line format="navtex">PHONE: +33 2 98 22 88 88</@line>
<@line format="navtex">E-MAIL: WATCHKEEPERS@MDAT-GOG.ORG</@line>
    </field-template>
</#if>

<#if promulgate('safetynet')>
    <field-template field="message.promulgation('safetynet').text" update="append">
        <@line format="navtex">
            VESSEL <#if !(params.piracy_confirmed!false)>POSSIBLY</#if>
            <@renderPiracyKind defaultName="attacked" format="long" lang="en"/>
            IN <@renderPositionList geomParam=part format="navtex" lang="en"/>
            <#if params.piracy_date??>AT <@renderDate date=params.piracy_date lang="en" format="navtex"/></#if>.
        </@line>
        <@line format="navtex">
            VESSELS ARE ADVISED TO KEEP CLEAR OF THIS POSITION AND TO EXERCISE EXTREME CAUTION.
        </@line>
<@line format="navtex">REPORT TO MDAT-GOG,</@line>
<@line format="navtex">PHONE: +33 2 98 22 88 88</@line>
<@line format="navtex">E-MAIL: WATCHKEEPERS@MDAT-GOG.ORG</@line>
    </field-template>
</#if>
