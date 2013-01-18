<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">
    <stripes:layout-component name="html-head">
        <link rel="stylesheet" media="screen" type="text/css" href="${pageContext.request.contextPath}/css/wib/entity/nc-entity.css"/>
    </stripes:layout-component>

    <stripes:layout-component name="page-contents">

        <!-- for selenium tests: maintain share type page -->        

        <div class="pageContent_main_header">
            <h1><fmt:message  key="oe.menu.header.shareType"/></h1>
        </div>
        
        <div id="manageShareTypePage" class="pageContent_wrapper">
            <c:import url="/WEB-INF/jsp/messages.jsp"/>

            <nc:pageName pageName="MaintainOperatingEntity"/>
            <nc:ifAccessAllowed name="operatingentity.sharetype">
                <div class="mainContent_wrapper">
                    <ul class="column-style-fieldset twoCols">
                            <li class="leftCol">
                                <div class="subContent_wrapper">
                                    <h3 class="subContent_title"><fmt:message key="maintain.sharetype.search" /></h3>
                                    <div class="subContent_content">
                                               <stripes:form id="ownershipEntitySearchForm" beanclass="au.com.toyota.nc.webapp.stripes.ownershipEntity.ManageShareTypeActionBean"
                                                          method="post">
                                                    <div id="sharetypeSearchSection">
                                                        <fieldset id="searchEntitySection">
                                                        <stripes:hidden name="returnTo" />
                                                        <stripes:label for="company.id"/>
                                                        <stripes:select id="companySelectList" name="company.id">
                                                            <stripes:options-collection collection="${actionBean.companies}" label="name" value="id"/>
                                                        </stripes:select>
                                                        <stripes:submit name="searchShareType" class="btn btn_search" value="searchShareType"/> <br/>
                                                        </fieldset>
                                                     </div>
                                                    <div id="resultTable">
                                                        <table id="results">
                                                            <thead>
                                                                <tr>
                                                                    <th  class="shareTypeName">Share Type</th>
                                                                    <th  class="shareTotal">Total Shares</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <c:forEach items="${actionBean.company.shareTypes}" var="sharetype" varStatus="index">
                                                                    <c:if test="${sharetype.status== 'Active'}">
                                                                        <tr>
                                                                            <td><stripes:text name="company.shareTypes[${index.index}].shareName"  value="${sharetype.shareName}" class="shareTypeName"/></td>
                                                                            <td>
                                                                                <stripes:text name="company.shareTypes[${index.index}].shareTotal" value="${sharetype.shareTotal}" class="shareTotal" maxlength="15"/>
                                                                                <stripes:hidden name="company.shareTypes[${index.index}].shareTypeId" value="${sharetype.shareTypeId}"/>
                                                                            </td>
                                                                        </tr>
                                                                    </c:if>
                                                                    <c:set var="newIndex" value="${index.index + 1}" scope="page"/>
                                                                </c:forEach>
                                                            </tbody>
                                                        </table>
                                                        <div class="formActionButtons">
                                                            <stripes:submit name="saveShareTypes" value="saveShareTypes" class="btn btn_save"/><br/>
                                                            <div class="clear"></div>
                                                        </div>
                                                     </div>
                                               </stripes:form>
                                        </div>
                                    </div>
                                </li>
                                <li class="rightCol">
                                    <div class="subContent_wrapper">
                                        <h3 class="subContent_title"><fmt:message key="maintain.sharetype.add" /></h3>
                                        <div class="subContent_content">
                                       <stripes:form id="ownershipEntitySearchForm" beanclass="au.com.toyota.nc.webapp.stripes.ownershipEntity.ManageShareTypeActionBean"
                                                  method="post">
                                                <fieldset id="addShareTypeSection">
                                                    <stripes:hidden name="returnTo" />

                                                    <stripes:label for="company.id"/>
                                                    <stripes:select id="addShareTypeSectionCompanySelectList" name="company.id">
                                                        <%--<stripes:option value=""><fmt:message key="label.selectone"/></stripes:option>--%>
                                                        <stripes:options-collection collection="${actionBean.companies}" label="name" value="id"/>
                                                    </stripes:select><br/>
                
                                                    <stripes:label for="shareType.shareName"/><stripes:text name="shareType.shareName" maxlength="30"/><br/>
                                                    <stripes:label for="shareType.shareTotal"/><stripes:text name="shareType.shareTotal" maxlength="15" /><br/>
                                                </fieldset>
                                                <div class="formActionButtons">
                                                    <stripes:submit name="addShareType" class="btn btn_add" value="addShareType"/>
                                                    <div class="clear"></div>
                                               </div>
                                            <br/>
                                       </stripes:form>
                                        </div>
                                    </div>
                                </li>
                </ul>
                <div class="clear"></div>
            </div>
            </nc:ifAccessAllowed>
    </stripes:layout-component>

</stripes:layout-render>