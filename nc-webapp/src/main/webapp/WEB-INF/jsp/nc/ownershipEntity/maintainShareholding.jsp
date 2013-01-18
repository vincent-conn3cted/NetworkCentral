<%@ page import="au.com.toyota.nc.webapp.stripes.ownershipEntity.ManageShareholdingActionBean" %>
<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<jsp:useBean id="tm" class="java.util.Date" />
<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">
    <stripes:layout-component name="html-head">
        <link rel="stylesheet" media="screen" type="text/css" href="${pageContext.request.contextPath}/css/wib/entity/nc-entity.css"/>
        
    </stripes:layout-component>

    <stripes:layout-component name="page-contents">
    <div id="pageTitleSection" class="pageContent_main_header">
            <h1><fmt:message  key="oe.menu.header"/></h1>
     </div>

    <div id="mainShareholdingSection" class="pageContent_wrapper">
        <c:import url="/WEB-INF/jsp/messages.jsp"/>
        <nc:pageName pageName="MaintainOperatingEntity"/>
        <nc:ifAccessAllowed name="operatingentity.shareholding">

        <div class="mainContent_wrapper">
            <ul class="column-style-fieldset threeCols">
                <li>
                    <fieldset id="companyOwnedSection" >
                        <legend><fmt:message  key="oe.menu.header.shareholding.owned"/></legend>
                            <c:if test="${actionBean.ownedCompany!=null}">
                                <div class="entityDetails">
                                    <p>
                                        <b>${actionBean.ownedCompany.name}</b><br/><br/>
                                        <span><fmt:message key="label.abn"/> : ${actionBean.ownedCompany.abn}</span><br/>
                                        <span><fmt:message key="label.acn"/> : ${actionBean.ownedCompany.acn}</span><br/>
                                        <c:if test="${actionBean.ownedCompany.contact.streetAddress ne null}">
                                            <br/>
                                            ${actionBean.ownedCompany.contact.streetAddress.fullStreet}<br/>
                                            ${actionBean.ownedCompany.contact.streetAddress.suburb}
                                            ${actionBean.ownedCompany.contact.streetAddress.postCode}
                                        </c:if>
                                    </p>
                                </div>
                            </c:if>

                            <div class="addEntityOption">
                                <ul class="menu_simple_vertical">
                                    <li>
                                        <stripes:link id="searchCompany" beanclass="au.com.toyota.nc.webapp.stripes.ownershipEntity.ManageShareholdingActionBean" event="searchCompany">
                                            <fmt:message  key="maintain.shareholding.search.company"/>
                                        </stripes:link>
                                    </li>
                                </ul>
                                <div class="clear"></div>
                            </div>
                            <div class="addEntityOption" style="padding-left:20px;">Or</div>
                            <div class="addEntityOption">
                                <ul class="menu_simple_vertical">
                                <c:if test="${actionBean.ownedCompany==null}">
                                    <li>
                                        <stripes:link id="addCompany" beanclass="au.com.toyota.nc.webapp.stripes.ownershipEntity.ManageShareholdingActionBean" event="addCompany">
                                            <fmt:message  key="maintain.shareholding.add.company"/>
                                        </stripes:link>
                                    </li>
                                </c:if>
                                    <li>
                                        <stripes:link id="addShareType" beanclass="au.com.toyota.nc.webapp.stripes.ownershipEntity.ManageShareholdingActionBean" event="addShareType">
                                            <fmt:message  key="maintain.shareholding.add.sharetype"/>
                                        </stripes:link>
                                    </li>
                                </ul>
                                <div class="clear"></div>
                            </div>
                        <div class="clear"></div>
                    </fieldset>
                </li>

                <li>
                    <fieldset id="shareholdingSection" >
                        <legend><fmt:message  key="oe.menu.header.shareholding.details"/></legend>
                        <stripes:form id="ownershipEntitySearchForm" beanclass="au.com.toyota.nc.webapp.stripes.ownershipEntity.ManageShareholdingActionBean"
                               method="post">
                                <stripes:hidden name="abstractShareholding.shareHoldingId" />


                                <stripes:label for="abstractShareholding.numShares"/><stripes:text name="abstractShareholding.numShares" disabled="${!(actionBean.ownedCompany.name!=null && (actionBean.ownerCompany.name!=null ||  actionBean.ownerIndividual.name!=null))}"/><br/>

                                <stripes:label for="abstractShareholding.shareType.shareTypeId"/>
                                <stripes:select name="abstractShareholding.shareType.shareTypeId" disabled="${!(actionBean.ownedCompany.name!=null && (actionBean.ownerCompany.name!=null ||  actionBean.ownerIndividual.name!=null))}">
                                    <stripes:option label="Select Share Type" value="" />
                                    <stripes:options-collection collection="${actionBean.ownedCompany.shareTypes}" label="shareName" value="shareTypeId"/>
                                </stripes:select><br/>

                                <stripes:label name="abstractShareholding.staffId" />
                                <c:if test="${actionBean.ownerIndividual!=null}">
                                    <c:if test="${actionBean.ownerIndividual.dealerStaff!=null}">
                                        <span class="formValue">${actionBean.ownerIndividual.dealerStaff.fullName}</span>
                                    </c:if>
                                </c:if>
                                <br/>

                                <stripes:label for="abstractShareholding.dealerPrinciple"/> <stripes:checkbox name="abstractShareholding.dealerPrinciple" disabled="${actionBean.dealerPrincipleDisabled}"/><br/>
                            <br/>
                            <c:set var="disableSaveButton" value="${!(actionBean.ownedCompany.name!=null && (actionBean.ownerCompany.name!=null ||  actionBean.ownerIndividual.name!=null))}"/>
                            <c:if test="${!disableSaveButton}">
                                <stripes:submit name="saveShareholding" value="saveShareholding" class="btn btn_save"/><br/>
                            </c:if>

            <%--
                                <%
                                   ManageShareholdingActionBean actionBean =(ManageShareholdingActionBean)pageContext.getAttribute("actionBean");

                                    if (actionBean!=null && actionBean.getReturnTo()!=null){

                                        out.append(actionBean.getReturnTo());
                                    }
                                %>
                                isDealer principle : ${actionBean.dealerPrincipleEnabled}
            --%>
                        </stripes:form>
                    </fieldset>
                </li>
                <li>
                    <fieldset id="shareholderSection" >
                        <legend><fmt:message  key="oe.menu.header.shareholding.owner"/></legend>
                            <c:if test="${actionBean.ownerCompany!=null}">
                                 <div class="entityDetails">
                                     <p>
                                        <b>${actionBean.ownerCompany.name}</b><br/><br/>
                                        <span><fmt:message key="label.abn"/> : ${actionBean.ownerCompany.abn}</span><br/>
                                        <span><fmt:message key="label.acn"/> : ${actionBean.ownerCompany.acn}</span><br/>
                                        <c:if test="${actionBean.ownerCompany.contact.streetAddress ne null}">
                                            <br/>
                                            ${actionBean.ownerCompany.contact.streetAddress.fullStreet}<br/>
                                            ${actionBean.ownerCompany.contact.streetAddress.suburb}
                                            ${actionBean.ownerCompany.contact.streetAddress.postCode}
                                         </c:if>
                                    </p>
                                </div>
                            </c:if>

                            <c:if test="${actionBean.ownerIndividual!=null}">
                                <center>
                                    <span>${actionBean.ownerIndividual.name}</span><br/><br/>
                                    ${actionBean.ownerIndividual.contact.streetAddress.fullStreet}<br/>
                                    ${actionBean.ownerIndividual.contact.streetAddress.suburb}
                                    ${actionBean.ownerIndividual.contact.streetAddress.postCode}
                                </center>
                            </c:if>

                            <div class="addEntityOption">
                                <ul class="menu_simple_vertical">
                                    <li>
                                        <stripes:link id="searchOwnerEntity" beanclass="au.com.toyota.nc.webapp.stripes.ownershipEntity.ManageShareholdingActionBean" event="searchOwnerEntity">
                                            <fmt:message  key="maintain.shareholding.search.owner"/>
                                        </stripes:link>
                                    </li>
                                </ul>
                                <div class="clear"></div>
                            </div>
                            <c:if test="${actionBean.ownerCompany==null && actionBean.ownerIndividual==null}">
                                <div class="addEntityOption" style="padding-left:20px;">Or</div>
                                <div class="addEntityOption">
                                        <ul class="menu_simple_vertical">
                                            <li>
                                                <stripes:link id="addCompanyOwner" beanclass="au.com.toyota.nc.webapp.stripes.ownershipEntity.ManageShareholdingActionBean" event="addCompanyOwner">
                                                    <fmt:message  key="maintain.shareholding.add.companyowner"/>
                                                </stripes:link>
                                            </li>
                                            <li>
                                                <stripes:link id="addIndividualOwner" beanclass="au.com.toyota.nc.webapp.stripes.ownershipEntity.ManageShareholdingActionBean" event="addIndividualOwner">
                                                    <fmt:message  key="maintain.shareholding.add.individualowner"/>
                                                </stripes:link>
                                            </li>
                                        </ul>
                                    <div class="clear"></div>
                                </div>
                            </c:if>
                        </fieldset>
                </li>
                </ul>
                <div class="clear"></div>
            </div>
        </nc:ifAccessAllowed>
    </div>

    </stripes:layout-component>

</stripes:layout-render>