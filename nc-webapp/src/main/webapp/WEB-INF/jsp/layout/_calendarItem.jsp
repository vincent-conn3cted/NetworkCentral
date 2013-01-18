<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<stripes:layout-definition>

    <script type="text/javascript">
        if(document.getElementById('${inputField}') != null)
        {
            // Set up the calendar popup for a particular field and button
            Calendar.setup({
                inputField  : "${inputField}",
                showsTime   :
                        <c:choose>
                            <c:when test="${showsTime != null}">
                                ${showsTime}
                            </c:when>
                            <c:otherwise>
                                false
                            </c:otherwise>
                        </c:choose>,
                timeFormat  : 24,
                ifFormat    :
                        <c:choose>
                            <c:when test="${(showsTime != null) && showsTime eq true}">
                                "%d-%m-%Y %H:%M"
                            </c:when>
                            <c:otherwise>
                                "%d-%m-%Y"
                            </c:otherwise>
                        </c:choose>,
                button      : "${button}"
            });            
        }
    </script>
    
</stripes:layout-definition>

