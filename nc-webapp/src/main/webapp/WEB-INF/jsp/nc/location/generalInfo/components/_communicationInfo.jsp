<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<stripes:layout-definition>
    <nc:pageName pageName="${pageName}"/>
    <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>
    

	<fieldset>
	    <legend><fmt:message  key="dealer.generaltab.section.communication.header"/></legend>
	    <ul class="column-style-fieldset twoCols">
	        <li style="width: 450px">
                <fieldset id="communication-tsm1">
	                <nc:label name="label.email" for="location.contact.email"/>
	                <nc:text id="location.contact.email" name="location.contact.email"/><br/>
	
	                <nc:label name="label.website" for="location.contact.website"/>
	                <nc:text id="location.contact.website" name="location.contact.website"/><br/>
	
	                <nc:label name="label.websiteValidated" for="location.contact.websiteValidated"/>
	                <nc:checkbox id="location.contact.websiteValidated" name="location.contact.websiteValidated"/><br/>
	
	                <nc:label name="label.phone" for="location.contact.phone"/>
	                <nc:text id="location.contact.phone" name="location.contact.phone"/><br/>
	
	                <nc:label name="label.fax" for="location.contact.fax"/>
	                <nc:text id="location.contact.fax" name="location.contact.fax"/><br/>
	
	                <nc:label name="label.shortDial" for="location.contact.shortDial"/>
	                <nc:text id="location.contact.shortDial" name="location.contact.shortDial"/><br/>
	
	                <nc:label name="label.regionalSpeedDial" for="location.contact.regionalSpeedDial"/>
	                <nc:text id="location.contact.regionalSpeedDial" name="location.contact.regionalSpeedDial"/><br/>
	            </fieldset>
	        </li>
	        <li style="width: 450px">
                <fieldset id="communication-tsm2">
				<stripes:layout-render name="/WEB-INF/jsp/nc/location/generalInfo/components/_communicationEmailURLContent.jsp" pageName="${pageName}" prefix="location"/>
	            </fieldset>
	        </li>
	    </ul>
	</fieldset>

</stripes:layout-definition>