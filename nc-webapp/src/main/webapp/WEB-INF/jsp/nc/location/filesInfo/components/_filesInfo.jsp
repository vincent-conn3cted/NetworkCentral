<%@ page import="au.com.toyota.nc.common.model.hibernate.DocumentType" %>
<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<stripes:layout-definition>
    <nc:pageName pageName="${pageName}"/>
    <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>


    <nc:ifAccessAllowed name="location.documents">
        <!--- ==== Start  Files stuffs ============================================== -->
        <fieldset id="filesInfo-generalSection" class="tableEncapsulatingFieldSet">
            <nc:ifPageViewMode mode="Edit">
                <nc:ifAccessAllowed name="location.documents.add">
                        <a href="" id="addFileLink" class="addItemToTableLink"> <fmt:message key="label.addItemToTable"/> </a><br/>
                </nc:ifAccessAllowed>
            </nc:ifPageViewMode>


            <table id="fileTable">
                <thead>
                    <tr>
                        <th class="documentNameColumn"><fmt:message key="document.documentName"/></th>
                        <th class="documentTypeColumn"><fmt:message key="document.documentType"/></th>
                        <th class="documentURLColumn"><fmt:message key="document.url"/></th>
                        <th class="documentCreatedDateColumn"><fmt:message key="document.creationDate"/></th>
                        <nc:ifAccessAllowed name="location.documents[].publicFlag">
                            <th class="documentPublicFlagColumn"><fmt:message key="document.publicFlag"/> </th>
                        </nc:ifAccessAllowed>
                        <nc:ifPageViewMode mode="Edit">
                            <th class="controlColumn"></th>
                        </nc:ifPageViewMode>
                    </tr>
                </thead>
                <tbody>
                        <%--
                            A document can only be accessed by user, if that user is NationalAdmin, or if the public flag is set to true.
                        --%>
                    <c:set var="isNationalAdministratorUser" value="false"/>
                    <isd:ifUserInRole role="NationalAdministrator">
                        <c:set var="isNationalAdministratorUser" value="true"/>
                    </isd:ifUserInRole>

                    <c:forEach items="${actionBean.location.documents}" var="document" varStatus="docStatus">
                        <c:if test="${(document.publicFlag eq true) || isNationalAdministratorUser}">
                            <tr>
                                <td>
                                    <c:if test="${document.fileName ne null}">
                                        <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageLocationActionBean" event="retrieveDocument">
                                            <stripes:param name="document.documentId" value="${document.documentId}"/>
                                            ${document.documentName}
                                        </stripes:link>
                                    </c:if>
                                    <c:if test="${document.fileName eq null}">
                                        ${document.documentName}
                                    </c:if>
                                </td>
                                <td>
                                    <span class="formValue">${document.documentType}</span>
                                </td>
                                <td>
                                    <c:if test="${document.url ne null}">
                                        <a href="${document.url}" target="_blank">
                                                ${document.url}
                                        </a>
                                    </c:if>
                                    <c:if test="${document.url eq null}">
                                        <fmt:message key="label.notavailable"/>
                                    </c:if>
                                </td>
                                <td>
                                    <span class="formValue">${document.uploadTime}</span>
                                </td>
                                <nc:ifAccessAllowed name="location.documents[${docStatus.index}].publicFlag">
                                    <td>
                                        <nc:checkbox name="location.documents[${docStatus.index}].publicFlag"/>
                                    </td>
                                </nc:ifAccessAllowed>
                                <nc:ifPageViewMode mode="Edit">
                                    <td class="controlColumn">
                                        <nc:ifAccessAllowed name="location.documents.delete">
                                            <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageLocationActionBean"
                                                          event="removeDocument">
                                                <stripes:param name="document.documentId" value="${document.documentId}"/>
                                                <stripes:param name="location.locationId" value="${actionBean.location.locationId}"/>
                                                <fmt:message key="label.removeItemInTable"/>
                                            </stripes:link>
                                        </nc:ifAccessAllowed>
                                    </td>
                                </nc:ifPageViewMode>
                            </tr>
                        </c:if>
                    </c:forEach>
                </tbody>
            </table>
        </fieldset>

        <!--- ===== End Files stuffs ========================================== -->
    </nc:ifAccessAllowed>

</stripes:layout-definition>
