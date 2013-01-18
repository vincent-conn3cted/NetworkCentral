package au.com.toyota.nc.webapp.stripes.ownershipEntity;

import net.sourceforge.stripes.action.Before;
import net.sourceforge.stripes.action.DefaultHandler;
import net.sourceforge.stripes.action.ForwardResolution;
import net.sourceforge.stripes.action.HandlesEvent;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.controller.LifecycleStage;
import net.sourceforge.stripes.validation.Validate;
import net.sourceforge.stripes.validation.ValidateNestedProperties;

import org.apache.log4j.Logger;

import au.com.toyota.nc.common.model.hibernate.Individual;

/**
 * User: Deepthi Fernando
 * Date: 7/04/2009
 * Time: 11:18:32 AM
 */
public class ViewIndividualEntityActionBean extends OwnershipEntityActionBean{
    private static final Logger LOG = Logger.getLogger(ViewIndividualEntityActionBean.class.getName());

    public static final String EVENT_VIEW_INDIVIDUAL = "viewIndividual";
    public static final String EVENT_SAVE_SHAREHOLDING = "saveShareholding";

    @ValidateNestedProperties({
        @Validate(field="shareholdings.numShares", required=false, minvalue = 0,maxlength = 12, mask=MASK_NUMERIC_ONLY, on=EVENT_SAVE_SHAREHOLDING)
    })
    private Individual individual = new Individual();

    @DefaultHandler
    @HandlesEvent(EVENT_VIEW_INDIVIDUAL)
    public Resolution viewIndividual() {
        individual = operatingEntityService.getIndividualShareholder(getIndividual().getId());
        return new ForwardResolution(OWNERSHIP_JSP_BASE + "/viewIndividual.jsp");
    }

    public Individual getIndividual() {
        return individual;
    }

    public void setIndividual(Individual individual) {
        this.individual = individual;
    }

    @HandlesEvent(EVENT_SAVE_SHAREHOLDING)
    public Resolution saveShareholding() {
        individual = operatingEntityService.saveIndividualShareholder(getIndividual());
        return new ForwardResolution(OWNERSHIP_JSP_BASE + "/viewIndividual.jsp");
    }

    /**
     *
     */
    @Before(stages = LifecycleStage.BindingAndValidation)
    public void loadIndividual(){
        if (getContext().getEventName().equals(EVENT_SAVE_SHAREHOLDING)){
                individual = operatingEntityService.getIndividualShareholder(getIndividualID());
        }
    }
    
    /**
     * Get the actual username from the toyota LDAP using the T/K number or the dealer name.  
     * @return The actual name from e-Dir
     */
    public String getLastMaintainedUserNameFromLDAP() {
    	return getLastMaintainedUserName(individual);
    }

}