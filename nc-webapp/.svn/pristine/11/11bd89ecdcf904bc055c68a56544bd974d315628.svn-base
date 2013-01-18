<%@ page import="au.com.toyota.nc.common.model.hibernate.DocumentType" %>
<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">
    <stripes:layout-component name="html-head">
         <link rel="stylesheet" media="screen" type="text/css"
                 href="${pageContext.request.contextPath}/css/wib/dealerLocation/nc-dealership.css"/>
    </stripes:layout-component>

    <stripes:layout-component name="page-contents">
        <!-- for selenium tests: location file page -->
        <stripes:layout-render name="/WEB-INF/jsp/layout/_calendarFiles.jsp"/>


        <div id="dealerLocationDetailsPage" class="pageContent_wrapper">
            <stripes:form beanclass="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageLocationActionBean">
                <%-- ==========================================
                    Secure page stuffs
                =============================================--%>
                <c:set var="pageName" value="EditLocation-${actionBean.location.type}-Files" scope="page"/>

                  <nc:pageName pageName="${pageName}"/>
                    <stripes:layout-render name="/WEB-INF/jsp/nc/location/_locationCommonForm.jsp" pageName="${pageName}" showLocationTabs="true"/>
                    <div id="locationDetails-filesSection" class="mainContent_wrapper">
                        <stripes:layout-render name="/WEB-INF/jsp/nc/location/filesInfo/components/_filesInfo.jsp" pageName="${pageName}"/>
                        <div class="clear"></div>
                    </div>
            </stripes:form>
            <div class="clear"></div>
        </div>


         <nc:ifWriteAccessAllowed name="location.documents">
        <%-- ==================== Start Add Document Dialog Box==================== --%>
        <div id="addDocumentDialog" class="dialog">
                <div class="hd">Add Document</div>
                <div class="bd">
                    <stripes:form id="fileUploadForm" beanclass="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageLocationActionBean" enctype="multipart/form-data" method="post">
                        <stripes:hidden name="location.locationId"/>
                        <stripes:hidden name="lastTabShown"/>
                        <fieldset>
                        <stripes:label for="document.documentType"/>
                        <stripes:select id="document.documentType" name="document.documentType">
                            <stripes:options-enumeration enum="au.com.toyota.nc.common.model.hibernate.DocumentType"/>
                        </stripes:select><br/>

                        <stripes:label for="document.documentName"/>
                        <stripes:text id="document.documentName" name="document.documentName"/><br/>

                        <stripes:label for="document.publicFlag"/>
                        <stripes:checkbox id="document.publicFlag" name="document.publicFlag"/><br/>

                        <stripes:label for="document.url"/>
                        <stripes:text id="document.url" name="document.url"/><br/>

                        <stripes:label for="document.file"/>
                        <stripes:file id="document.file" name="file"/><br/>

                        <stripes:hidden name="upload" value="upload"/>
                        </fieldset>
                    </stripes:form>
                </div>
            </div>
        <%-- ==================== End Add Document Dialog Box==================== --%>
    </nc:ifWriteAccessAllowed>

    </stripes:layout-component>

    <stripes:layout-component name="init-event-handling">
         <nc:ifWriteAccessAllowed name="location.documents">
            <script type="text/javascript">
                function initializeFileDialog() {  <%-- function name is generated --%>
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

                     $("#document\\.documentType").change(function(){
                                    showAndHideDocumentTypeFormField();
                    });
                }

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
            </script>
        </nc:ifWriteAccessAllowed>

        <script type="text/javascript">
               function yuiLoadComplete() {
                    YAHOO.util.Event.onDOMReady(function() {
                        <nc:ifWriteAccessAllowed name="location.documents">
                                initializeFileDialog();
                        </nc:ifWriteAccessAllowed>
                    });
                }
        </script>
    </stripes:layout-component>

</stripes:layout-render>
