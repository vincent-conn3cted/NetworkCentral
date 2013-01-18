<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">
    <stripes:layout-component name="html-head">

    </stripes:layout-component>


    <stripes:layout-component name="page-contents">
        <!-- for selenium tests: 500 page-->

        <div class="pageContent_main_header">
            <h1>Error</h1>
        </div>
        <div class="pageContent_wrapper">
            <div class="mainContent_wrapper">
                <p>
                    <jsp:useBean id="now" class="java.util.Date"/>
                    <fmt:formatDate value="${now}" type="BOTH" pattern="dd/MM/yyyy HH:mm:ss" var="formattedNow" scope="page"/>
                    <strong><c:out value="${formattedNow}"/></strong>
                </p>
                <p>
                    Network Central has encountered a problem. We apologise for any inconvenience this may have caused.
                    Application Error message:
                </p>
                <p>
                    <c:out value="${error.message}"/>
                </p>
                <p>
                    Please contact the tSupport team by phone or email using the details below, and inform them of this issue.
                </p>
                <p>
                    In the meantime if you wish to continue using Network Central please using one of the menu options at the top of this page to navigate to your next activity.
                </p>
                <ul>
                    <li>
                        By phone: <fmt:message key='support.phone' />
                    </li>
                    <li>
                        By email: <fmt:message key='support.email' />
                    </li>
                </ul>
            </div>
        </div>
    </stripes:layout-component>
</stripes:layout-render>
