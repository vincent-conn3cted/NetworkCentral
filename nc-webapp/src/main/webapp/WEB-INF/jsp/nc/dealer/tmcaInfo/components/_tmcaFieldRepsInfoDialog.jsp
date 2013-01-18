<%@ page import="au.com.toyota.nc.webapp.adapter.TMCAStaffJSONAdapter" %>
<%@ page import="au.com.toyota.nc.webapp.stripes.staff.TMCAStaffSearchActionBean" %>
<%@ page import="au.com.toyota.nc.webapp.adapter.ContactJSONAdapter" %>
<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<%--
    Defines the javascript operations for fetching & displaying TMCA Field reps

    Notes:
    1. Attach listeners to all column with 'tmcaFieldRepColumn' class, then use the nearest 'fkField' input
       to fetch the TMCA staff.
    2. Result is displayed as 'TMCAStaffDialog' dialog widget, using the HTML div id 'tmcaFieldRepInfoDialog'
--%>
<stripes:layout-definition>
    <div id="tmcaFieldRepInfoDialog" class="dialog">
               <div class="hd">&nbsp;</div>
               <div class="bd">
                   <label for="staffFirstname"><fmt:message key="label.firstname"/></label>
                   <span id="staffFirstname" class="formValue"></span><br/>

                   <label for="staffSurname"><fmt:message key="label.surname"/></label>
                   <span id="staffSurname" class="formValue"></span><br/>

                   <label for="staffMobile"><fmt:message key="label.mobile"/></label>
                   <span id="staffMobile" class="formValue"></span><br/>

                   <label for="staffPhone"><fmt:message key="label.phone"/></label>
                   <span id="staffPhone" class="formValue"></span><br/>

                   <label for="staffFax"><fmt:message key="label.fax"/></label>
                   <span id="staffFax" class="formValue"></span><br/>

                   <label for="staffEmail"><fmt:message key="label.email"/></label>
                   <span id="staffEmail" class="formValue"></span><br/>

                   <label for="tmcapin"><fmt:message key="label.tmcapin"/></label>
                   <span id="tmcapin" class="formValue"></span>
               </div>
           </div>



    <script type="text/javascript">
        var TMCAStaffSearchAjaxCommandObject = {
            handleSuccess: function(transport){
                try{
                    var staffData = YAHOO.lang.JSON.parse(transport.responseText);
                    YAHOO.log("Successfully fetched TMCA staff data "+ transport.responseText,"info");

                    // Interpret the JSON data
                    $("#staffFirstname").text(staffData.<%=TMCAStaffJSONAdapter.PROPERTY_FIRSTNAME%>);
                    $("#staffSurname").text(staffData.<%=TMCAStaffJSONAdapter.PROPERTY_SURNAME%>);
                    $("#staffMobile").text(staffData.<%=TMCAStaffJSONAdapter.PROPERTY_CONTACT%>.<%=ContactJSONAdapter.PROPERTY_MOBILE%>);
                    $("#staffPhone").text(staffData.<%=TMCAStaffJSONAdapter.PROPERTY_CONTACT%>.<%=ContactJSONAdapter.PROPERTY_PHONE%>);
                    $("#staffFax").text(staffData.<%=TMCAStaffJSONAdapter.PROPERTY_CONTACT%>.<%=ContactJSONAdapter.PROPERTY_FAX%>);
                    $("#staffEmail").text(staffData.<%=TMCAStaffJSONAdapter.PROPERTY_CONTACT%>.<%=ContactJSONAdapter.PROPERTY_EMAIL%>);
                    $("#tmcapin").text(staffData.<%=TMCAStaffJSONAdapter.PROPERTY_TMCAPIN%>);

                    YAHOO.au.com.toyota.widget.TMCAStaffDialog.show();
                }catch(e){
                    YAHOO.log("An error has occurred while interpreting data from server " + e,"error");
                    alert("An error has occurred while interpreting data from server " + e);
                }
            },
            handleFailure: function(transport){
                YAHOO.log("Error has occurred while loading tmca staff from server" + transport.responseText,"error");
                alert("Failed to load data from server !");
            }
        };


        function ${initializeGetTMCAFieldRepInfoFunctionName}(){
            YAHOO.log("Attaching behaviour to get TMCA field data","info");
            $("td.tmcaFieldRepColumn").click(function(){
                var personId=$(this).closest("tr").find("span.fkField").text();
                if (personId !=''){
                    YAHOO.util.Connect.asyncRequest('GET',
                            "<c:url value='/staff/TMCAStaffSearch.action'/>?<%=TMCAStaffSearchActionBean.EVENT_GET_STAFF%>&staffId="+personId,
                    {
                        cache:false,          // this option is needed. Firefox doesnt cache HTTP GET, but IE does.
                        success: TMCAStaffSearchAjaxCommandObject.handleSuccess,
                        failure: TMCAStaffSearchAjaxCommandObject.handleFailure
                    });
                }
            });

            <stripes:layout-render name="/WEB-INF/jsp/layout/_popupDialog.jsp"
                dialogName="TMCAStaffDialog"
                dialogId="tmcaFieldRepInfoDialog"/>
        }
    </script>

</stripes:layout-definition>
