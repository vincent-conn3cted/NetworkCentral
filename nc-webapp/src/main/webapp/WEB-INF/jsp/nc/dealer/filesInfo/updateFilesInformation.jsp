<%@ page import="au.com.toyota.nc.common.model.hibernate.AbstractDocument" %>
<%@ page import="au.com.toyota.nc.common.model.hibernate.DocumentType" %>
<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">

<stripes:layout-component name="html-head">
      <link rel="stylesheet" media="screen" type="text/css"
                 href="${pageContext.request.contextPath}/css/wib/dealerLocation/nc-dealership.css"/>
</stripes:layout-component>

<stripes:layout-component name="page-contents">
    <!-- for selenium tests: dealer file page -->
    <stripes:layout-render name="/WEB-INF/jsp/layout/_calendarFiles.jsp"/>

    <div id="dealerLocationDetailsPage" class="pageContent_wrapper">

        <stripes:form beanclass="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageDealerLocationActionBean">
            <%-- ==========================================
                    Secure page stuffs
         =============================================--%>
            <c:set var="pageName" value="EditDealership-Files" scope="page"/>
            <nc:pageName pageName="${pageName}"/>
            <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>
            <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/_dealerCommonForm.jsp" pageName="${pageName}"/>


            <nc:ifAccessAllowed name="dealer.documents">
            <div id="dealerDetails-filesSection" class="mainContent_wrapper">
                <ul class="column-style-fieldset oneCol">
                        <li>
                                <fieldset id="filesInfo-generalSection" class="tableEncapsulatingFieldSet">
                                                <nc:ifPageViewMode mode="Edit">
                                                    <nc:ifAccessAllowed name="dealer.documents.add">
                                                            <a href="" id="addFileLink" class="addItemToTableLink"> <fmt:message key="label.addItemToTable"/> </a>
                                                    </nc:ifAccessAllowed>
                                                </nc:ifPageViewMode>

                                                <br/>

                                                <table id="fileTable">
                                                    <thead>
                                                        <tr>
                                                            <th class="documentNameColumn"><fmt:message key="document.documentName"/></th>
                                                            <th class="documentTypeColumn"><fmt:message key="document.documentType"/></th>
                                                            <th class="documentURLColumn"><fmt:message key="document.url"/></th>
                                                            <th class="documentCreatedDateColumn"><fmt:message key="document.creationDate"/></th>
                                                            <nc:ifAccessAllowed name="dealer.documents[].publicFlag">
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

                                                        <c:forEach items="${actionBean.dealer.documents}" var="document" varStatus="docStatus">
                                                            <c:if test="${(document.publicFlag eq true) || isNationalAdministratorUser}">
                                                                    <tr>
                                                                        <td>
                                                                            <c:if test="${document.fileName ne null}">
                                                                                    <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageDealerLocationActionBean" event="retrieveDocument">
                                                                                            <stripes:param name="document.documentId" value="${document.documentId}"/>
                                                                                            ${document.documentName}
                                                                                     </stripes:link>
                                                                            </c:if>
                                                                            <c:if test="${document.fileName eq null}">
                                                                                    ${document.documentName}
                                                                            </c:if>
                                                                        </td>
                                                                        <td>
                                                                            ${document.documentType}
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
                                                                            ${document.uploadTime}
                                                                        </td>
                                                                        <nc:ifAccessAllowed name="dealer.documents[${docStatus.index}].publicFlag">
                                                                            <td>
                                                                                <nc:checkbox name="dealer.documents[${docStatus.index}].publicFlag"/>
                                                                            </td>
                                                                        </nc:ifAccessAllowed>
                                                                        <nc:ifPageViewMode mode="Edit">
                                                                            <td class="controlColumn">
                                                                                <nc:ifAccessAllowed name="dealer.documents.delete">
                                                                                    <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageDealerLocationActionBean"
                                                                                                  event="removeDocument">
                                                                                        <stripes:param name="document.documentId" value="${document.documentId}"/>
                                                                                        <stripes:param name="dealer.dealerId" value="${actionBean.dealer.dealerId}"/>
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
                            </li>
                      </ul>
                      <div class="clear"></div>
                </div>
            </nc:ifAccessAllowed>
        </stripes:form>
    </div>

    <%-- ==================== START DIALOG BOXES ==================== --%>
    <nc:ifWriteAccessAllowed name="dealer.documents">
        <div id="addDocumentDialog" class="dialog">
            <div class="hd">Add Document</div>
            <div class="bd">
                <stripes:form id="fileUploadForm" beanclass="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageDealerLocationActionBean" enctype="multipart/form-data" method="post">
                    <stripes:hidden name="dealer.dealerId"/>
                    <stripes:hidden name="lastTabShown"/>
                    <fieldset>
                        <stripes:label for="document.documentType"/>
                        <stripes:select id="document.documentType" name="document.documentType">
                            <stripes:options-enumeration enum="au.com.toyota.nc.common.model.hibernate.DocumentType"/>
                        </stripes:select><br/>

                        <stripes:label for="document.documentName"/>
                        <stripes:text id="document.documentName" name="document.documentName" maxlength="<%= String.valueOf(AbstractDocument.MAX_DOCUMENT_NAME)%>"/><br/>

                        <stripes:label for="document.publicFlag"/>
                        <stripes:checkbox id="document.publicFlag" name="document.publicFlag"/><br/>

                        <stripes:label for="document.url"/>
                        <stripes:text id="document.url" name="document.url" maxlength="<%= String.valueOf(AbstractDocument.MAX_URL)%>"/><br/>

                        <stripes:label for="document.file"/>
                        <stripes:file id="document.file" name="file"/><br/>

                        <stripes:hidden name="upload" value="upload"/>
                    </fieldset>
                </stripes:form>
            </div>
        </div>
    </nc:ifWriteAccessAllowed>
    <%-- ==================== END DIALOG BOXES ==================== --%>

