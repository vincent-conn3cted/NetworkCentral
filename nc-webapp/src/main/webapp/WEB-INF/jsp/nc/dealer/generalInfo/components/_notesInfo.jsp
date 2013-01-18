<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>

<stripes:layout-definition>
    <%-- ==========================================
    Secure page stuffs
    =============================================--%>
    <nc:pageName pageName="${pageName}"/>
    <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>

    <nc:ifAccessAllowed name="dealer.generalInfo.note">
            <nc:label name="label.note" for="dealer.generalInfo.note"/>
            <nc:textarea name="dealer.generalInfo.note"/><br/>
    </nc:ifAccessAllowed>
</stripes:layout-definition>