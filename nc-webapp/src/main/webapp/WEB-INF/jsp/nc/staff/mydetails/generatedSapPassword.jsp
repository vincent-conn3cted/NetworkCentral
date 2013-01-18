<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">
    <stripes:layout-component name="html-head">
          <link rel="stylesheet" media="screen" type="text/css" href="${pageContext.request.contextPath}/css/wib/staff/nc-staff.css"/>
    </stripes:layout-component>
    <stripes:layout-component name="page-contents">
        <!-- for selenium tests: generated sap password page -->
        <div class="pageContent_main_header">
            <h1>SAP Password Generated Successfully</h1>
        </div>
        <div id="generatedSapPasswordPage" class="pageContent_wrapper">
            <div class="mainContent_wrapper">
                <stripes:form beanclass="au.com.toyota.nc.webapp.stripes.staff.mydetails.MyDetailsActionBean">
                    <div>
                        Password generated successfully. Your new SAP password is:
                    </div>
                    <div id="generatedSapPasswordPage-generatedSapPassword">
                            ${actionBean.generatedSapPassword}
                    </div>
                </stripes:form>
                <div>
                    <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.staff.mydetails.MyDetailsActionBean"
                                  id="my-details-page-link">Back to My Details page</stripes:link>
                </div>                
            </div>
        </div>
    </stripes:layout-component>
</stripes:layout-render>
