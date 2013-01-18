package au.com.toyota.nc.webapp.stripes.admin;

import java.util.ArrayList;
import java.util.List;

import net.sourceforge.stripes.action.DefaultHandler;
import net.sourceforge.stripes.action.DontValidate;
import net.sourceforge.stripes.action.ForwardResolution;
import net.sourceforge.stripes.action.HandlesEvent;
import net.sourceforge.stripes.action.RedirectResolution;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.integration.spring.SpringBean;
import net.sourceforge.stripes.validation.LocalizableError;
import net.sourceforge.stripes.validation.Validate;
import net.sourceforge.stripes.validation.ValidateNestedProperties;
import net.sourceforge.stripes.validation.ValidationErrorHandler;
import net.sourceforge.stripes.validation.ValidationErrors;
import net.sourceforge.stripes.validation.ValidationMethod;

import org.apache.log4j.Logger;

import au.com.toyota.nc.common.dao.CommonValueDAO;
import au.com.toyota.nc.common.model.DateRange;
import au.com.toyota.nc.common.model.DateRangeException;
import au.com.toyota.nc.common.model.hibernate.Position;
import au.com.toyota.nc.common.model.hibernate.PositionDefinition;
import au.com.toyota.nc.common.staff.PositionTopology;
import au.com.toyota.nc.common.staff.exceptions.DeletePositionException;
import au.com.toyota.nc.common.staff.exceptions.InvalidPositionException;
import au.com.toyota.nc.common.utils.ListUtils;

/**
 * Stripes action bean to manage {@link Position}
 * <p/>
 * User: Alex Wibowo
 * Date: 7/02/2009
 * Time: 13:02:12
 */
public class ManagePositionTypesActionBean extends AdministrationActionBean implements ValidationErrorHandler
{
    private static final Logger LOG = Logger.getLogger(ManagePositionTypesActionBean.class.getName());

    public static final String PROPERTYNAME_POSITION = "position";

    public static final String EVENT_LIST = "listPositionType";
    public static final String EVENT_GET = "getPositionType";
    public static final String EVENT_SAVE = "savePositionType";
    public static final String EVENT_ADD = "addPositionType";
    private static final String EVENT_DELETE = "delete";

    private static final String MAINTAIN_POSITION_TYPES_JSP = ADMIN_JSP_BASE + "/maintainPositionTypes.jsp";

    @SpringBean
    private PositionTopology positionTopology;

    @SpringBean
    private CommonValueDAO commonValueDAO;
    
    @ValidateNestedProperties({
        @Validate(field = "description", required = true, on = EVENT_SAVE, maxlength = Position.MAX_DESCRIPTION),
        @Validate(field = "abbreviation", on = EVENT_SAVE, maxlength = Position.MAX_ABBREVIATION),
        @Validate(field = "sortOrderExcel", mask = MASK_NUMERIC_ONLY, on = EVENT_SAVE, maxlength = Position.MAX_SORT_ORDER_EXEL),
        @Validate(field = "sortOrderHardCopy", mask = MASK_NUMERIC_ONLY, on = EVENT_SAVE, maxlength = Position.MAX_SORT_ORDER_HARDCOPY),
        @Validate(field = "sortOrderMailMerge", mask = MASK_NUMERIC_ONLY, on = EVENT_SAVE, maxlength = Position.MAX_SORT_ORDER_MAILMERGE)
            })
    private Position position;

    private boolean displayForm = false;

    /**
     * List out all {@link Position}
     */
    @DefaultHandler
    @HandlesEvent(EVENT_LIST)
    public Resolution displayPositionTypes()
    {
        return new ForwardResolution(MAINTAIN_POSITION_TYPES_JSP);
    }


    /**
     * Add new {@link Position}
     */
    @DontValidate
    @HandlesEvent(EVENT_ADD)
    public Resolution addPositionType()
    {
        setDisplayForm(true);
        return displayPositionTypes();
    }


    /**
     * Get Position Type with the given {@link Position#positionId}
     */
    @HandlesEvent(EVENT_GET)
    public Resolution getPositionType()
    {
        // Ensure position id is supplied
        if (position == null || position.getPositionId() == null)
        {
            addLocalizableValidationError("position.positionId", "/admin/ManagePositionTypes.action.edit.positionId.required");
            return displayPositionTypes();
        }

        // Try to find the position with the given id
        position = positionService.get(position.getPositionId());
        if (position == null)
        {
            addLocalizableValidationError("position.positionId", "error.model.notfound", "Position Type");
        }
        else
        {
            setPositionDefinitionsIdsSelect(ListUtils.<Long, PositionDefinition>getFieldList(position.getPositionDefinitions(), "commonValueId"));
            setDisplayForm(true);
        }
        return displayPositionTypes();
    }

