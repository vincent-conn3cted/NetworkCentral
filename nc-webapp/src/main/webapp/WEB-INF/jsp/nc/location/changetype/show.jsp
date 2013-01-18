<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<!-- rendered via ajax -->


<div id="changeLocationTypeTitle">&nbsp;</div>
<!-- for selenium tests: show change location type popup -->

<stripes:form beanclass="au.com.toyota.nc.webapp.stripes.dealerLocations.ChangeLocationTypeActionBean">
    <stripes:hidden name="locationId"/>
    <stripes:hidden name="lastTabShown" value="${actionBean.lastTabShown}"/>
    <stripes:hidden name="showAsReadOnly" value="${actionBean.showAsReadOnly}"/>
    <fieldset>
        <stripes:label for="newLocationType" name="location.type"/>
        <stripes:select name="newLocationType" id="newLocationType">
            <stripes:options-collection collection="${actionBean.newLocationTypes}"/>
        </stripes:select><br/>

        <stripes:label for="newSapCode" name="location.type.change.newSapCode"/>
        <stripes:text name="newSapCode" id="newSapCode"/>
        <br/>

    <c:if test="${actionBean.location.type.principal}">
            <stripes:label for="replacementLocationId" name="location.type.change.replacementLocation"/>
            <stripes:select name="replacementLocationId" id="replacementLocationId">
                <c:forEach var="eligibleLocation" items="${actionBean.replacementLocations}">
                    <stripes:option value="${eligibleLocation.locationId}">
                        <stripes:layout-render name="/WEB-INF/jsp/nc/formatting/_locationNameSelection.jsp" location="${eligibleLocation}"/>                        
                    </stripes:option>
                </c:forEach>
            </stripes:select><br/>
    </c:if>
    <stripes:submit id="saveLocationTypeChangeButton" name="change" value="OK" class="btn btn_save"/>
    </fieldset>
</stripes:form>
