<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<stripes:layout-definition>
    <nc:pageName pageName="${pageName}"/>
    <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>
    

        <!--- =====     Start Address Info =========================== -->
    <ul class="column-style-fieldset threeCols">
        <nc:ifAccessAllowed name="location.contact.streetAddress">
        <li>
            <!-- =========== Start Street Address section ============== -->
            <fieldset id="generalInfo-streetAddressSection">
                <legend><fmt:message  key="label.address.street.header"/></legend>
                <nc:label name="label.address1" for="location.contact.streetAddress.address1"/>
                <nc:text id="location.contact.streetAddress.address1" name="location.contact.streetAddress.address1"/><br/>

                <nc:label name="label.address2" for="location.contact.streetAddress.address2"/>
                <nc:text id="location.contact.streetAddress.address2" name="location.contact.streetAddress.address2"/><br/>

                <nc:label name="label.suburb" for="location.contact.streetAddress.suburb"/>
                <nc:text name="location.contact.streetAddress.suburb"/><br/>

                <nc:label name="label.state" for="location.contact.streetAddress.state"/>
                <nc:select name="location.contact.streetAddress.state" readOnlyValue="${actionBean.location.contact.streetAddress.state}">
                    <stripes:option value=""><fmt:message key="label.selectone"/></stripes:option>
                    <stripes:options-enumeration enum="au.com.toyota.nc.common.model.hibernate.State"/>
                </nc:select> <br/>

                <nc:label name="label.postCode" for="location.contact.streetAddress.postCode"/>
                <nc:text name="location.contact.streetAddress.postCode"/><br/>
            </fieldset>
            <!-- =========== End Street Address section ============== -->
        </li>
        </nc:ifAccessAllowed>

     <nc:ifAccessAllowed name="location.contact.postalAddress">
         <li>
            <!-- =========== Start Postal Address section ============== -->
              <fieldset id="generalInfo-postalAddressSection">
                <legend><fmt:message  key="label.address.postal.header"/></legend>
                <nc:label name="label.address1" for="location.contact.postalAddress.address1"/>
                <nc:text id="location.contact.postalAddress.address1" name="location.contact.postalAddress.address1"/><br/>

               <nc:label name="label.address2" for="location.contact.postalAddress.address2"/>
                <nc:text id="location.contact.postalAddress.address2" name="location.contact.postalAddress.address2"/><br/>

                <nc:label name="label.suburb" for="location.contact.postalAddress.suburb"/>
                <nc:text name="location.contact.postalAddress.suburb"/><br/>

                <nc:label name="label.state" for="location.contact.postalAddress.state"/>
                <nc:select name="location.contact.postalAddress.state" readOnlyValue="${actionBean.location.contact.postalAddress.state}">
                    <stripes:option value=""><fmt:message key="label.selectone"/></stripes:option>
                    <stripes:options-enumeration enum="au.com.toyota.nc.common.model.hibernate.State"/>
                </nc:select><br/>

                <nc:label name="label.postCode" for="location.contact.postalAddress.postCode"/>
                <nc:text name="location.contact.postalAddress.postCode"/><br/>
            </fieldset>
             <!-- =========== End Postal Address section ============== -->
         </li>
     </nc:ifAccessAllowed>



    <nc:ifAccessAllowed name="location.contact.poBoxAddress">
        <li>
                <!-- =========== Start PO Address section ============== -->
                <fieldset id="generalInfo-poAddressSection">
                    <legend><fmt:message  key="label.address.poBox.header"/></legend>
                    <nc:label name="label.poBoxAddress" for="location.contact.poBoxAddress.address1"/>
                    <nc:text id="location.contact.poBoxAddress.address1" name="location.contact.poBoxAddress.address1"/><br/>

                    <nc:label name="label.suburb" for="location.contact.poBoxAddress.suburb"/>
                    <nc:text name="location.contact.poBoxAddress.suburb"/><br/>

                    <nc:label name="label.state" for="location.contact.poBoxAddress.state"/>
                    <nc:select name="location.contact.poBoxAddress.state" readOnlyValue="${actionBean.location.contact.poBoxAddress.state}">
                        <stripes:option value=""><fmt:message key="label.selectone"/></stripes:option>
                        <stripes:options-enumeration enum="au.com.toyota.nc.common.model.hibernate.State"/>
                    </nc:select><br/>

                    <nc:label name="label.postCode" for="location.contact.poBoxAddress.postCode"/>
                    <nc:text name="location.contact.poBoxAddress.postCode"/><br/>
                </fieldset>
                <!-- =========== End PO Address section ============== -->
        </li>
    </nc:ifAccessAllowed>
    </ul>
    <!--- =====     End Address Info  =========================== -->

</stripes:layout-definition>