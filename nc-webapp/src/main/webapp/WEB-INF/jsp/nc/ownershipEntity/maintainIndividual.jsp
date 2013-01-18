<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">
    <stripes:layout-component name="html-head">
        <link rel="stylesheet" media="screen" type="text/css" href="${pageContext.request.contextPath}/css/wib/entity/nc-entity.css"/>
    </stripes:layout-component>


    <stripes:layout-component name="page-contents">
         <div id="manageEntityPageHeader">
             <div id="pageTitleSection" class="pageContent_main_header">
                    <h1><fmt:message  key="maintain.entity.individual"/></h1>
             </div>

            <jsp:include page="/WEB-INF/jsp/nc/ownershipEntity/_changeStatusDialog.jsp">
                <jsp:param name="eventName" value="changeStatus"/>
                <jsp:param name="beanclass" value="au.com.toyota.nc.webapp.stripes.ownershipEntity.ManageIndividualEntityActionBean"/>
                <jsp:param name="status" value="${actionBean.individual.status}"/>
                <jsp:param name="idName" value="individual.id"/>
                <jsp:param name="idValue" value="${actionBean.individual.id}"/>
            </jsp:include>
         </div>



        <div id="manageIndividualEntityPage" class="pageContent_wrapper">
            <div class="mainContent_wrapper">
            <c:import url="/WEB-INF/jsp/messages.jsp"/>
            <nc:pageName pageName="MaintainOperatingEntity"/>
            <nc:ifAccessAllowed name="operatingentity.individual">
                        <div id="searchFormLayoutSection">
                        <stripes:form id="saveIndividualEntityForm"
                                beanclass="au.com.toyota.nc.webapp.stripes.ownershipEntity.ManageIndividualEntityActionBean"
                                method="post">


                            <fieldset id="individualDetails">
                                <stripes:hidden name="individual.id"/>
                                <stripes:hidden name="returnTo" />

                                <stripes:label for="individual.title"/>
                                <stripes:select name="individual.title">
                                    <stripes:option value=""><fmt:message key="label.selectone"/></stripes:option>
                                    <stripes:options-enumeration enum="au.com.toyota.nc.common.model.hibernate.Title"/>
                                </stripes:select><br/>
                                <stripes:label for="individual.name"/><stripes:text name="individual.name" maxlength="40"/><br/>
                            </fieldset>
                            <div class="clear"></div>

                            <ul class="column-style-fieldset twoCols">
                                    <li>
                                        <fieldset id="streetAddressDetails">
                                        <legend><fmt:message  key="label.address.street.header"/></legend>
                                        <stripes:label name="label.address1" for="individual.contact.streetAddress.address1"/><stripes:text name="individual.contact.streetAddress.address1" maxlength="35"/><br/>
                                        <stripes:label name="label.address2" for="individual.contact.streetAddress.address2"/><stripes:text name="individual.contact.streetAddress.address2" maxlength="25"/><br/>
                                        <stripes:label name="label.suburb" for="individual.contact.streetAddress.suburb"/><stripes:text name="individual.contact.streetAddress.suburb" maxlength="40"/><br/>
                                        <stripes:label name="label.postCode" for="individual.contact.streetAddress.postCode"/><stripes:text name="individual.contact.streetAddress.postCode" maxlength="4"  /><br/>
                                        <stripes:label name="label.state" for="individual.contact.streetAddress.state"/>
                                        <stripes:select name="individual.contact.streetAddress.state">
                                            <stripes:option value=""><fmt:message key="label.selectone"/></stripes:option>
                                            <stripes:options-enumeration enum="au.com.toyota.nc.common.model.hibernate.State"/>
                                        </stripes:select><br/>
                                        </fieldset>
                                    </li>
                                    <li>
                                        <fieldset id="postalAddressDetails">
                                            <legend><fmt:message  key="label.address.postal.header"/></legend>
                                            <stripes:label name="label.address1" for="individual.contact.postalAddress.address1"/><stripes:text name="individual.contact.postalAddress.address1" maxlength="35"/><br/>
                                            <stripes:label name="label.address2" for="individual.contact.postalAddress.address2"/><stripes:text name="individual.contact.postalAddress.address2" maxlength="25"/><br/>
                                            <stripes:label name="label.suburb" for="individual.contact.postalAddress.suburb"/><stripes:text name="individual.contact.postalAddress.suburb" maxlength="40"/><br/>
                                            <stripes:label name="label.postCode" for="individual.contact.postalAddress.postCode"/><stripes:text name="individual.contact.postalAddress.postCode" maxlength="4"  /><br/>
                                            <stripes:label name="label.state" for="individual.contact.postalAddress.state"/>
                                            <stripes:select name="individual.contact.postalAddress.state">
                                                <stripes:option value=""><fmt:message key="label.selectone"/></stripes:option>
                                                <stripes:options-enumeration enum="au.com.toyota.nc.common.model.hibernate.State"/>
                                            </stripes:select><br/>
                                        </fieldset>
                                    </li>
                            </ul>
                            <div class="clear"></div>

                            
                            <fieldset id="dealerStaffDetails">
                                <legend><fmt:message  key="maintain.entity.individual.section.dealerStaff"/></legend>
                                <c:if test="${actionBean.individual!=null}">
                                    <c:if test="${actionBean.individual.dealerStaff!=null}">
                                        <label><fmt:message key="maintain.entity.individual.section.staffNo"/></label>
                                        <span class="formValue">${actionBean.individual.dealerStaff.personId}</span><br/>

                                        <label><fmt:message key="maintain.entity.individual.section.staffName"/></label>
                                        <span class="formValue">${actionBean.individual.dealerStaff.fullName}</span><br/>
                                        <stripes:link beanclass="au.com.toyota.nc.webapp.stripes.ownershipEntity.ManageIndividualEntityActionBean" event="removeStaffMember">
                                            <stripes:param name="individual.id" value="${actionBean.individual.id}"/>
                                            Remove
                                        </stripes:link>
                                        <stripes:submit id="changeDealerStaffButton" name="linkDealerStaff" value="linkDealerStaff" class="btn btn_changeStaff"><fmt:message  key="maintain.entity.individual.section.changeDealerStaff"/></stripes:submit>
                                    </c:if>
                                    <c:if test="${actionBean.individual.dealerStaff==null}">
                                        <stripes:submit id="addDealerStaffButton" name="linkDealerStaff" value="linkDealerStaff" class="btn btn_linkStaff"><fmt:message  key="maintain.entity.individual.section.addDealerStaff"/></stripes:submit>
                                    </c:if>
                                </c:if>
                                <c:if test="${actionBean.individual==null}">
                                    <stripes:submit id="addDealerStaffButton" name="linkDealerStaff" value="linkDealerStaff" class="btn btn_linkStaff"><fmt:message  key="maintain.entity.individual.section.addDealerStaff"/></stripes:submit>
                                </c:if>
                            </fieldset>
                            <div class="clear"></div>

                            <fieldset id="communicationDetails">
                                <legend><fmt:message  key="maintain.entity.individual.section.communication"/></legend>
                                <stripes:label name="label.email" for="individual.contact.email"/><stripes:text name="individual.contact.email" maxlength="50"/><br/>
                                <stripes:label name="label.phone" for="individual.contact.phone"/><stripes:text name="individual.contact.phone" maxlength="12"   /><br/>
                                <stripes:label name="label.fax" for="individual.contact.fax"/><stripes:text name="individual.contact.fax" maxlength="12" /><br/>
                            </fieldset>
                            <div class="clear"></div>

                            <fieldset id="notesDetails">
                                <legend><fmt:message  key="maintain.entity.individual.section.note"/></legend>
                                <stripes:textarea name="individual.note"/>
                            </fieldset>
                            <div class="clear"></div>

                            <div class="formActionButtons">
      	 	                	<c:choose>
	                            	 <c:when test="${actionBean.individual.id != null}">
							            <jsp:include page="/WEB-INF/jsp/nc/ownershipEntity/_confirmationSaveDialog.jsp">
							                <jsp:param name="saveEvent" value="saveIndividual"/>
							            </jsp:include>
	                            	 </c:when>
	                            	 <c:otherwise>
	                            	 	 <stripes:submit id="saveButton" name="saveIndividual" class="btn btn_save" value="saveIndividual"/>
	                            	 </c:otherwise>
                            	 </c:choose>
                                <div class="clear"></div>
                            </div>
                        </stripes:form>
                    </div>
                    <div class="clear">&nbsp;</div>
                    <c:if test="${!actionBean.footerDisplayable}">
                    	<c:choose>
	                    	<c:when test="${(actionBean.individual.userCn != null) && (actionBean.individual.contact != null)}">  
			                    <div align="center">
			            			<c:out value="Last Modified by ${actionBean.lastMaintainedUserNameFromLDAP} on ${actionBean.individual.contact.maintenanceDateAsString}"  />
			            		</div>
			            	</c:when>
			            	<c:when test="${(actionBean.individual.userCn != null) && (actionBean.individual.contact == null)}">
			            		<div align="center">
			            			<c:out value="Last Modified by ${actionBean.lastMaintainedUserNameFromLDAP} on ${actionBean.individual.maintenanceDateAsString}"  />
			            		</div>
			            	</c:when>
		            	</c:choose>	
					</c:if>	
            </nc:ifAccessAllowed>
            </div>
            <div class="clear">&nbsp;</div>
        </div>
    </stripes:layout-component>

</stripes:layout-render>