    /**
     * Save the given {@link #position}
     */
    @HandlesEvent(EVENT_SAVE)
    public Resolution savePositionType()
    {
        Resolution res;
        try
        {
            position.setPositionDefinitions(getPositionDefinitionsByProvidedIds(getPositionDefinitionsIdsSelect()));
        	position = positionTopology.save(position);
            addLocalizableGlobalMessage("message.save.success");
            res = createRedirectToGetResolution();
        }
        catch (InvalidPositionException e)
        {
            setDisplayForm(true);
            addSimpleGlobalError(e.getMessage());
            res = context.getSourcePageResolution();
        }
        return res;
    }

	@HandlesEvent("discontinue")
    public Resolution discontinue()
    {
        positionTopology.discontinue(position.getPositionId());
        addLocalizableGlobalMessage("position.message.discontinued.success");
        return createRedirectToGetResolution();
    }

    @HandlesEvent(EVENT_DELETE)
    public Resolution delete()
    {
        Resolution resolution;
        try
        {
            positionService.delete(position.getPositionId());
            resolution = new RedirectResolution(ManagePositionTypesActionBean.class, "displayPositionTypes");
        }
        catch (DeletePositionException e)
        {
            addSimpleGlobalError(e.getMessage());
            resolution = new ForwardResolution(MAINTAIN_POSITION_TYPES_JSP);
        }
        return resolution;
    }

    @ValidationMethod(on = EVENT_SAVE)
    public void validateBeforeSave(ValidationErrors errors)
    {
    	validateDateRange(errors);
    	validateSAPAttributes(errors);
    	validateNumberOfPositionDefinitions(errors);
    }
    
    private void validateNumberOfPositionDefinitions(ValidationErrors errors) 
    {
        if(position == null)
        	return;
        
        List<Long> positionDefinitionsIds = getPositionDefinitionsIdsSelect();
		if(positionDefinitionsIds == null || positionDefinitionsIds.size() == 0)
			errors.addGlobalError(new LocalizableError("error.position.definition.required"));
	}


	private void validateDateRange(ValidationErrors errors)
    {
        try
        {
            DateRange dr = new DateRange(position.getEffectiveDate(), position.getTerminationDate());
            dr.validate();
        }
        catch (DateRangeException e)
        {
        	errors.addGlobalError(new LocalizableError("error.invalid.daterange"));
        }
    }

    private List<PositionDefinition> getPositionDefinitionsByProvidedIds(List<Long> positionDefinitionsIdsSelect) 
    {
    	if(positionDefinitionsIdsSelect == null)
    		return null;
    	
    	List<PositionDefinition> positionDefinitions = new ArrayList<PositionDefinition>();
    	for(Long positionDefinitionId : positionDefinitionsIdsSelect)
    	{
    		positionDefinitions.add((PositionDefinition)commonValueDAO.get(positionDefinitionId));
    	}
    	return positionDefinitions;
	}

    private RedirectResolution createRedirectToGetResolution()
    {
        return new RedirectResolution(getClass(), EVENT_GET).addParameter("position.positionId", position.getPositionId());
    }

    public Position getPosition()
    {
        return position;
    }

    public void setPosition(Position position)
    {
        this.position = position;
    }

    public boolean isDisplayForm()
    {
        return displayForm;
    }

    public void setDisplayForm(boolean displayForm)
    {
        this.displayForm = displayForm;
    }

    public Resolution handleValidationErrors(ValidationErrors errors) throws Exception
    {
        // On validation error, display the form
        setDisplayForm(true);
        return context.getSourcePageResolution();
    }


    /**
     * User has to specify either both SAP category/position, or none of them
     */
    private void validateSAPAttributes(ValidationErrors errors)
    {
        if (position != null)
        {
            if (
                    (position.getSapSalesCategory() != null && position.getSapSalesPosition() == null) ||
                            (position.getSapSalesCategory() == null && position.getSapSalesPosition() != null)
                    )
            {
                errors.addGlobalError(new LocalizableError("/admin/ManagePositionTypes.action.missingSAPAttributes"));
            }
        }
    }

    public List<Position> getAllPosition()
    {
        return positionService.getAllPositions();
    }
    
    /**
     * Get the actual username from the toyota LDAP using the T/K number or the dealer name.  
     * @return The actual name from e-Dir
     */
    public String getLastMaintainedUserNameFromLDAP() {
    	return getLastMaintainedUserName(position);
    }

}
