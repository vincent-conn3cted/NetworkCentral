<%@ page import="au.com.toyota.nc.common.security.NCPageViewMode" %>
<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<stripes:layout-render name="/WEB-INF/jsp/layout/stdLayout.jsp">

    <stripes:layout-component name="html-head">
          <link rel="stylesheet" media="screen" type="text/css"
                 href="${pageContext.request.contextPath}/css/wib/dealerLocation/nc-dealership.css"/>
    </stripes:layout-component>

    <stripes:layout-component name="page-contents">
        <!-- for selenium tests: dealer awards page -->
        <stripes:layout-render name="/WEB-INF/jsp/layout/_calendarFiles.jsp"/>


        <div id="dealerLocationDetailsPage" class="pageContent_wrapper">
            <stripes:form beanclass="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageDealerLocationActionBean">
                  <%-- ==========================================
                        Secure page stuffs
                    =============================================--%>
                <c:set var="pageName" value="EditDealership-Award" scope="page"/>

                <nc:pageName pageName="${pageName}"/>
                <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>
                <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/_dealerCommonForm.jsp" pageName="${pageName}"/>

                <div id="dealerDetails-awardsSection" class="mainContent_wrapper">
                      <ul class="column-style-fieldset oneCol">
                            <li>
                                <stripes:layout-render name="/WEB-INF/jsp/nc/dealer/awardsInfo/_awardsDialog.jsp"/>
                          </li>
                      </ul>
                    <div class="clear">&nbsp;</div>
                </div>
            </stripes:form>
        
        </div>
    </stripes:layout-component>

    <stripes:layout-component name="yui-init-dependencies">
        loader.require("datatable", "connection", "paginator", "menu");
    </stripes:layout-component>

    <stripes:layout-component name="init-event-handling">
        <script type="text/javascript">

            function initializeAwardTable(){
                var awardDataTableDef = [
                    {key:"year", label:"Year",sortable:true, resizable:false, className:"awardYearField"},
                    {key:"awardWon", label:"Award Won",sortable:true, resizable:false, className:"awardTypeLabelField"},
                    {key:"levelAttained", label:"Level Attained",sortable:true, resizable:false, className:"awardLevelLabelField"}
                ];

                this.awardDataSource = new YAHOO.util.DataSource(YAHOO.util.Dom.get("awardsTable"));
                this.awardDataSource.responseType = YAHOO.util.DataSource.TYPE_HTMLTABLE;

                this.awardDataSource.responseSchema = {
                    fields:[
                        {key:"year"},
                        {key:"awardWon"},
                        {key:"levelAttained"}
                    ]
                };

                var oConfigs = {
                    width:"850px"
                };

                var awardsTable = new YAHOO.widget.DataTable("awardsTableSection", awardDataTableDef, this.awardDataSource, oConfigs);
            }

                function yuiLoadComplete(){
                    YAHOO.util.Event.onDOMReady(function(){
                        <nc:ifPageViewMode mode="<%= NCPageViewMode.View.name()%>">
                            initializeAwardTable();
                        </nc:ifPageViewMode>
                        <nc:ifWriteAccessAllowed name="dealer.awards">
                                initializeAwardDialog();
                        </nc:ifWriteAccessAllowed>
                    });
                }
        </script>
    </stripes:layout-component>

</stripes:layout-render>
