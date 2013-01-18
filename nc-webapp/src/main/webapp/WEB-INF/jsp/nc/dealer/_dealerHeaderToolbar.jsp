<%@ page import="au.com.toyota.nc.common.dealers.impl.SapDealer" %>
<%@ page import="au.com.toyota.nc.common.model.hibernate.DocumentType" %>
<%@ page import="au.com.toyota.nc.webapp.dataproxy.SAPCodeVerifier" %>
<%@ page import="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageDealerLocationActionBean" %>
<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<stripes:layout-definition>
      <nc:pageName pageName="${pageName}"/>
      <div id="dealerLocationDetailsHeader">
    	
    	 <script type="text/javascript" src="${pageContext.request.contextPath}/js/hasFormChanged.js"></script>
    	     
         <div id="dealerLocationName" class="pageContent_main_header">
            <h1>${actionBean.dealer.generalInfo.dealerName}</h1>
        </div>

        <div id="dealerLocationToolbar">
                    <%--
                        Dont display the 'Save' button if user is only viewing, or display it if creating a new dealer
                    --%>
                    <c:if test="${actionBean.showAsReadOnly eq false || actionBean.showAsCreatePage eq true}">
                        <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/_changeStatusDialog.jsp"/>
                        <span id="saveButtonSection" style="margin:1em;">
                                <c:if test="${submitMethod != null}">
                                    <stripes:submit id="saveButton" name="${submitMethod}" class="btn btn_save"><fmt:message key="label.save"/></stripes:submit>
                               </c:if>
                                <c:if test="${submitMethod == null}">
                                    <stripes:submit id="saveButton" name="<%=ManageDealerLocationActionBean.EVENT_SAVE%>" class="btn btn_save"><fmt:message key="label.save"/></stripes:submit>
                                </c:if>
                        </span>
                    </c:if>

                     <nc:ifAccessAllowed name="dealer.generalInfo.status">
                        <span id="statusSection" style="margin:1em;">
                                ${actionBean.dealer.generalInfo.status}
                        </span>
                    </nc:ifAccessAllowed>
        </div>
        <div class="clear">&nbsp;</div>

    </div>

</stripes:layout-definition>
