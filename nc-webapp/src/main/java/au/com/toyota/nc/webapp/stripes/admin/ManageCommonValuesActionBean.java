package au.com.toyota.nc.webapp.stripes.admin;

import java.util.List;

import net.sourceforge.stripes.action.DefaultHandler;
import net.sourceforge.stripes.action.ForwardResolution;
import net.sourceforge.stripes.action.HandlesEvent;
import net.sourceforge.stripes.action.RedirectResolution;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.validation.Validate;
import net.sourceforge.stripes.validation.ValidateNestedProperties;
import net.sourceforge.stripes.validation.ValidationErrorHandler;
import net.sourceforge.stripes.validation.ValidationErrors;

import org.apache.log4j.Logger;

import au.com.toyota.nc.common.dao.exceptions.InvalidCommonValueException;
import au.com.toyota.nc.common.model.SaveEditCommonValueRequest;
import au.com.toyota.nc.common.model.hibernate.CommonValue;
import au.com.toyota.nc.common.model.hibernate.CommonValueTypes;
import au.com.toyota.nc.common.services.exceptions.DeleteCommonValueException;

/**
 * Stripes ActionBean to manage common values
 * <p/>
 * User: Alex Wibowo
 * Date: 5/02/2009
 * Time: 13:21:20
 */
public class ManageCommonValuesActionBean extends AdministrationActionBean implements ValidationErrorHandler
{
    private static final Logger LOGGER = Logger.getLogger(ManageCommonValuesActionBean.class.getName());

    public static final String EVENT_ADD_VALUE = "addCommonValue";
    public static final String EVENT_LIST = "listCommonValues";
    public static final String EVENT_GET_VALUES_FOR_TYPE = "getValuesForType";
    public static final String EVENT_GET_VALUE = "getValue";
    public static final String EVENT_SAVE_VALUES_FOR_TYPE = "saveValuesForType";


    /**
     * Common value being edited
     */
    @ValidateNestedProperties({
        @Validate(field = "selectedType", required = true, on = EVENT_SAVE_VALUES_FOR_TYPE, maxlength = 30),
        @Validate(field = "code", required = true, on = EVENT_SAVE_VALUES_FOR_TYPE, maxlength = 30),
        @Validate(field = "description", required = true, on = EVENT_SAVE_VALUES_FOR_TYPE, maxlength = 60)
            })
    private SaveEditCommonValueRequest saveEditRequest;

    /**
     * The id of the selected common value, for viewing /editing
     */
    @Validate(required = true, on = {EVENT_GET_VALUE})
    private Long selectedCommonValueId;

    /**
     * Selected type for adding new common value *
     */
    @Validate(required = true, on = {EVENT_GET_VALUES_FOR_TYPE, EVENT_ADD_VALUE})
    private CommonValueTypes selectedType;

    /**
     * A list of all {@link CommonValue} for the selected type {@link #selectedType}
     */
    private List<CommonValue> valuesForType;

    private boolean displayForm = false;

    @DefaultHandler
    @HandlesEvent(EVENT_LIST)
    public Resolution maintainDropDown()
    {
        return new ForwardResolution(ADMIN_JSP_BASE + "/maintainDropDown.jsp");
    }

    /**
     * Fetch all {@link CommonValue} for the given {@link au.com.toyota.nc.common.model.SaveEditCommonValueRequest#selectedType}
     */
    @HandlesEvent(EVENT_GET_VALUES_FOR_TYPE)
    public Resolution getCommonValuesForType()
    {
        populateValuesForSelectedType();
        return new ForwardResolution(ADMIN_JSP_BASE + "/maintainDropDown.jsp");
    }


    /**
     * Display the page to add new common value
     */
    @HandlesEvent(EVENT_ADD_VALUE)
    public Resolution addCommonValue()
    {
        displayForm = true;
        saveEditRequest = new SaveEditCommonValueRequest();
        saveEditRequest.setSelectedType(selectedType);
        populateValuesForSelectedType();
        return new ForwardResolution(ADMIN_JSP_BASE + "/maintainDropDown.jsp");
    }

    /**
     * Save the {@link #saveEditRequest}, and redisplay the edit page
     */
    @HandlesEvent(EVENT_SAVE_VALUES_FOR_TYPE)
    public Resolution saveCommonValuesForType()
    {
        CommonValue value = saveEditRequest.toCommonValue();
        try
        {
            CommonValue savedValue = masterTableServices.save(value);
            return new RedirectResolution(this.getClass(), EVENT_GET_VALUE)
                    .addParameter("selectedCommonValueId", savedValue.getCommonValueId());
        }
        catch (InvalidCommonValueException e)
        {
            setDisplayForm(true);
            populateValuesForSelectedType();
            addSimpleGlobalError(e.getMessage());
            return context.getSourcePageResolution();
        }
    }

