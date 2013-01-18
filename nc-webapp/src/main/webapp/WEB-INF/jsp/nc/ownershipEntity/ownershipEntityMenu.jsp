<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<jsp:useBean id="tm" class="java.util.Date" />
<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">
    <stripes:layout-component name="html-head">
        <link rel="stylesheet" media="screen" type="text/css" href="${pageContext.request.contextPath}/css/wib/entity/nc-entity.css"/>
    </stripes:layout-component>
    
    <stripes:layout-component name="page-contents">
        <!-- for selenium tests: ownership entity menu page -->
         <div class="pageContent_main_header">
            <h1>Manage Entities</h1>
         </div>

        <div id="searchOwnershipEntityPage" class="pageContent_wrapper">
            <nc:pageName pageName="MaintainOperatingEntity"/>
            <div class="mainContent_wrapper">
            <nc:ifAccessAllowed name="operatingentity.search">
                <div id="searchFormLayoutSection">
                    <stripes:form id="ownershipEntitySearchForm" beanclass="au.com.toyota.nc.webapp.stripes.ownershipEntity.OwnershipEntitySearchActionBean" method="post">
                         <c:import url="/WEB-INF/jsp/messages.jsp"/>

                         <table class="form">
                             <tbody>
                                <stripes:hidden name="search" value="search"/>
                                <stripes:hidden name="returnTo" />
                                <stripes:hidden name="searchReq.type" />
                                <stripes:hidden name="searchReq.status" />
                                    <tr class="rowHighLight">
                                        <th><stripes:label for="searchReq.name"/></th>
                                        <td><stripes:text id="searchReq.name" name="searchReq.name" /></td>
                                    </tr>
                                    <tr class="rowHighLight">
                                        <th><stripes:label for="searchReq.type"/></th>
                                        <td>
                                            <stripes:select name="searchReq.type" disabled="${actionBean.searchReq.type!=null}">
                                                <stripes:option label="all" value=""/>
                                                <stripes:options-enumeration enum="au.com.toyota.nc.common.model.hibernate.OwnerEntityType"/>
                                            </stripes:select>
                                        </td>
                                    </tr>
                                    <tr class="rowHighLight">
                                        <th><stripes:label for="searchReq.status"/></th>
                                        <td>
                                            <stripes:select name="searchReq.status" disabled="${actionBean.searchReq.status!=null}">
                                                <stripes:option label="all" value=""/>
                                                <stripes:options-enumeration enum="au.com.toyota.nc.common.model.hibernate.Status"/>
                                            </stripes:select>
                                        </td>
                                    </tr>
                             </tbody>
                        </table>

                        
                        <div class="formActionButtons">
                            <stripes:submit name="search" value="doSearch" id="searchButton" class="btn btn_search">Search</stripes:submit>
                            <stripes:reset name="reset" id="resetForm" class="btn btn_reset">Reset</stripes:reset>
                            <div class="clear"></div>
                        </div>
                    </stripes:form>
                </div>
            </nc:ifAccessAllowed>

            <nc:ifAccessAllowed name="operatingentity.menu">
                <div id="maintenanceSection" class="<c:if test="${actionBean.returnTo!=null}">hide</c:if>" >
                    <ul class="menu_simple_vertical">
                        <li>
                                <stripes:link id="addCompanyLink" beanclass="au.com.toyota.nc.webapp.stripes.ownershipEntity.ManageCorporateEntityActionBean" event="addCompany">
                                    <fmt:message  key="menu.add.company"/>
                                </stripes:link>
                        </li>
                        <li>
                                <stripes:link id="addIndividualLink" beanclass="au.com.toyota.nc.webapp.stripes.ownershipEntity.ManageIndividualEntityActionBean" event="addIndividual">
                                    <fmt:message  key="menu.add.individual"/>
                                </stripes:link>
                        </li>
                        <li>
                            <stripes:link id="addIndividualLink" beanclass="au.com.toyota.nc.webapp.stripes.ownershipEntity.ManageShareholdingActionBean" event="displayShareholding">
                                <fmt:message  key="menu.add.shareholdings"/>
                            </stripes:link>
                        </li>
                        <li>
                            <stripes:link id="addEditShareTypes" beanclass="au.com.toyota.nc.webapp.stripes.ownershipEntity.ManageShareTypeActionBean" event="displayShareType">
                                <fmt:message  key="menu.add.sharetype"/>
                            </stripes:link>
                        </li>
                    </ul>
                </div>
            </nc:ifAccessAllowed>
            <div class="clear"></div>
            </div>
            <div class="clear"></div>
        </div>
    </stripes:layout-component>

</stripes:layout-render>