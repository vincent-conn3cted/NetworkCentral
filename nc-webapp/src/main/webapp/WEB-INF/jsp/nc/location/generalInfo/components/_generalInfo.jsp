<%@ page import="au.com.toyota.nc.common.model.hibernate.LocationType" %>
<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<stripes:layout-definition>
    <nc:pageName pageName="${pageName}"/>
    <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>
    

     <!--- ============= Start General Section ----------------------------- -->
    <ul class="column-style-fieldset oneCol">
        <li>
            <fieldset id="generalInfo-generalSection">
                <legend class="legend">General Information</legend>
                <label for="location.type"><fmt:message key="location.type"/></label>
                <span id="location.type"class="formValue">
                    <span id="location.type.value">${actionBean.location.type}</span>
                    <c:if test="${actionBean.location.locationId ne null && !actionBean.location.status.inActive}">
                        <nc:ifWriteAccessAllowed name="location.changeType">
                            <a id="changeLocationTypeLink" href="#" onclick="openChangeLocationTypeDialog(${actionBean.location.locationId});return false;">
                                (<span class="sprite3 tech"></span>change)
                            </a>
                        </nc:ifWriteAccessAllowed>
                    </c:if>
                </span>
                <br/>
                <stripes:hidden name="location.type"/>

                <nc:label name="location.dealer.generalInfo.dealerName" for="location.dealer.generalInfo.dealerName"/>
                <c:choose>
                    <c:when test="${actionBean.showAsReadOnly eq true}">
                        <stripes:link id="openDealerLink" beanclass="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageDealerLocationActionBean"
                                      event="viewDealer">
                            <stripes:param name="dealer.dealerId" value="${actionBean.location.dealer.dealerId}"/>
                            <c:out value="${actionBean.location.dealer.generalInfo.dealerName}"/>
                        </stripes:link>
                    </c:when>
                    <c:otherwise>
                        <stripes:link id="openDealerLink" beanclass="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageDealerLocationActionBean" 
                                      event="editDealer">
                            <stripes:param name="dealer.dealerId" value="${actionBean.location.dealer.dealerId}"/>
                            <c:out value="${actionBean.location.dealer.generalInfo.dealerName}"/>
                        </stripes:link>
                    </c:otherwise>
                </c:choose>
                <br/>

                <nc:label name="location.locationName" for="location.locationName"/>
                <c:set var="PrincipalLocationType" value="<%=LocationType.Principal%>"/>
                <c:set var="restrictEditingLocationName" value="${actionBean.location.type eq PrincipalLocationType}"/>
                <c:set var="BranchLocationType" value="<%=LocationType.Branch%>"/>
                <c:set var="SatelliteLocationType" value="<%=LocationType.Satellite%>"/>                
                <c:set var="isBranchLocation" value="${actionBean.location.type eq BranchLocationType}"/>
                <c:set var="isSatelliteLocation" value="${actionBean.location.type eq SatelliteLocationType}"/>
                <nc:text id="location.locationName" name="location.locationName" readonly="${restrictEditingLocationName}"/>
                <br/>
                
                <c:if test="${!restrictEditingLocationName}">
                    <nc:label name="location.reportingName" for="location.reportingName"/>
                    <nc:text id="location.reportingName" name="location.reportingName"/>
                    <br/>
                </c:if>
                                
                <c:if test="${!restrictEditingLocationName && !isBranchLocation && !isSatelliteLocation}">
                	<!-- // Add by Rick for adding DealerPrefix and Financial Reporting -->	                
	                <nc:label name="location.dealerPrefix" for="location.dealerPrefix.commonValueId"/>
			        <nc:select-active-values selectedObject="${actionBean.location.dealerPrefix}"
			                                 valueAttribute="commonValueId"
			                                 labelAttribute="value"
			                                 id="location.dealerPrefix.commonValueId"
			                                 collections="${actionBean.allDealerPrefix}"
			                                 name="location.dealerPrefix.commonValueId">
			            <option value=""><fmt:message key="label.selectone"/></option>
			        </nc:select-active-values><br/>
			        
			        <!-- // Add by Rick for Dealer Prefix and Financial Reporting enhancement; -->
			        <nc:label name="location.financialsReportingFlag" for="location.financialsReportingFlag"/>
			        <nc:checkbox name="location.financialsReportingFlag"/><br/>
		        </c:if>
            </fieldset>
        </li>
    </ul>
    <div class="clear"></div>
    <ul class="column-style-fieldset oneCol">
        <li>
            <fieldset id="generalInfo-codesSection">
                <legend class="legend">Identification Numbers</legend>
                <nc:label name="code.dealer" for="location.dealer.generalInfo.dealerCode"/>
                <nc:text id="location.dealer.generalInfo.dealerCode" name="location.dealer.generalInfo.dealerCode"/><br/>

                <%-- Support location are not meant to display the following codes in the general tab --%>
                <nc:label name="code.dealer.sap" for="location.dealer.generalInfo.sapDealerCode"/>
                <nc:text id="location.dealer.generalInfo.sapDealerCode" name="location.dealer.generalInfo.sapDealerCode"/><br/>

                <nc:label name="code.partsdealer" for="location.dealer.generalInfo.partsDealerCode"/>
                <nc:text id="location.dealer.generalInfo.partsDealerCode" name="location.dealer.generalInfo.partsDealerCode"/><br/>

                 <nc:label name="code.branch" for="location.branchCode"/>
                 <nc:text id="location.branchCode" name="location.branchCode"/><br/>

                <%--
                    Entering SAP code is allowed only when Dealer's SAP code has been provided
                    Note that Principal Location wont go through this path. The location SAP code for
                     a Principal Location is the same as Dealer's SAP code, and it is displayed as
                     hidden field (see later on). Therefore Principal Location will have security setting
                     as 'none' for 'location.sapCode'.
                --%>
                <c:if test="${actionBean.location.dealer.generalInfo.sapDealerCode ne null}">
                    <nc:label name="code.branch.sap" for="location.sapCode"/>
                          <%-- Location SAP Code is editable only for Draft location --%>
                        <c:choose>
                            <c:when test="${actionBean.location.draft}">
                                <nc:text id="location.sapCode" name="location.sapCode"/><br/>
                            </c:when>
                            <c:otherwise>
                                <%--
                                We need to put the guard here, since location SAP code is only displayed here for ShipToParty location.
                                 nc:text already does this business.. so no check is needed there.
                                --%>
                                <nc:ifAccessAllowed name="location.sapCode">
                                     <span id="location.sapCode" class="formValue">${actionBean.location.sapCode}</span><br/>
                                </nc:ifAccessAllowed>
                            </c:otherwise>
                        </c:choose>
                </c:if>

                <nc:label name="code.partsbranch" for="location.partsBranchCode"/>
                <nc:text id="location.partsBranchCode" name="location.partsBranchCode"/><br/>

                <nc:label name="code.multisite" for="location.multisiteCode"/>
                <nc:text id="location.multisiteCode" name="location.multisiteCode"/><br/>

                <%-- Principal Location doesnt get to set the SAP code, but it is populated automatically upon location creation.
                so we need it as a hidden field, otherwise the value wont be saved --%>
                 <c:if test="${actionBean.location.type eq PrincipalLocationType}">
                     <stripes:hidden name="location.sapCode"/>
                </c:if>
            </fieldset>
         </li>
        </ul>
        <nc:ifWriteAccessAllowed name="location.sapCode">
            <stripes:layout-render name="/WEB-INF/jsp/nc/location/_locationSAPCodeVerificator.jsp"
                                   dealerSAPCode="${actionBean.location.dealer.generalInfo.sapDealerCode}"
                                   locationSAPCodeInputId="location\\\\.sapCode"/>
      </nc:ifWriteAccessAllowed>
    <!--- ============= End General Section ----------------------------- -->

</stripes:layout-definition>