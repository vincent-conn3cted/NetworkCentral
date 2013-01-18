<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">
    <stripes:layout-component name="html-head">
        <link rel="stylesheet" media="screen" type="text/css" href="${pageContext.request.contextPath}/css/wib/entity/nc-entity.css"/>
    </stripes:layout-component>

    <stripes:layout-component name="page-contents">
        <nc:pageName pageName="ViewOperatingEntity"/>
        <nc:ifAccessAllowed name="operatingentity.individual">
            <!-- for selenium tests: view individual page -->
            <div id="viewEntityPageHeader">
                <div id="pageTitleSection" class="pageContent_main_header">
                    <h1><fmt:message  key="view.entity.individual"/></h1>
                </div>
                 <div id="entityStatusSection">
                        <span class="right">
                            ${actionBean.individual.status}
                        </span>
                 </div>
                <div class="clear"></div>
            </div>


            <div id="viewEntityPage" class="pageContent_wrapper">
                <div class="mainContent_wrapper">
                <c:import url="/WEB-INF/jsp/messages.jsp"/>
                    <stripes:form id="saveCorporateEntityForm"
                            beanclass="au.com.toyota.nc.webapp.stripes.ownershipEntity.ViewIndividualEntityActionBean"
                            method="post">
                        <fieldset>
                            <stripes:hidden name="individual.id" />
                            <stripes:hidden name="returnTo" />
                            <span class="left" id="corporateEntityForm-name">${actionBean.individual.name}</span>
                        </fieldset>
                        <div class="clear"></div>

                        <fieldset>
                            <legend><fmt:message  key="view.entity.individual.section.address.street"/></legend>
                            <nc:addressDecorator contact="${actionBean.individual.contact}" addressType="street"/>
                        </fieldset>
                        <div class="clear"></div>

                        <fieldset>
                            <legend><fmt:message  key="view.entity.individual.section.address.postal"/></legend>
                            <nc:addressDecorator contact="${actionBean.individual.contact}" addressType="postal"/>
                        </fieldset>
                        <div class="clear"></div>

                        <fieldset>
                            <legend><fmt:message  key="view.entity.individual.section.communication"/></legend>
                            <stripes:label name="individual.contact.email"/><span class="formValue">${actionBean.individual.contact.email}</span><br/>
                            <stripes:label name="individual.contact.phone"/><span class="formValue">${actionBean.individual.contact.phone}</span><br/>
                            <stripes:label name="individual.contact.fax"/><span class="formValue">${actionBean.individual.contact.fax}</span><br/>
                        </fieldset>
                        <div class="clear"></div>

                        <fieldset>
                            <legend><fmt:message  key="view.entity.individual.section.staffref"/></legend>
                            <stripes:label name="individual.dealerStaff"/><span class="formValue">${actionBean.individual.dealerStaff.personId} - ${actionBean.individual.dealerStaff.fullName} </span><br/>
                        </fieldset>
                        <div class="clear"></div>


                        <fieldset>
                            <legend><fmt:message  key="view.entity.individual.section.note"/></legend>
                            <span class="formValue">${actionBean.individual.note}</span>
                        </fieldset>
                        <div class="clear"></div>


                        <nc:ifWriteAccessAllowed name="operatingentity.search.result.edit">
                            <ul class="table-item-control-nav">
                                <li>
                                <stripes:link id="editIndividualLink" beanclass="au.com.toyota.nc.webapp.stripes.ownershipEntity.ManageIndividualEntityActionBean" event="editIndividual">
                                    <stripes:param name="individual.id" value="${actionBean.individual.id}"/>Edit</stripes:link>
                                </li>
                            </ul>
                            <div class="clear"></div>                            
                        </nc:ifWriteAccessAllowed>

                        <table id="shareholdings">
                            <caption><fmt:message key="view.entity.individual.shareholdings"/> ${actionBean.individual.name}</caption>
                            <thead>
                                <tr>
                                    <th class="entityName">Company Name</th>
                                    <th class="shareTypeName">Share Type</th>
                                    <th class="noOfShares">Share Owned</th>
                                    <th class="shareTotal">Total for this type</th>
                                    <th class="percentageOwned">% Owned</th>
                                    <th class="staffDP">DP</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${actionBean.individual.shareholdings}" var="shareholding" varStatus="shareholdingIdx">
                                    <c:if test="${shareholding.status!='Inactive'}">
                                        <tr>
                                            <td class="entityName">
                                                <stripes:hidden name="individual.shareholdings[[${shareholdingIdx.index}].shareHoldingId" value="${shareholding.shareHoldingId}"/>
                                                <stripes:link id="viewCompanyLink" beanclass="au.com.toyota.nc.webapp.stripes.ownershipEntity.ViewCorporateEntityActionBean" event="viewCompany">
                                                    <stripes:param name="company.id" value="${shareholding.company.id}"/>${shareholding.company.name}</stripes:link>
                                            </td>
                                            <td class="shareTypeName"><nc:text name="individual.shareholdings[${shareholdingIdx.index}].shareType.shareName" value="${shareholding.shareType.shareName}" readonly="readonly"/></td>
                                            <td class="noOfShares"><nc:text name="individual.shareholdings[${shareholdingIdx.index}].numShares" value="${shareholding.numShares}" /></td>
                                            <td class="shareTotal"><nc:text name="individual.shareholdings[${shareholdingIdx.index}].shareType.shareTotal" value="${shareholding.shareType.shareTotal}" readonly="readonly"/></td>
                                            <td class="percentageOwned"><fmt:formatNumber value="${shareholding.percentage}" type="percent" pattern="#0.00%"/></td>
                                            <td class="staffDP">
                                                <div id="isDPImage">
                                                    <c:if test="${shareholding.dealerPrinciple}">
                                                        <span class="checkedImage checkboxImage"></span>
                                                    </c:if>
                                                    <c:if test="${!shareholding.dealerPrinciple}">
                                                        <span class="unCheckedImage checkboxImage"></span>
                                                    </c:if>
                                                </div>
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
                        <c:if test="${!actionBean.footerDisplayable}">
                        	<c:choose>
                        		<c:when test="${actionBean.individual.contact != null}">
						            <div align="center">
						            	<c:out value="Last Modified by ${actionBean.lastMaintainedUserNameFromLDAP} on ${actionBean.individual.contact.maintenanceDateAsString}"  />
						            </div>
                        		</c:when>
                        		<c:otherwise>
                        			<div align="center">
						            	<c:out value="Last Modified by ${actionBean.lastMaintainedUserNameFromLDAP} on ${actionBean.individual.maintenanceDateAsString}"  />
						            </div>
                        		</c:otherwise>
                        	</c:choose> 
						</c:if>
                </stripes:form>
                <div class="clear"></div>
                </div>
                <div class="clear"></div>
            </div>
        </nc:ifAccessAllowed>

    </stripes:layout-component>

    <stripes:layout-component name="page-footer">
        <stripes:layout-render name="/WEB-INF/jsp/layout/footer.jsp"/>
    </stripes:layout-component>

</stripes:layout-render>