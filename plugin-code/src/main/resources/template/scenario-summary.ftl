<#--
Copyright 2018 trivago N.V.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
-->

<#import "macros/page.ftl"as page>
<#import "macros/scenario.ftl" as scenario>
<#import "macros/common.ftl" as common>
<#import "macros/navigation.ftl" as navigation>

<#if (tagFilter??)>
    <#assign base = "./../..">
    <#assign headline = "Scenarios Tagged With <i>${tagFilter.name}</i>">
    <#assign links = ["feature_summary", "tag_summary", "step_summary", "scenario_sequence", "scenario_summary"]>
<#elseif (featureFilter??)>
    <#assign base = "./../..">
    <#assign headline = "Scenarios in Feature<br><i>${featureFilter.name}</i>">
    <#assign links = ["feature_summary", "tag_summary", "step_summary", "scenario_sequence", "scenario_summary"]>
<#elseif (stepFilter??)>
    <#assign base = "./../..">
    <#assign headline = "Scenarios using Step<br><i>${stepFilter.returnNameWithArgumentPlaceholders()}</i>">
    <#assign links = ["feature_summary", "tag_summary", "step_summary", "scenario_sequence", "scenario_summary"]>
<#elseif (scenarioSequence??)>
    <#assign base = "./..">
    <#assign headline = "Scenario Sequence">
    <#assign links = ["feature_summary", "tag_summary", "step_summary", "scenario_summary"]>
<#else>
    <#assign base = ".">
    <#assign headline = "All Scenarios">
    <#assign links = ["feature_summary", "tag_summary", "step_summary", "scenario_sequence"]>
</#if>

<@page.page
base=base
links=links
headline=headline
subheadline=""
preheadline=""
preheadlineLink="">

    <#if hasCustomParameters()>
        <div class="row">
            <@page.card width="12" title="" subtitle="" classes="customParameters">
                <table class="table table-fit">
                    <tbody>
                    <#list customParameters as customParameter>
                        <tr>
                            <td class="text-left text-nowrap"><strong>${customParameter.key}:</strong></td>
                            <td class="text-left wrap">
                                <#if customParameter.url>
                                    <a href="${customParameter.value}" style="word-break: break-all;"
                                       target="_blank">${customParameter.value}</a>
                                <#else>
                                    ${customParameter.value}
                                </#if>
                            </td>
                        </tr>
                    </#list>
                    </tbody>
                </table>
            </@page.card>
        </div>
    </#if>

    <div class="row">
        <@page.card width="8" title="Scenario Result Chart" subtitle="" classes="">
            <@page.graph />
        </@page.card>
        <@page.card width="4" title="Scenario Summary" subtitle="" classes="">
            <ul class="list-group list-group-flush">
                <li class="list-group-item" data-cluecumber-item="scenario-summary">
                    ${totalNumberOfScenarios} Scenario(s):<br>
                    ${totalNumberOfPassedScenarios} <@common.status status="passed"/>
                    ${totalNumberOfFailedScenarios} <@common.status status="failed"/>
                    ${totalNumberOfSkippedScenarios} <@common.status status="skipped"/>
                </li>

                <#assign startDateTimeString = returnStartDateTimeString()>
                <#if startDateTimeString?has_content>
                    <li class="list-group-item" data-cluecumber-item="total-start">
                        Started on:<br>${startDateTimeString}</li>
                </#if>

                <#assign endDateTimeString = returnEndDateTimeString()>
                <#if endDateTimeString?has_content>
                    <li class="list-group-item" data-cluecumber-item="total-end">
                        Ended on:<br>${endDateTimeString}</li>
                </#if>

                <li class="list-group-item" data-cluecumber-item="total-runtime">
                    Test Runtime:<br>${totalDurationString}
                </li>
            </ul>
        </@page.card>
    </div>

    <#if (scenarioSequence??)>
        <@scenario.table status="all"/>
    <#else>
        <@scenario.table status="failed"/>
        <@scenario.table status="skipped"/>
        <@scenario.table status="passed"/>
    </#if>
</@page.page>