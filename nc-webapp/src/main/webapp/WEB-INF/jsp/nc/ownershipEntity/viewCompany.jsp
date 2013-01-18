<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">
    <stripes:layout-component name="html-head">
        <link rel="stylesheet" media="screen" type="text/css" href="${pageContext.request.contextPath}/css/wib/entity/nc-entity.css"/>
    </stripes:layout-component>

    <stripes:layout-component name="page-contents">
        <nc:pageName pageName="ViewOperatingEntity"/>
        <nc:ifAccessAllowed name="operatingentity.company">
        <!-- for selenium tests: view company page -->
            <div id="viewEntityPageHeader">
                <div id="pageTitleSection" class="pageContent_main_header">
                    <h1><fmt:message  key="view.entity.corporate"/></h1>
                </div>
                 <div id="entityStatusSection">
                        <span class="right">
                            ${actionBean.company.status}
                        </span>
                 </div>
                <div class="clear"></div>
            </div>

            <div id="viewEntityPage" class="pageContent_wrapper">
                <div class="mainContent_wrapper">
                    <c:import url="/WEB-INF/jsp/messages.jsp"/>

                    <stripes:form id="saveCorporateEntityForm"
                            beanclass="au.com.toyota.nc.webapp.stripes.ownershipEntity.ViewCorporateEntityActionBean"
                            method="post">
                        <fieldset>
                            <legend><fmt:message  key="view.entity.corporate.section.corporate"/></legend>
                            <stripes:hidden name="company.id" />
                            <stripes:hidden name="returnTo" />
                            <stripes:label for="company.name"/><span class="formValue" id="corporateEntityForm-name">${actionBean.company.name}</span><br/>
                            <stripes:label name="company.acn" /><span class="formValue"> ${actionBean.company.acn}</span><br/>
                            <stripes:label name="company.abn"/><span class="formValue"> ${actionBean.company.abn}</span><br/>
                            <stripes:label name="company.companyStructure"/><span class="formValue"> ${actionBean.company.companyStructure}</span><br/>

                            <stripes:label name="label.multiOwnerFlag" for="company.multiOwnerFlag"/>
                            <span class="formValue"><stripes:checkbox name="company.multiOwnerFlag" disabled="disabled" checked="${company.multiOwnerFlag}"/> </span><br/>

                            <stripes:label name="company.dealers"/>
                            <span class="formValue">
                                <ul class="companys-dealers-items">
                                    <c:forEach items="${actionBean.company.dealers}" var="dealer">
                                        <li>
                                            <c:out value="${dealer.generalInfo.dealerName}"/>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </span><br/>
                            
                        </fieldset>
                        <div class="clear"></div>
                        <fieldset>
                            <legend><fmt:message key="view.entity.corporate.section.address.street"/> </legend>
                             <stripes:label name="view.entity.corporate.section.address.street"/><span class="formValue"><nc:addressDecorator contact="${actionBean.company.contact}" addressType="street"/></span><br/>
                            <stripes:label name="view.entity.corporate.section.address.postal"/><span class="formValue"><nc:addressDecorator contact="${actionBean.company.contact}" addressType="postal"/></span><br/>
                        </fieldset>
                        <div class="clear"></div>
                   
                        <fieldset>
                            <legend><fmt:message  key="view.entity.corporate.section.communication"/></legend>
                            <stripes:label name="company.contact.email"/> <span class="formValue"> ${actionBean.company.contact.email} </span><br/>
                            <stripes:label name="company.contact.website"/> <span class="formValue"> ${actionBean.company.contact.website}</span><br/>
                            <stripes:label name="company.contact.phone"/> <span class="formValue"> ${actionBean.company.contact.phone}</span><br/>
                            <stripes:label name="company.contact.fax"/> <span class="formValue"> ${actionBean.company.contact.fax}</span><br/>
                            <stripes:label name="company.secretary"/> <span class="formValue"> ${actionBean.company.secretary}</span><br/>
                            <stripes:label name="company.director"/> <span class="formValue"> ${actionBean.company.director}</span><br/>
                        </fieldset>
                        <div class="clear"></div>

                        <fieldset>
                                <legend><fmt:message  key="view.entity.corporate.section.note"/></legend>
                                <span class="formValue">${actionBean.company.note}</span>
                        </fieldset>
                        <div class="clear"></div>

                        <nc:ifWriteAccessAllowed name="operatingentity.search.result.edit">
                            <ul class="table-item-control-nav">
                                <li>
                                    <stripes:link id="editCompanyLink" beanclass="au.com.toyota.nc.webapp.stripes.ownershipEntity.ManageCorporateEntityActionBean" event="editCompany">
                                        <stripes:param name="company.id" value="${actionBean.company.id}"/>Edit
                                    </stripes:link>
                                </li>
                            </ul>
                            <div class="clear"></div>
                        </nc:ifWriteAccessAllowed>

                        <table id="shareholders">
                            <caption><fmt:message key="view.entity.corporate.shareholders"/> ${actionBean.company.name}</caption>
                            <thead>
                                <tr>
                                    <th class="entityName">Entity Name</th>
                                    <th class="shareTypeName">Share Type</th>
                                    <th class="noOfShares">Share Owned</th>
                                    <th class="shareTotal">Total for this type</th>
                                    <th class="percentageOwned">% Owned</th>
                                    <th class="staffDP">Staff/DP</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${actionBean.company.shareholders}" var="shareholder" varStatus="shareholderIdx">
                                    <c:if test="${shareholder.status!='Inactive'}">
                                        <tr>
                                            <td class="entityName">
                                                <stripes:hidden name="company.shareholders[${shareholderIdx.index}].shareHoldingId" value="${shareholder.shareHoldingId}"/>
                                                <c:if test="${!shareholder.isCompany}">
                                                    <stripes:link id="viewIndividualLink" beanclass="au.com.toyota.nc.webapp.stripes.ownershipEntity.ViewIndividualEntityActionBean" event="viewIndividual">
                                                        <stripes:param name="individual.id" value="${shareholder.shareholderId}"/>
                                                        ${shareholder.shareHolderName}
                                                    </stripes:link>
                                                </c:if>
                                                <c:if test="${shareholder.isCompany}">
                                                    <stripes:link id="viewCompanyLink" beanclass="au.com.toyota.nc.webapp.stripes.ownershipEntity.ViewCorporateEntityActionBean" event="viewCompany">
                                                        <stripes:param name="company.id" value="${shareholder.shareholderId}"/>
                                                        ${shareholder.shareHolderName}
                                                    </stripes:link>
                                                </c:if>
                                            </td>

                                            <td class="shareTypeName"><nc:text name="company.shareholders[${shareholderIdx.index}].shareType.shareName" value="${shareholder.shareType.shareName}" readonly="readonly"/></td>
                                            <td class="noOfShares"><nc:text name="company.shareholders[${shareholderIdx.index}].numShares" value="${shareholder.numShares}" /></td>
                                            <td class="shareTotal"><nc:text name="company.shareholders[${shareholderIdx.index}].shareType.shareTotal" value="${shareholder.shareType.shareTotal}" readonly="readonly"/></td>
                                            <td class="percentageOwned"> <fmt:formatNumber value="${shareholder.percentage}" type="percent" pattern="#0.00%"/></td>
                                            <td class="staffDP">
                                                <div id="isStaffImage">
                                                    <c:if test="${shareholder.isStaff}"><span class="checkedImage"/></c:if><c:if test="${!shareholder.isStaff}"><span class="unCheckedImage"/></c:if>
                                                </div>
                                                <div id="isDPImage">
                                                    <c:if test="${shareholder.dealerPrinciple}"><span class="checkedImage"/></c:if><c:if test="${!shareholder.dealerPrinciple}"><span class="unCheckedImage"/></c:if>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:if>
                                    <c:set var="newIndex" value="${shareholderIdx.index + 1}" scope="page"/>
                                </c:forEach>
                            </tbody>
                        </table>
                        <div class="clear"></div>

                        <table id="shareholdings">
                            <caption><fmt:message key="view.entity.corporate.shareholdings"/> ${actionBean.company.name}</caption>
                            <thead>
                                <tr>
                                    <th class="entityName">Company Name</th>
                                    <th class="shareTypeName">Share Type</th>
                                    <th class="noOfShares">Share Owned</th>
                                    <th class="shareTotal">Total for this type</th>
                                    <th class="percentageOwned">% Owned</th>
                                    <th class="staffDP">&nbsp;</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${actionBean.company.ownedCompanies}" var="shareholding" varStatus="shareholdingIdx">
                                    <c:if test="${shareholding.status!='Inactive'}">
                                        <tr>
                                            <td class="entityName">
                                                <stripes:hidden name="company.ownedCompanies[${shareholdingIdx.index}].shareHoldingId" value="${shareholding.shareHoldingId}"/>
                                                <stripes:link id="viewCompanyLink" beanclass="au.com.toyota.nc.webapp.stripes.ownershipEntity.ViewCorporateEntityActionBean" event="viewCompany">
                                                    <stripes:param name="company.id" value="${shareholding.company.id}"/>
                                                    ${shareholding.company.name}
                                                </stripes:link>
                                            </td>
                                            <td class="shareTypeName"><nc:text name="company.ownedCompanies[${shareholdingIdx.index}].shareType.shareName" value="${shareholding.shareType.shareName}" readonly="readonly"/></td>
                                            <td class="noOfShares"><nc:text name="company.ownedCompanies[${shareholdingIdx.index}].numShares" value="${shareholding.numShares}" /></td>
                                            <td class="shareTotal"><nc:text name="company.ownedCompanies[${shareholdingIdx.index}].shareType.shareTotal" value="${shareholding.shareType.shareTotal}" readonly="readonly"/></td>
                                            <td class="percentageOwned"><fmt:formatNumber value="${shareholding.percentage}" type="percent" pattern="#0.00%"/></td>
                                            <td class="staffDP">
                                                &nbsp;
                                            </td>
                                        </tr>
                                    </c:if>
                                    <c:set var="newIndex" value="${shareholdingIdx.index + 1}" scope="page"/>
                                </c:forEach>
                            </tbody>
                        </table>
                        <div class="clear"></div>
			            <jsp:include page="/WEB-INF/jsp/nc/ownershipEntity/_confirmationSaveDialog.jsp">
			                <jsp:param name="saveEvent" value="saveShareholding"/>
			            </jsp:include>
                        <div class="clear"></div>
                </stripes:form>
                <div class="clear"></div>
                 <c:if test="${!actionBean.footerDisplayable}">
                 	<c:choose>
                 		<c:when test="${actionBean.company.contact != null}">
				            <div align="center">
				            	<c:out value="Last Modified by ${actionBean.lastMaintainedUserNameFromLDAP} on ${actionBean.company.contact.maintenanceDateAsString}"  />
				            </div>
                 		</c:when>
                 		<c:otherwise>
                 			<div align="center">
				            	<c:out value="Last Modified by ${actionBean.lastMaintainedUserNameFromLDAP} on ${actionBean.company.maintenanceDateAsString}"  />
				            </div>
                 		</c:otherwise> 
		            </c:choose>
				 </c:if>
            </div>
        </nc:ifAccessAllowed>

    </stripes:layout-component>

    <stripes:layout-component name="page-footer">
        <stripes:layout-render name="/WEB-INF/jsp/layout/footer.jsp"/>
    </stripes:layout-component>

</stripes:layout-render>