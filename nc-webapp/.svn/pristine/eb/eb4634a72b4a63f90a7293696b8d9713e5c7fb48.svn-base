package au.com.toyota.nc.webapp.taglibs;

import au.com.toyota.nc.common.security.NCFieldPermission;
import au.com.toyota.nc.common.security.NCFieldSecurityMapper;
import au.com.toyota.nc.common.security.NCPageViewMode;
import au.com.toyota.nc.common.security.NCRole;
import au.com.toyota.nc.common.utils.NCConstants;
import com.toyota.ibus.common.util.Str;
import net.sourceforge.stripes.exception.StripesJspException;
import org.apache.log4j.Logger;

import javax.servlet.jsp.PageContext;
import java.text.MessageFormat;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * User: Alex Wibowo
 * Date: Mar 11, 2009
 * Time: 9:29:34 PM
 */
public class NCTagHelper {
    private static final Logger LOG = Logger.getLogger(NCDateTextTag.class.getName());

    private PageContext pageContext;

    private NCFieldSecurityMapper securityMapper;

    /**
     * Page view mode to be used, if there wasnt one specified
     */
    private static final NCPageViewMode DEFAULT_PAGE_VIEW_MODE = NCPageViewMode.Edit;

    public NCTagHelper(NCFieldSecurityMapper securityMapper, PageContext pageContext) {
        this.pageContext=pageContext;
        this.securityMapper=securityMapper;
    }

    /**
     * @param fieldName field name
     * @return permission for the current logged in user, for the given field name, for the current active page
     * @throws StripesJspException
     */
    public NCFieldPermission getFieldPermission(String fieldName) throws StripesJspException {
        try {
            String pageName = getCurrentPageName();
            NCRole userRole= getUserRole();
            NCPageViewMode pageViewMode = getPageViewMode();

            NCFieldPermission ncFieldPermission = securityMapper.getPermission(removeArrayIndex(fieldName), pageName, userRole);
            LOG.debug(MessageFormat.format("Pagename : [{0}] fieldname: [{1}] permission: [{2}] ", pageName, fieldName, ncFieldPermission));

            if (pageViewMode == NCPageViewMode.Edit) {
                return ncFieldPermission;
            }else {
                switch (ncFieldPermission) {
                    case Write:
                        LOG.debug("Page is marked as readonly");
                        return NCFieldPermission.Read;
                    case Read:
                    case None:
                    case ConditionalRestrict:
                    case DoNotRestrict:
                        return ncFieldPermission;
                    default:
                        throw new IllegalArgumentException("Invalid field permission " + ncFieldPermission);
                }
            }
        } catch (StripesJspException e) {
            String message = MessageFormat.format("Exception caught while trying to render field [{0}]", fieldName);
            LOG.error(message);
            throw new StripesJspException(message, e);
        }
    }

    public NCRole getUserRole(){
        return (NCRole) pageContext.getSession().getAttribute(NCConstants.SESSION_KEY_USER_ROLE);
    }


    private NCPageViewMode getPageViewMode(){
        NCPageViewMode  viewMode= (NCPageViewMode) pageContext.getAttribute(NCConstants.JSP_PAGE_VIEW_MODE_ATTRIBUTE);
        return viewMode!=null? viewMode : DEFAULT_PAGE_VIEW_MODE;
    }

    private String getCurrentPageName() throws StripesJspException{
        String pageName = (String) pageContext.getAttribute(NCConstants.JSP_PAGE_NAME_ATTRIBUTE);
        if (Str.isEmpty(pageName)) {
            StripesJspException jspe = new StripesJspException("Trying to render secured text, but pagename has not been specified. Please specify the pagename");
            LOG.error(jspe);
            throw jspe;
        }
        return pageName;
    }

    /**
     * @param string string to be replaced
     * @return string with all index removed
     */
    public String removeArrayIndex(String string){
        Pattern pattern = Pattern.compile("\\[[\\d]+\\]");
        Matcher matcher = pattern.matcher(string);
        String finalStr=null;

        while (matcher.find()) {
            finalStr=matcher.replaceAll("[]");
        }

        if (finalStr == null) {
            finalStr=string;
        }
        return finalStr;
    }

}