</stripes:layout-component>

<stripes:layout-component name="init-event-handling">
    <script type="text/javascript">
        <nc:ifWriteAccessAllowed name="dealer.documents">
                    function initializeFileDialog() {
                        var addDocument = function() {
                            $("form#fileUploadForm").submit();
                        };
                        <%-- We dont hide the popup on clicking 'ok' because this popup does the actual submission. If we
                        let the popup to be closed, and user quickly click 'save', we will get HibernateStaleObjectException. Since there were 2 saves
                        with same object id --%>
                        <stripes:layout-render name="/WEB-INF/jsp/layout/_popupDialog.jsp"
                            dialogName="AddDocumentDialog" dialogId="addDocumentDialog" okHandler="addDocument"  hideDialogOnOK="false"/>
                        <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/_attachPopupListener.jsp"
                                htmlId="addFileLink" dialogName="AddDocumentDialog" extraMethod="showAndHideDocumentTypeFormField"/>
                    }
        </nc:ifWriteAccessAllowed>

        /**
        *   Show and hide the form field, depending on the document type.
        * */
        function showAndHideDocumentTypeFormField(){
            var selectedDocumentType=$("#document\\.documentType").val();
            
            if (selectedDocumentType == '<%=DocumentType.URL%>'){
                YAHOO.log("Selecting document type : URL","info");
                $.each(["#document\\.url","label[for=document.url]"],function(){
                    $(""+this).show();
                });
                 $.each(["#document\\.file","label[for=document.file]"],function(){
                    $(""+this).hide();
                });

                // Clear the file
                $("#document\\.file").val("");
            }else if (selectedDocumentType == '<%=DocumentType.FILE%>'){
                YAHOO.log("Selecting document type: FILE","info");
                 $.each(["#document\\.url","label[for=document.url]"],function(){
                    $(""+this).hide();
                });
                 $.each(["#document\\.file","label[for=document.file]"],function(){
                    $(""+this).show();
                });

                //Clear URL
                $("#document\\.url").val("");
            }
        }

        function yuiLoadComplete() {
            YAHOO.util.Event.onDOMReady(function() {
                <nc:ifWriteAccessAllowed name="dealer.documents">
                        initializeFileDialog();
                </nc:ifWriteAccessAllowed>

                $("#document\\.documentType").change(function(){
                      showAndHideDocumentTypeFormField();
                });

            });
        }
    </script>
</stripes:layout-component>

</stripes:layout-render>
