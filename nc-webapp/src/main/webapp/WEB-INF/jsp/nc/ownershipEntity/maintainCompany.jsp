<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">

    <stripes:layout-component name="html-head">
        <link rel="stylesheet" media="screen" type="text/css" href="${pageContext.request.contextPath}/css/wib/entity/nc-entity.css"/>
    </stripes:layout-component>

    <stripes:layout-component name="page-contents">
    <!-- for selenium tests: maintain company page -->
        <div id="manageEntityPageHeader">
             <div id="pageTitleSection" class="pageContent_main_header">
                <h1><fmt:message  key="maintain.entity.corporate"/></h1>
             </div>
             
            <jsp:include page="/WEB-INF/jsp/nc/ownershipEntity/_changeStatusDialog.jsp">
                <jsp:param name="eventName" value="changeStatus"/>
                <jsp:param name="beanclass" value="au.com.toyota.nc.webapp.stripes.ownershipEntity.ManageCorporateEntityActionBean"/>
                <jsp:param name="status" value="${actionBean.company.status}"/>
                <jsp:param name="idName" value="company.id"/>
                <jsp:param name="idValue" value="${actionBean.company.id}"/>
            </jsp:include>
            
        </div>


        <nc:pageName pageName="MaintainOperatingEntity"/>
        <nc:ifAccessAllowed name="operatingentity.company">
            <div id="manageCompanyPage" class="pageContent_wrapper">
                <div class="mainContent_wrapper">
                <c:import url="/WEB-INF/jsp/messages.jsp"/>
                        <stripes:form id="saveCorporateEntityForm"
                                beanclass="au.com.toyota.nc.webapp.stripes.ownershipEntity.ManageCorporateEntityActionBean"
                                method="post">


                            <fieldset>
                                <legend><fmt:message  key="maintain.entity.corporate.section.corporate"/></legend>
                                <stripes:hidden name="company.id" />
                                <stripes:hidden name="returnTo" />

                                <stripes:label for="company.name"/><stripes:text id="company.name" name="company.name" size="60"/><br/>
                                <stripes:label name="label.acn" for="company.acn" /><stripes:text id="company.acn" name="company.acn"  size="11"/><br/>
                                <stripes:label name="label.abn" for="company.abn"/><stripes:text id="company.abn" name="company.abn"  size="14"/><br/>

                                <stripes:label name="label.multiOwnerFlag" for="company.multiOwnerFlag"/>
                                <%--<fmt:message key="/ownershipEntity/ManageCorporateEntity.action.company.multiOwnerFlag"/>--%>
                                <stripes:checkbox name="company.multiOwnerFlag" checked="${company.multiOwnerFlag}"/> <br/>

                                <c:if test="${actionBean.companyEntityTypeLocked=='TRUE'}" >
                                <stripes:label for="company.companyStructure"/>
                                <stripes:select name="company.companyStructure" >
                                    <stripes:option value=""><fmt:message key="label.selectone"/></stripes:option>
                                    <stripes:options-enumeration enum="au.com.toyota.nc.common.model.hibernate.CompanyStructure"/>
                                </stripes:select><br/>
                                </c:if>

                                <c:if test="${actionBean.companyEntityTypeLocked=='FALSE'}" >
                                    <stripes:label name="label.companyStructure" for="company.companyStructure"/>
                                    <stripes:select name="company.companyStructure">
                                        <stripes:option value=""><fmt:message key="label.selectone"/></stripes:option>
                                        <stripes:options-enumeration enum="au.com.toyota.nc.common.model.hibernate.CompanyStructure"/>
                                    </stripes:select><br/>
                                </c:if>

                                <stripes:label name="company.dealers"/>
                                <span class="formValue">
                                    <ul class="companys-dealers-items" >
                                        <c:forEach items="${actionBean.company.dealers}" var="dealer">
                                            <li>
                                                <c:out value="${dealer.generalInfo.dealerName}"/>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </span><br/>
                            </fieldset>
                            <!-- street address -->
                            <ul class="column-style-fieldset twoCols">
                                <li>
                                    <fieldset>
                                        <legend><fmt:message  key="label.address.street.header"/></legend>
                                        <stripes:label name="label.address1" for="company.contact.streetAddress.address1"/><stripes:text name="company.contact.streetAddress.address1"  size="35"/><br/>
                                        <stripes:label name="label.address2" for="company.contact.streetAddress.address2"/><stripes:text name="company.contact.streetAddress.address2"  size="25"/><br/>
                                        <stripes:label name="label.suburb" for="company.contact.streetAddress.suburb"/><stripes:text name="company.contact.streetAddress.suburb"  size="40"/><br/>
                                        <stripes:label name="label.state" for="company.contact.streetAddress.state"/>
                                        <stripes:select name="company.contact.streetAddress.state">
                                            <stripes:option value=""><fmt:message key="label.selectone"/></stripes:option>
                                            <stripes:options-enumeration enum="au.com.toyota.nc.common.model.hibernate.State"/>
                                        </stripes:select><br/>
                                        <stripes:label name="label.postCode" for="company.contact.streetAddress.postCode"/><stripes:text name="company.contact.streetAddress.postCode"  size="4" /><br/>
                                    </fieldset>
                                </li>
                                <li>
                                    <!-- postal address -->
                                    <fieldset>
                                            <legend><fmt:message  key="label.address.postal.header"/></legend>
                                            <stripes:label name="label.address1" for="company.contact.postalAddress.address1"/><stripes:text name="company.contact.postalAddress.address1" /><br/>
                                            <stripes:label name="label.address2" for="company.contact.postalAddress.address2"/><stripes:text name="company.contact.postalAddress.address2" /><br/>
                                            <stripes:label name="label.suburb" for="company.contact.postalAddress.suburb"/><stripes:text name="company.contact.postalAddress.suburb" /><br/>
                                            <stripes:label name="label.state" for="company.contact.postalAddress.state"/>
                                            <stripes:select name="company.contact.postalAddress.state">
                                                <stripes:option value=""><fmt:message key="label.selectone"/></stripes:option>
                                                <stripes:options-enumeration enum="au.com.toyota.nc.common.model.hibernate.State"/>
                                            </stripes:select><br/>
                                            <stripes:label name="label.postCode" for="company.contact.postalAddress.postCode"/><stripes:text name="company.contact.postalAddress.postCode"   /><br/>
                                    </fieldset>
                                </li>
                            </ul>
                            <!-- communications -->
                            <fieldset>
                                <legend><fmt:message  key="maintain.entity.corporate.section.communication"/></legend>
                                    <stripes:label name="label.email" for="company.contact.email"/><stripes:text name="company.contact.email"  size="25"/><br/>
                                    <stripes:label name="label.website" for="company.contact.website"/><stripes:text name="company.contact.website"  size="25"/><br/>
                                    <stripes:label name="label.phone" for="company.contact.phone"/><stripes:text name="company.contact.phone"  size="12" /><br/>
                                    <stripes:label name="label.fax" for="company.contact.fax"/><stripes:text name="company.contact.fax"  size="12"/><br/>
                                    <stripes:label for="company.secretary"/><stripes:text name="company.secretary" maxlength="50"/><br/>
                                    <stripes:label for="company.director"/><stripes:text name="company.director" maxlength="400"/><br/>
                            </fieldset>
                            <!-- notes -->
                            <fieldset>
                                <legend><fmt:message  key="maintain.entity.corporate.section.note"/></legend>
                                <stripes:textarea name="company.note" cols="30"/>
                            </fieldset>
                            <div class="clear">&nbsp;</div>

                            <div class="formActionButtons">
      	 	                	<c:choose>
	                            	 <c:when test="${actionBean.company.id != null}">
							            <jsp:include page="/WEB-INF/jsp/nc/ownershipEntity/_confirmationSaveDialog.jsp">
							                <jsp:param name="saveEvent" value="saveCompany"/>
							            </jsp:include>
	                            	 </c:when>
	                            	 <c:otherwise>
	                            	 	 <stripes:submit name="saveCompany" id="saveButton" class="btn btn_save" value="saveCompany">Save</stripes:submit>
	                            	 </c:otherwise>
                            	 </c:choose>
                                 <stripes:reset name="reset" id="resetForm" class="btn btn_reset" value="Reset"/>
                                <div class="clear">&nbsp;</div>
                            </div>

                            <div class="clear">&nbsp;</div>

                            <c:if test="${!actionBean.footerDisplayable}">
								<c:choose>
			                    	<c:when test="${(actionBean.company.userCn != null) && (actionBean.company.contact != null)}">  
					                    <div align="center">
					            			<c:out value="Last Modified by ${actionBean.lastMaintainedUserNameFromLDAP} on ${actionBean.company.contact.maintenanceDateAsString}"  />
					            		</div>
					            	</c:when>
					            	<c:when test="${(actionBean.company.userCn != null) && (actionBean.company.contact == null)}">
					            		<div align="center">
					            			<c:out value="Last Modified by ${actionBean.lastMaintainedUserNameFromLDAP} on ${actionBean.company.maintenanceDateAsString}"  />
					            		</div>
					            	</c:when>
			            		</c:choose>	
							</c:if>
                       </stripes:form>
                    <div class="clear">&nbsp;</div>
                </div>
                <div class="clear">&nbsp;</div>
            </div>
        </nc:ifAccessAllowed>
    </stripes:layout-component>

</stripes:layout-render>