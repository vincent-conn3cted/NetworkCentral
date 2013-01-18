<%@ page import="au.com.toyota.nc.common.model.hibernate.DocumentType" %>
<%@ page import="au.com.toyota.nc.webapp.stripes.dealerLocations.BaseManageDealerLocationActionBean" %>
<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<stripes:layout-definition>
    <nc:pageName pageName="${pageName}"/>
    <div id="dealerLocationDetailsHeader">
    	
    	 <script type="text/javascript" src="${pageContext.request.contextPath}/js/hasFormChanged.js"></script>
    	 
        <div id="dealerLocationName" class="pageContent_main_header">
            <h1>${actionBean.location.dealer.generalInfo.dealerName}/${actionBean.location.contact.streetAddress.suburb}/${actionBean.location.type}/${actionBean.location.dealer.generalInfo.dealerCode}</h1>
        </div>


        <div id="dealerLocationToolbar">
                <%--
                    Dont display the 'Save' button if user is only viewing
                --%>
                <c:if test="${actionBean.showAsReadOnly eq false}">
                    <stripes:layout-render name="/WEB-INF/jsp/nc/location/_changeStatusDialog.jsp"/>
                    <span id="saveButtonSection" style="margin:1em;">
                        <stripes:submit name="<%=BaseManageDealerLocationActionBean.EVENT_SAVE%>" class="btn btn_save" id="saveLocationButton"><fmt:message key="label.save"/></stripes:submit>
                    </span>
                </c:if>

                <nc:ifAccessAllowed name="location.status">
                    <span id="statusSection" style="margin:1em;">
                        ${actionBean.location.status}
                    </span>
                </nc:ifAccessAllowed>
        </div>
        <div class="clear">&nbsp;</div>
    </div>
</stripes:layout-definition>
