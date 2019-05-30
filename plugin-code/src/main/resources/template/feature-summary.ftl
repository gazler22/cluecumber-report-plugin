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
<#import "macros/common.ftl" as common>
<#import "macros/navigation.ftl" as navigation>

<@page.page
base=".."
links=["tag_summary", "step_summary", "scenario_sequence", "scenario_summary"]
headline="All Features"
subheadline=""
preheadline=""
preheadlineLink="">

    <div class="row">
        <@page.card width="8" title="Feature Summary Result Chart" subtitle="" classes="">
            <@page.graph />
        </@page.card>
        <@page.card width="4" title="Feature Summary" subtitle="" classes="">
            <ul class="list-group list-group-flush">
                <li class="list-group-item">${totalNumberOfFeatures} Feature(s)</li>
                <li class="list-group-item">
                    Feature Scenario(s):<br>
                    ${totalNumberOfPassedFeatures} <@common.status status="passed"/>
                    ${totalNumberOfFailedFeatures} <@common.status status="failed"/>
                    ${totalNumberOfSkippedFeatures} <@common.status status="skipped"/>
                </li>
            </ul>
        </@page.card>
    </div>

    <div class="row">
        <@page.card width="12" title="Available Features" subtitle="" classes="">
            <table id="feature_summary" class="table table-hover renderAsDataTable">
                <thead>
                <tr>
                    <th>Feature</th>
                    <th>Total</th>
                    <th><@common.status status="passed"/></th>
                    <th><@common.status status="failed"/></th>
                    <th><@common.status status="skipped"/></th>
                </tr>
                </thead>
                <tbody>
                <#list featureResultCounts as feature, featureResultCount>
                    <tr>
                        <td class="text-left"><a
                                    href="pages/feature-scenarios/feature_${feature.index?c}.html">${feature.name}</a>
                        </td>
                        <td class="text-right"><strong>${featureResultCount.total}</strong></td>
                        <td class="text-right">${featureResultCount.passed}</td>
                        <td class="text-right">${featureResultCount.failed}</td>
                        <td class="text-right">${featureResultCount.skipped}</td>
                    </tr>
                </#list>
                </tbody>
            </table>
        </@page.card>
    </div>
</@page.page>
