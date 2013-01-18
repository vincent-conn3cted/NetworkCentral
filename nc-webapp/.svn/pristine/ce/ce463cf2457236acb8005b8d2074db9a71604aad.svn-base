<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<stripes:layout-definition>
    <c:forEach items="${networkSummaryTableEntities}" var="networkSummaryTableEntity" varStatus="rowCount">
        <c:set var="rowName" value="${rowNamePrefix}Level${level}Row${rowCount.count}"/>
        <c:set var="rowClassName" value="listNetworkSummaryLevel${level}"/>
        <c:if test="${level > 1}">
            <c:set var="rowClassName" value="listNetworkSummaryLevel${level} listNetworkSummaryRow"/>
        </c:if>
        <tr id="<c:out value="${rowName}"/>" class="<c:out value="${rowClassName}"/>" parent="${rowParent}">
            <td class="listNetworkSummaryRowLabels">
                <c:if test="${networkSummaryTableEntity.hasChildren}">
                    <a class="listNetowrkSummaryExpandRowLink" id="<c:out value="${rowName}"/>ExpandLink" href="#" onclick="return expandRow('<c:out value="${rowName}"/>');">
                        <span>&nbsp;</span>
                    </a>
                    <a style="display:none;" class="listNetowrkSummaryCollapseRowLink" id="<c:out value="${rowName}"/>CollapseLink" href="#" onclick="return collapseRow('<c:out value="${rowName}"/>');">
                        <span>&nbsp;</span>
                    </a>
                </c:if>
                <c:forEach items="${networkSummaryTableEntity.rowLabels}" var="rowLabel" varStatus="rowLabelsIndex">
                    <c:set var="rowClassName" value="listNetworkSummaryRowLabel ${networkSummaryTableEntity.styleName}${rowLabelsIndex.count}"/>
                    <span name="listNetworkSummaryRowLabel" class="<c:out value="${rowClassName}"/>">
                        <c:out value="${rowLabel}"/>&nbsp;
                    </span>
                    <br/>
                </c:forEach>
            </td>
            <td class="networkData">
                <c:out value="${networkSummaryTableEntity.principalAndBranches}"/>
            </td>
            <td class="networkData">
                <c:out value="${networkSummaryTableEntity.dealerships}"/>
            </td>
            <td class="networkData">
                <c:out value="${networkSummaryTableEntity.branches}"/>
            </td>
            <td class="networkData">
                <c:out value="${networkSummaryTableEntity.satelliteServices}"/>
            </td>
            <td class="networkData">
                <c:out value="${networkSummaryTableEntity.otherLocations}"/>
            </td>
            <td class="networkData">
                <c:out value="${networkSummaryTableEntity.metro}"/>
            </td>
            <td class="networkData">
                <c:out value="${networkSummaryTableEntity.rural}"/>
            </td>
        </tr>
        <c:if test="${networkSummaryTableEntity.hasChildren}">
            <stripes:layout-render name="/WEB-INF/jsp/nc/reports/networkSummary/_listRow.jsp"
                                   level="${level + 1}"
                                   rowParent="${rowName}"
                                   rowNamePrefix="${rowName}"
                                   networkSummaryTableEntities="${networkSummaryTableEntity.children}" />
        </c:if>
    </c:forEach>
</stripes:layout-definition>
