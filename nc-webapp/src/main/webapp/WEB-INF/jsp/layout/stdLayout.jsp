<%@ page import="au.com.toyota.nc.common.dealers.impl.SapDealer" %>
<%@ page import="au.com.toyota.nc.common.model.hibernate.AbstractContact" %>
<%@ page import="au.com.toyota.nc.common.model.hibernate.AbstractDocument" %>
<%@ page import="au.com.toyota.nc.common.model.hibernate.DMSContactPerson" %>
<%@ page import="au.com.toyota.nc.common.model.hibernate.DMSProduct" %>
<%@ page import="au.com.toyota.nc.common.model.hibernate.DocumentType" %>
<%@ page import="au.com.toyota.nc.common.utils.NCConstants" %>
<%@ page import="au.com.toyota.nc.webapp.dataproxy.SAPCodeVerifier" %>
<%@ page import="au.com.toyota.nc.webapp.stripes.admin.ManageDMSVendorActionBean" %>
<%@ page import="au.com.toyota.nc.webapp.stripes.admin.ManageGroupActionBean" %>
<%@ page import="au.com.toyota.nc.webapp.stripes.admin.ManagePMAActionBean" %>
<%@ page import="au.com.toyota.nc.webapp.stripes.admin.ManagePositionTypesActionBean" %>
<%@ page import="au.com.toyota.nc.webapp.stripes.admin.ManageTMCAFieldRepresentativesActionBean" %>
<%@ page import="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageDealerLocationActionBean" %>
<%@ page import="au.com.toyota.nc.webapp.stripes.dealerLocations.ManageLocationActionBean" %>
<%@ page import="au.com.toyota.nc.webapp.stripes.staff.AppointmentSourceActionType" %>
<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<stripes:layout-definition>
    <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
    <html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <title>Network Central</title>
        <stripes:layout-render name="/WEB-INF/jsp/css.jsp"/>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.3.1.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-ui-1.7.2.custom.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/ui.dropdownchecklist-1.0-min.js"></script>
        <stripes:layout-render name="/WEB-INF/jsp/js.jsp"/>
        <stripes:layout-render name="/WEB-INF/jsp/_dialogs.jsp"/>
        <%-- ================================================
        Layout component: html-head
        Usage: put extra stuffs for the HTML head element. e.g. override CSS for individual pages, load extra javascript, etc.
        Note: dont put event handling codes inside this layout component!
        ===================================================== --%>
        <stripes:layout-component name="html-head"/>

        <%--
        NC-588 - hitting the 'back' button after activating a dealer caused issues because the old status of "DRAFT" would be sent down again
        and override the status of the newly activated dealer (which was actually solved by not sending down the status). But it identified
        that hitting the back button would create unexpected behaviours in NC, so disabling it was the quickest (and very very dirty) solution.

        I personally reckon this is a bit of a hack to disable the back button. I reckon the proper way is to make sure that the app
        can deal with requests to put data into an incorrect state (for example, should fail validation if trying to change status of
        dealer from active to draft, or making sure that a dealer does not have changeover flag set before creating a new changeover for
        that dealer). But we don't have time, so we're stuck with this crappy hack....
        --%>
        <script type="text/javascript">
            // never let the user go back. Seems to just silently fail if no more forward history (representing the latest page they are on),
            // which means that it will keep moving the user forward each time they go back to the previous page. 

            // Following line removed - Dim instructed me to remove to enable testing
            //history.forward();
        </script>
    </head>

    <body>

    <div id="container_main">
        <a name="top" id="top"></a>
        <!--********************* START GLOBAL HEADER ********************************************* -->

        <!-- start container header-->
        <div id="container_header">
             <%-- ================================================
            Layout component: page-header
            Usage: put extra stuffs for the page header
            ===================================================== --%>
            <stripes:layout-component name="page-header"/>
            <stripes:layout-render name="/WEB-INF/jsp/layout/header.jsp"/>

        </div><!-- end container header-->
        <div class="clear"></div>

        <!--********************* END GLOBAL HEADER ********************************************* -->


        <!--********************* START CONTENT ********************************************* -->
        <!-- start container content-->
        <div id="container_content">
            <div class="clear"></div>
              <%-- ================================================
            Layout component: page-contents
            Usage: put the page content
            ===================================================== --%>
            <stripes:layout-component name="page-contents"/>
            <div class="clear"></div>
        </div><!-- end container content-->
        <div class="clear"></div>
        <!--********************* END CONTENT ********************************************* -->


        <!--********************* START GLOBAL FOOTER ********************************************* -->
        <div id="container_footer">
             <%-- ================================================
            Layout component: page-footer
            Usage: put extra stuffs for the page footer.
            ===================================================== --%>
                <stripes:layout-component name="page-footer">
                    <stripes:layout-render name="/WEB-INF/jsp/layout/footer.jsp"/>
                </stripes:layout-component>

        </div><!-- end container footer-->
        <div class="clear"></div>
        <!--********************* END GLOBAL FOOTER ******************************************************* -->


        <div id="loggingContainer"></div>


        <script type="text/javascript" src="${pageContext.request.contextPath}/common/js/yui/yuiloader/yuiloader-min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/common/js/yui/yahoo-dom-event/yahoo-dom-event.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/common/js/yui/utilities/utilities.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/common/js/yui/container/container-min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/common/js/yui/json/json-min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/common/js/yui/logger/logger-min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/masking/dFilter.js" ></script>

        <%-- ================================================
        Layout component: init-event-handling
        Usage: put event handling logic here (typically Javascripts).
        Override the yuiLoadComplete() function with codes that depends
        on non-default YAHOO components. i.e. other than the following:
        * DOM
        * Event
        * Util
        * Container
        * JSON
        Note that yuiLoadComplete method HAS to be supplied if
        you override the init-event-handling Stripes layout component, even
        though its empty. Because YUILoader will call this function.
        ===================================================== --%>
        <stripes:layout-component name="init-event-handling">
            <script type="text/javascript">
                function yuiLoadComplete(){
                }
            </script>
        </stripes:layout-component>



        <%-- ==================================================
        Load YUI components using YUI loader
        ======================================================= --%>
        <button id="loggingButton" accesskey="L"></button>
        <script type="text/javascript"src="${pageContext.request.contextPath}/js/nc-util.js"></script>
        <script type="text/javascript">
            //var onLoadComplete = new YAHOO.util.CustomEvent("YUILoadComplete");
            var myLogReader = new YAHOO.widget.LogReader("loggingContainer");
            myLogReader.hide();
            var loader = new YAHOO.util.YUILoader({
                onSuccess: function(){
                    YAHOO.log("YUI Load complete","info");
                    yuiLoadComplete();

                    // run thru global variable of dialog boxes and initDialog them
                    dialogs.initializeAllDialogs();

                    // move all YUI Panel as the last child of body. This is because YUI render
                    // these panels with style 'visibility:hidden', which takes up space, unlike display:none
                    // $(".yui-panel-container","#container_content").appendTo("body");
                }
            });
            loader.base = '${pageContext.request.contextPath}/common/js/yui/';
            loader.filter = '';

            // Attach behaviour to logging button
            YAHOO.util.Event.addListener("loggingButton", "click", function(){
                var loggingContainerDisplay=$("#loggingContainer").css("display");
                $("#loggingContainer").css("display",  loggingContainerDisplay=='none'?'':'none');
            },myLogReader,true);

            <jsp:include page="/js/nc-widgets.js"/>

            <%-- ==============================================
            Layout-component: yui-init-dependencies
            Usage: Put extra stuffs to be loaded by YUI loader
            Note: dont wrap them in <script> tag. This is not the greatest
            approach at the moment, and maybe there's a better way to do this..
            ===================================================--%>
            <stripes:layout-component name="yui-init-dependencies"/>
            loader.insert();
        </script>

    </div>

    </body>
    </html>
</stripes:layout-definition>
