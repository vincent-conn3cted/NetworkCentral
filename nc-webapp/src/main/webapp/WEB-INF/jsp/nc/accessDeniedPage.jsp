<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">
    <stripes:layout-component name="page-contents">
        <!-- for selenium tests: 404 page-->

        <div class="pageContent_main_header">
            <h1>Page Access Denied</h1>
        </div>
        <div class="pageContent_wrapper">
            <div class="mainContent_wrapper">
                <fmt:message key="message.access.denied"/>
            </div>
        </div>

    </stripes:layout-component>
</stripes:layout-render>