<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<stripes:layout-definition>
    <div id="loginLayoutSection" class="pageContent_wrapper">
        <div class="mainContent_wrapper">
            <table id="loginTable">
                <tbody>
                    <tr>
                        <td class="applicationIntroColumn">
                            <p></p>
                        </td>
                        <td class="loginFormColumn">
                              <form method="POST" action='<%= response.encodeURL("j_security_check") %>'>
                                <fieldset>
                                    <label for="username"><fmt:message key="label.username"/></label>
                                    <input id="username" type="text" name="j_username" value="${username}"/><br/>
                                    <label for="password"><fmt:message key="label.password"/></label>
                                    <input id="password" type="password" name="j_password" value="${password}"/><br/>
                                    <label></label><input type="submit"  name="submit" value="Login" class="btn btn_login"/>
                                    <input type="reset"   name="reset"  value="Reset"  id="resetForm"  class="btn btn_reset"/>
                                    <br/>
                                    <p>
                                        To request a password change, please put in a request on the Delegated Administration 
                                        <a style="color:white;" href="http://delegatedadmin.tmca.com.au/RequestPWReset.aspx" target="_blank">
                                            Password Reset website</a>
                                    </p>
                                </fieldset>
                            </form>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</stripes:layout-definition>