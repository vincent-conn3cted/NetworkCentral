<%@ page import="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageDealerLocationActionBean" %>
<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<stripes:layout-definition>
    <%-- ==========================================
    Secure page stuffs
    =============================================--%>
    <nc:pageName pageName="${pageName}"/>
    <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>


    <ul class="column-style-fieldset threeCols">
            <!-- =========== Start Street Address section ============== -->
            <li>
                <fieldset id="generalInfo-streetAddressSection">
                    <legend class="legend"><fmt:message  key="label.address.street.header"/></legend>
                    <nc:label  name="label.address1" for="dealer.principalLocation.contact.streetAddress.address1"/>
                    <nc:text id="dealer.principalLocation.contact.streetAddress.address1" name="dealer.principalLocation.contact.streetAddress.address1"/><br/>

                    <nc:label name="label.address2" for="dealer.principalLocation.contact.streetAddress.address2" />
                    <nc:text id="dealer.principalLocation.contact.streetAddress.address2" name="dealer.principalLocation.contact.streetAddress.address2"/><br/>

                    <nc:label name="label.suburb" for="dealer.principalLocation.contact.streetAddress.suburb" />
                    <nc:text id="dealer.principalLocation.contact.streetAddress.suburb" name="dealer.principalLocation.contact.streetAddress.suburb"/><br/>

                    <nc:label name="label.state" for="dealer.principalLocation.contact.streetAddress.state" />
                    <nc:select id="dealer.principalLocation.contact.streetAddress.state" name="dealer.principalLocation.contact.streetAddress.state" readOnlyValue="${principalLocation.contact.streetAddress.state}">
                            <stripes:options-enumeration enum="au.com.toyota.nc.common.model.hibernate.State"/>
                    </nc:select><br/>

                    <nc:label name="label.postCode" for="dealer.principalLocation.contact.streetAddress.postCode" />
                    <nc:text id="dealer.principalLocation.contact.streetAddress.postCode" name="dealer.principalLocation.contact.streetAddress.postCode"/><br/>
                </fieldset>
            </li>
            <!-- =========== End Street Address section ============== -->


            <!-- =========== Start Postal Address section ============== -->
              <li>
                  <fieldset id="generalInfo-postalAddressSection">
                  <legend class="legend"><fmt:message  key="label.address.postal.header"/></legend>
                    <nc:label name="label.address1" for="dealer.principalLocation.contact.postalAddress.address1"/>
                    <nc:text id="dealer.principalLocation.contact.postalAddress.address1" name="dealer.principalLocation.contact.postalAddress.address1"/>
                      <br/>
                    <nc:label name="label.address2" for="dealer.principalLocation.contact.postalAddress.address2"/>
                    <nc:text id="dealer.principalLocation.contact.postalAddress.address2" name="dealer.principalLocation.contact.postalAddress.address2"/>
                      <br/>

                    <nc:label name="label.suburb" for="dealer.principalLocation.contact.postalAddress.suburb"/>
                    <nc:text name="dealer.principalLocation.contact.postalAddress.suburb"/>
                      <br/>

                    <nc:label name="label.state" for="dealer.principalLocation.contact.postalAddress.state"/>
                    <nc:select id="dealer.principalLocation.contact.postalAddress.state" name="dealer.principalLocation.contact.postalAddress.state" readOnlyValue="${principalLocation.contact.postalAddress.state}">
                        <stripes:options-enumeration enum="au.com.toyota.nc.common.model.hibernate.State"/>
                    </nc:select>
                      <br/>

                    <nc:label name="label.postCode" for="dealer.principalLocation.contact.postalAddress.postCode"/>
                    <nc:text name="dealer.principalLocation.contact.postalAddress.postCode"/>
                </fieldset>
              </li>
            <!-- =========== End Postal Address section ============== -->


            <!-- =========== Start PO Address section ============== -->
            <li>
                <fieldset id="generalInfo-poAddressSection">
                  <legend class="legend"><fmt:message  key="label.address.poBox.header"/></legend>
                <nc:label name="label.poBoxAddress" for="dealer.principalLocation.contact.poBoxAddress.address1" />
                <nc:text id="dealer.principalLocation.contact.poBoxAddress.address1" name="dealer.principalLocation.contact.poBoxAddress.address1"/>
                <br/>

                <nc:label name="label.suburb" for="dealer.principalLocation.contact.poBoxAddress.suburb" />
                <nc:text id="dealer.principalLocation.contact.poBoxAddress.suburb" name="dealer.principalLocation.contact.poBoxAddress.suburb"/>
                    <br/>

                <nc:label name="label.state" for="dealer.principalLocation.contact.poBoxAddress.state" />
                <nc:select id="dealer.principalLocation.contact.poBoxAddress.state" name="dealer.principalLocation.contact.poBoxAddress.state" readOnlyValue="${principalLocation.contact.poBoxAddress.state}">
                    <stripes:options-enumeration enum="au.com.toyota.nc.common.model.hibernate.State"/>
                </nc:select>
                    <br/>

                <nc:label name="label.postCode" for="dealer.principalLocation.contact.poBoxAddress.postCode"/>
                <nc:text id="dealer.principalLocation.contact.poBoxAddress.postCode" name="dealer.principalLocation.contact.poBoxAddress.postCode"/>
                </fieldset>
            </li>
            <!-- =========== End PO Address section ============== -->
            <div class="clear"></div>
     </ul>



</stripes:layout-definition>