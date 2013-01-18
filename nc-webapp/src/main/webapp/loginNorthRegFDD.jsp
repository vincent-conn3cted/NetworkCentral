<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">
    <stripes:layout-component name="page-contents">
        <stripes:layout-render name="/WEB-INF/jsp/nc/_loginForm.jsp" username="nc.NorthRegFDD" password="partnering"/>
    </stripes:layout-component>

    <stripes:layout-component name="init-event-handling">
        <script type="text/javascript">
                function yuiLoadComplete(){
                    YAHOO.util.Event.onDOMReady(function(){
                        $('#loginForm').submit();
                    });
                }
        </script>
    </stripes:layout-component>
</stripes:layout-render>