<%@ page import="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageDealerLocationActionBean" %>
<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<stripes:layout-definition>
    <%-- ==========================================
    Secure page stuffs
    =============================================--%>
    <nc:pageName pageName="${pageName}"/>
    <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>
	
	<fieldset>
	    <legend class="legend"><fmt:message  key="dealer.generaltab.section.communication.header"/></legend>
	    <ul class="column-style-fieldset twoCols">
	        <li style="width: 450px">
                <fieldset id="communication-tsm1">
	                <nc:label name="label.email" for="dealer.principalLocation.contact.email"/>
	                <nc:text id="dealer.principalLocation.contact.email" name="dealer.principalLocation.contact.email"/><br/>
	
	                <nc:label name="label.website" for="dealer.principalLocation.contact.website"/>
	                <nc:text id="dealer.principalLocation.contact.website" name="dealer.principalLocation.contact.website"/>
	                <br/>
	                
	                <nc:label name="label.websiteValidated" for="dealer.principalLocation.contact.websiteValidated"/>
	                <nc:checkbox id="dealer.principalLocation.contact.websiteValidated" name="dealer.principalLocation.contact.websiteValidated"/><br/>
	
	                <nc:label name="label.phone" for="dealer.principalLocation.contact.phone"/>
	                <nc:text id="dealer.principalLocation.contact.phone" name="dealer.principalLocation.contact.phone"/><br/>
	
	                <nc:label name="label.fax" for="dealer.principalLocation.contact.fax"/>
	                <nc:text id="dealer.principalLocation.contact.fax" name="dealer.principalLocation.contact.fax"/><br/>
	
	                <nc:label name="label.shortDial" for="dealer.principalLocation.contact.shortDial"/>
	                <nc:text id="dealer.principalLocation.contact.shortDial" name="dealer.principalLocation.contact.shortDial"/><br/>
	
	                <nc:label name="label.regionalSpeedDial" for="dealer.principalLocation.contact.regionalSpeedDial"/>
	                <nc:text id="dealer.principalLocation.contact.regionalSpeedDial" name="dealer.principalLocation.contact.regionalSpeedDial"/><br/>
				</fieldset>
	        </li>
	        <li style="width: 450px">
                <fieldset id="communication-tsm2">
					<stripes:layout-render name="/WEB-INF/jsp/nc/location/generalInfo/components/_communicationEmailURLContent.jsp" pageName="${pageName}" prefix="dealer.principalLocation"/>
	           </fieldset>     
	        </li>
	    </ul>
	</fieldset>


</stripes:layout-definition>