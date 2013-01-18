package au.com.toyota.nc.webapp.stripes.admin;

import java.util.List;

import net.sourceforge.stripes.action.DefaultHandler;
import net.sourceforge.stripes.action.DontValidate;
import net.sourceforge.stripes.action.ForwardResolution;
import net.sourceforge.stripes.action.HandlesEvent;
import net.sourceforge.stripes.action.RedirectResolution;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.validation.Validate;
import net.sourceforge.stripes.validation.ValidateNestedProperties;
import net.sourceforge.stripes.validation.ValidationErrorHandler;
import net.sourceforge.stripes.validation.ValidationErrors;

import org.apache.log4j.Logger;

import au.com.toyota.nc.common.dealers.exceptions.AddPmaException;
import au.com.toyota.nc.common.dealers.exceptions.DeletePmaException;
import au.com.toyota.nc.common.model.PMASearchRequest;
import au.com.toyota.nc.common.model.PMASearchResponse;
import au.com.toyota.nc.common.model.hibernate.PMA;
import au.com.toyota.nc.webapp.adapter.PMAJSONAdapter;
import au.com.toyota.nc.webapp.stripes.AjaxResolution;

/**
 * Stripes action bean to manage {@link PMA}
 * <p/>
 * User: Alex Wibowo
 * Date: 6/02/2009
 * Time: 15:32:17
 */
public class ManagePMAActionBean extends AdministrationActionBean implements ValidationErrorHandler {
    private static final Logger LOGGER = Logger.getLogger(ManagePMAActionBean.class.getName());

    public static final String EVENT_LIST = "listPMA";
    public static final String EVENT_GET = "getPMA";
    public static final String EVENT_GET_JSON = "getJSONPMA";
    public static final String EVENT_SAVE = "savePMA";
    public static final String EVENT_ADD = "addPMA";
    public static final String EVENT_VIEW_OPEN_POINTS = "viewOpenPoints";

    private static final String MAINTAIN_PMA_JSP = ADMIN_JSP_BASE + "/maintainPMA.jsp";

    @ValidateNestedProperties({
        @Validate(field="name", required=true, on=EVENT_SAVE, maxlength = PMA.MAX_PMA_NAME),
        @Validate(field="code", required=true, on=EVENT_SAVE, maxlength = PMA.MAX_PMA_CODE)
    })
    private PMA pma;

    private PMASearchRequest searchRequest;

    private boolean displayForm = false;

    private static final String REQUEST_PARAM_PMA_ID = "pma.pmaId";

    /**
     * List out all {@link PMA}
     */
    @DefaultHandler
    @HandlesEvent(EVENT_LIST)
    public Resolution displayPMA() {
        return new ForwardResolution(MAINTAIN_PMA_JSP);
    }

    @DontValidate
    @HandlesEvent(EVENT_ADD)
    public Resolution addPMA() {
        displayForm = true;
        return displayPMA();
    }

    /**
     * Get PMA with the given ID
     */
    @HandlesEvent(EVENT_GET)
    public Resolution getPMA() {
        if (pma == null || pma.getPmaId() == null) {
            addLocalizableValidationError("pma.pmaId", "error.pma.id.required");
            return displayPMA();
        }


        pma = pmaService.getPMA(pma.getPmaId());
        if (pma == null) {
            addLocalizableValidationError("pma.pmaId", "error.model.notfound", "PMA");
        } else {
            displayForm = true;
        }
        return displayPMA();
    }

    /**
     * Get PMA for the given search request
     */
    @HandlesEvent(EVENT_GET_JSON)
    public Resolution getJSONPMA() {
        PMASearchResponse response = pmaService.findActivePma(this.searchRequest);
        return new AjaxResolution(new PMAJSONAdapter(response).toJSONObject());
    }

    /**
     * Save/Update {@link #pma}
     *
     * @return redirect resolution to get the edited PMA
     */
    @HandlesEvent(EVENT_SAVE)
    public Resolution savePMA() {
        try {
            pma=pmaService.savePMA(pma);
            addLocalizableGlobalMessage("message.save.success");
            return new RedirectResolution(getClass(),EVENT_GET).addParameter(REQUEST_PARAM_PMA_ID,pma.getPmaId());
        } catch (AddPmaException e) {
        	displayForm = true;
            addSimpleValidationError("pma.code", e.getMessage() );
            return context.getSourcePageResolution();
        }
    }

    @HandlesEvent(EVENT_VIEW_OPEN_POINTS)
    public Resolution viewOpenPoints() {
        List<PMA> openPointsPMA = pmaService.findOpenPointsPMA();
        context.setRequestAttribute("openPointsPMA", openPointsPMA);
        return new ForwardResolution(ADMIN_JSP_BASE + "/viewOpenPointsPMA.jsp");
    }

    @HandlesEvent("discontinue")
    public Resolution discontinue()
    {
        pmaService.discontinue(pma.getPmaId());
        return new RedirectResolution(ManagePMAActionBean.class, "displayPMA");
    }

    @HandlesEvent("delete")
    public Resolution delete()
    {
        Resolution resolution;
        try
        {
            pmaService.delete(pma.getPmaId());
            resolution = new RedirectResolution(ManagePMAActionBean.class, "displayPMA");
        }
        catch (DeletePmaException e)
        {
            addSimpleGlobalError(e.getMessage());
            resolution = new ForwardResolution(MAINTAIN_PMA_JSP);
        }
        return resolution;
    }

    public PMA getPma() {
        return pma;
    }

    public void setPma(PMA pma) {
        this.pma = pma;
    }

    public boolean isDisplayForm() {
        return displayForm;
    }

    public void setDisplayForm(boolean displayForm) {
        this.displayForm = displayForm;
    }

    public PMASearchRequest getSearchRequest() {
        return searchRequest;
    }

    public void setSearchRequest(PMASearchRequest searchRequest) {
        this.searchRequest = searchRequest;
    }

    public Resolution handleValidationErrors(ValidationErrors errors) throws Exception {
        // On validation error, display the form
        displayForm = true;
        return context.getSourcePageResolution();
    }
    
    /**
     * Get the actual username from the toyota LDAP using the T/K number or the dealer name.  
     * @return The actual name from e-Dir
     */
    public String getLastMaintainedUserNameFromLDAP() {
    	return getLastMaintainedUserName(pma);
    }
    
}