    /**
     * Get {@link CommonValue} for the given {@link au.com.toyota.nc.common.model.SaveEditCommonValueRequest#commonValueId}
     */
    @HandlesEvent(EVENT_GET_VALUE)
    public Resolution getCommonValue()
    {
        CommonValue value = masterTableServices.get(selectedCommonValueId);
        selectedType = CommonValueTypes.valueOf(value.getType());

       	saveEditRequest = new SaveEditCommonValueRequest();
       	saveEditRequest.setCommonValueId(value.getCommonValueId());
       	saveEditRequest.setStartDate(value.getValidDate() != null ? value.getValidDate().getStartDate() : null);
       	saveEditRequest.setEndDate(value.getValidDate() != null ? value.getValidDate().getEndDate() : null);
       	saveEditRequest.setCode(value.getValue());
       	saveEditRequest.setDescription(value.getDescription());
       	saveEditRequest.setSelectedType(selectedType);
       	saveEditRequest.setUserCn(value.getUserCn());
       	saveEditRequest.setModifiedDate(value.getMaintenanceDateAsString());

        dbServices.evictObject(value);

        displayForm = true;
        populateValuesForSelectedType();
        return new ForwardResolution(ADMIN_JSP_BASE + "/maintainDropDown.jsp");
    }

    @HandlesEvent("discontinue")
    public Resolution discontinue()
    {
        masterTableServices.discontinue(selectedCommonValueId);
        final Resolution redirectResolution = new RedirectResolution(ManageCommonValuesActionBean.class, EVENT_GET_VALUES_FOR_TYPE).
                addParameter("selectedType", selectedType).flash(this);
        return redirectResolution;
    }

    @HandlesEvent("delete")
    public Resolution delete()
    {
        Resolution resolution;
        try
        {
            masterTableServices.delete(selectedCommonValueId);
            resolution = new RedirectResolution(ManageCommonValuesActionBean.class, EVENT_GET_VALUES_FOR_TYPE).
                    addParameter("selectedType", selectedType).flash(this);
        }
        catch (DeleteCommonValueException e)
        {
            populateValuesForSelectedType();
            addSimpleGlobalError(e.getMessage());
            resolution = new ForwardResolution(ADMIN_JSP_BASE + "/maintainDropDown.jsp");
        }
        return resolution;
    }

    public SaveEditCommonValueRequest getSaveEditRequest()
    {
        return saveEditRequest;
    }

    public void setSaveEditRequest(SaveEditCommonValueRequest saveEditRequest)
    {
        this.saveEditRequest = saveEditRequest;
    }


    public CommonValueTypes getSelectedType()
    {
        return selectedType;
    }

    public void setSelectedType(CommonValueTypes selectedType)
    {
        this.selectedType = selectedType;
    }

    public Long getSelectedCommonValueId()
    {
        return selectedCommonValueId;
    }

    public void setSelectedCommonValueId(Long selectedCommonValueId)
    {
        this.selectedCommonValueId = selectedCommonValueId;
    }

    public List<CommonValue> getValuesForType()
    {
        return valuesForType;
    }

    public void setValuesForType(List<CommonValue> valuesForType)
    {
        this.valuesForType = valuesForType;
    }

    public boolean isDisplayForm()
    {
        return displayForm;
    }

    public void setDisplayForm(boolean displayForm)
    {
        this.displayForm = displayForm;
    }

    private void populateValuesForSelectedType()
    {
        if (selectedType != null)
        {
            valuesForType = masterTableServices.findAll(selectedType.getClazz());
        }
    }

    public Resolution handleValidationErrors(ValidationErrors errors) throws Exception
    {
        populateValuesForSelectedType();

        if (saveEditRequest != null)
        {
            // Only display the form, if there's one - e.g. validation error might occur because user hasnt really
            // selected common value for editing, and click 'edit'. In such case, we dont want to display the form.
            displayForm = true;
        }
        return context.getSourcePageResolution();
    }	
    
    /**
     *  Get the actual username from the toyota LDAP using the T/K number or the dealer name.  
     * @return The actual name from e-Dir
     */
    public String getLastMaintainedUserNameFromLDAP() {
    	return getLastMaintainedUserName(saveEditRequest.toCommonValue());
    }
    
}
