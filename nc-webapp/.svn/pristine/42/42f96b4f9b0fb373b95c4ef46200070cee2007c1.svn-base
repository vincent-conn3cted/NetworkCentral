<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">
    <stripes:layout-component name="html-head">
        <link rel="stylesheet" media="screen" type="text/css"
                href="${pageContext.request.contextPath}/css/wib/bulkImport/nc-bulkImport.css"/>
    </stripes:layout-component>

    <stripes:layout-component name="page-contents">

        <div class="pageContent_main_header">
            <h1>Bulk Upload Dealership Users</h1>
        </div>

        <div id="searchDealerPage" class="pageContent_wrapper">
            <div class="mainContent_wrapper">
                <c:import url="/WEB-INF/jsp/messages.jsp"/>

                <stripes:form beanclass="au.com.toyota.nc.webapp.stripes.bulkimport.BulkImportActionBean">
                    <label for="file-to-upload-input">File Name (.CSV)</label>
                    <stripes:file name="usersFile" id="file-to-upload-input"/>

                    <stripes:checkbox name="loadForEdms" id="load-for-edms-checkbox" checked="checked"/>
                    <label for="load-for-edms-checkbox">Load for eDMS</label>

                    <br/>

                    <stripes:submit name="bulkUpload" id="upload-button" class="btn" value="Upload"/>

                    <br/>

                    Results:<br/>
                    <div id="results-container">
                        <ul>
                        <c:forEach items="${actionBean.responses}" var="error">
                            <li><c:out value="${error.fullMessage}"/></li>
                        </c:forEach>
                        </ul>
                    </div>
                </stripes:form>

            </div>
        </div>

    </stripes:layout-component>

</stripes:layout-render>
