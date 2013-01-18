<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<%--

--%>
<stripes:layout-definition>
     YAHOO.util.Event.addListener("${htmlId}","click",
        function(event){
            <c:if test="${extraMethod ne null}">
                ${extraMethod}();
            </c:if>
            YAHOO.au.com.toyota.widget.${dialogName}.show();
            YAHOO.util.Event.preventDefault(event);
        },
        YAHOO.au.com.toyota.widget.${dialogName},true
    );
</stripes:layout-definition>

