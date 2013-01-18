<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<!-- for selenium tests: dealerchangeover cancel box -->

<h2><fmt:message key="dealerChangeover.cancel.header.cancel"/></h2>

<stripes:form beanclass="au.com.toyota.nc.webapp.stripes.dealerchangeover.ProcessDealerChangeoverActionBean">
     <ul id="cancelDealerChangeoverOptionsList" class="menu_simple_vertical">
         <li>
            <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.dealerchangeover.ProcessDealerChangeoverActionBean"
                          event="cancelAndPurge"
                          id="cancelDealerChangeoverDialog-cancelAndPurge">
                <stripes:param name="dealerChangeover.dealerChangeoverId" value="${actionBean.dealerChangeover.dealerChangeoverId}"/>
                <fmt:message key="dealerChangeover.cancel.message.purge" />
            </stripes:link>
        </li>
        <li>
            <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.dealerchangeover.ProcessDealerChangeoverActionBean"
                          event="cancelAndArchive"
                          id="cancelDealerChangeoverDialog-cancelAndArchive">
                <stripes:param name="dealerChangeover.dealerChangeoverId" value="${actionBean.dealerChangeover.dealerChangeoverId}"/>
                <fmt:message key="dealerChangeover.cancel.message.retain" />
            </stripes:link>
         </li>
   </ul>
</stripes:form>


