<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<stripes:layout-definition>
    <script type="text/javascript">
             YAHOO.log("Attach location name search behaviour","info");

             <stripes:url beanclass="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageDealerLocationActionBean" event="searchLocationName" var="searchURL"/>
                var oDS = new YAHOO.util.XHRDataSource("${searchURL}");
                oDS.responseType = YAHOO.util.XHRDataSource.TYPE_JSON;
                oDS.responseSchema= {
                    resultsList : "Result",
                    fields: ["locationName"]
                };
                var oAC = new YAHOO.widget.AutoComplete("searchReq.locationName","locationNameSearchResultContainer",oDS);
                oAC.queryDelay= .5;
    </script>
</stripes:layout-definition>

