package au.com.toyota.nc.webapp.stripes.ownershipEntity;

import au.com.toyota.nc.common.model.OwnershipEntitySearchRequest;
import au.com.toyota.nc.common.model.OwnershipEntitySearchResponse;
import au.com.toyota.nc.common.model.hibernate.OwnerEntityType;
import au.com.toyota.nc.common.ownerentity.OperatingEntityService;
import au.com.toyota.nc.webapp.decorator.RequestDecorator;
import au.com.toyota.nc.webapp.stripes.BaseActionBean;
import net.sourceforge.stripes.action.DefaultHandler;
import net.sourceforge.stripes.action.ForwardResolution;
import net.sourceforge.stripes.action.HandlesEvent;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.integration.spring.SpringBean;
import org.apache.log4j.Logger;

import javax.servlet.http.HttpSession;

/**
 * User: Deepthi Fernando
 * Date: 17/02/2009
 * Time: 11:19:32 AM
 */
public class OwnershipEntityActionBean extends BaseActionBean {
    private static final Logger LOG = Logger.getLogger(OwnershipEntityActionBean.class.getName());
    protected static String OWNER_ENTITY_TYPE="OwnerEntityType";
//    protected static String FORWARD_FROM="ForwardFrom";

    protected static String COMPANY="company.id";
    protected static String INDIVIDUAL="individual.id";
    protected static String DEALER_STAFF_ID="dealerStaff.personId";

    protected static String ABSTRACT_SHAREHOLDING="abstractShareholding";
    protected static String OWNED_COMPANY="ownedCompany";
    protected static String OWNER_COMPANY="ownerCompany";
    protected static String OWNER_INDIVIDUAL="ownerIndividual";

    protected static final String OWNERSHIP_JSP_BASE = JSP_BASE + "/ownershipEntity";


    protected Long getCompanyID(){
        if (getContext().getRequest().getParameter(COMPANY).equals("")) return null;
        else return new Long(getContext().getRequest().getParameter(COMPANY));
    }

    protected Long getIndividualID(){
        if (getContext().getRequest().getParameter(INDIVIDUAL) == null || getContext().getRequest().getParameter(INDIVIDUAL).equals("")) return null;
        else return new Long(getContext().getRequest().getParameter(INDIVIDUAL));
    }

    protected Long getDealerStaffID(){
        if (getContext().getRequest().getParameter(DEALER_STAFF_ID) == null || getContext().getRequest().getParameter(DEALER_STAFF_ID).equals("")) return null;
        else return new Long(getContext().getRequest().getParameter(DEALER_STAFF_ID));
    }

/*
    protected Long getIndividualID(){
        if (getContext().getRequest().getParameter(INDIVIDUAL) == null || getContext().getRequest().getParameter(INDIVIDUAL).equals("")) return null;
        else return new Long(getContext().getRequest().getParameter(INDIVIDUAL));
    }
*/


    /**
     * return Owner entity type from the request object
     * @return
     */
    protected OwnerEntityType getOwnerEntityType(){
        if (getContext().getRequest().getParameter(OWNER_ENTITY_TYPE).equals("")) return null;
        else return OwnerEntityType.valueOf(getContext().getRequest().getParameter(OWNER_ENTITY_TYPE));
    }

    /* return current Http session ore create new one, when no current session is available */
    protected HttpSession getHttpSession(){
        return getContext().getRequest().getSession(true);
    }

    // following method added to make it possible to read OWNER_COMPANY constant from Stripes
    public String getOWNER_COMPANY(){
        return OWNER_COMPANY;
    }

    // following method added to make it possible to read OWNER_INDIVIDUAL constant from Stripes
    public String getOWNER_INDIVIDUAL(){
        return OWNER_INDIVIDUAL;
    }

}