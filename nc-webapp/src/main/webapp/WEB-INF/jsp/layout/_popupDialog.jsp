<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<%--
    Use stripes:layout-render to render this javascript for showing popup dialog.
    Parameters:
        postmethod - postmethod used for YUI's dialog box. Valid values are: 'async', 'form','none'.
                                 The default is 'async'.
        dialogName - unique dialog name within the page
        dialogId - div id of the popup dialog
        okHandler - javascript function to handle the 'ok' button
        modal - whether to render the popup as a modal dialog. If not specified, use the default behaviour, modal dialog

    e.g.:
        <div id="addDealerCommitteeDialog" class="dialog">
            <div class="hd">Header</div>
            <div class="bd">Body</div>
        </div>

     <stripes:layout-render name="/WEB-INF/jsp/layout/_popupDialog.jsp"
                        dialogName="AddDealerCommitteeDialog"
                        dialogId="addDealerCommitteeDialog"
                        okHandler="addSelectedDealerCommittee"/>
--%>

<c:if test="${empty okButtonText}">
    <c:set var="okButtonText" value="Ok"/>
</c:if>
<stripes:layout-definition>
    YAHOO.au.com.toyota.widget.${dialogName} = new YAHOO.widget.Dialog("${dialogId}",
    {
       fixedcenter:true,visible:false,constraintoviewport : true
        <c:if test="${postmethod!=null}">
            ,postmethod:"${postmethod}"
        </c:if>
        <c:if test="${modal != null}">
            ,modal:${modal}
        </c:if>
        <c:if test="${modal == null}">
            ,modal:true
        </c:if>
        <c:if test="${width != null}">
            ,width: "${width}"
        </c:if>
        <c:if test="${not noButtons}">
            ,buttons :
                [
                    {
                        text:"<c:out value="${okButtonText}"/>",
                        handler:function(){
                            <c:if test="${okHandler != null}">
                                ${okHandler}();
                            </c:if>
                            <c:if test="${hideDialogOnOK==null || (hideDialogOnOK eq true)}">
                                this.hide();
                            </c:if>
                        },
                        isDefault:true
                    }
                ]
        </c:if>
    });
    YAHOO.au.com.toyota.widget.${dialogName}.render();

</stripes:layout-definition>

