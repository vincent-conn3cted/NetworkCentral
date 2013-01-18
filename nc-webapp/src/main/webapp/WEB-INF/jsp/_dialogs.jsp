<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<stripes:layout-definition>
    <script type="text/javascript">
        dialogs =
        {
            allDialogs : null,
            init: function()
            {
                this.allDialogs = [];
            },
            add: function(dialog)
            {
                this.allDialogs.push(dialog);
            },
            initializeAllDialogs: function()
            {
                for(var dialogCount in this.allDialogs)
                {
                    this.allDialogs[dialogCount].initDialog();
                }
            }
        }
        dialogs.init();
    </script>
</stripes:layout-definition>
