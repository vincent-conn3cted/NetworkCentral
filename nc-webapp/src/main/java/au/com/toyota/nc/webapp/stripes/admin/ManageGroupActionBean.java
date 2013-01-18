package au.com.toyota.nc.webapp.stripes.admin;

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

import au.com.toyota.nc.common.dealers.group.DeleteGroupException;
import au.com.toyota.nc.common.model.hibernate.AbstractContact;
import au.com.toyota.nc.common.model.hibernate.Group;
import au.com.toyota.nc.webapp.stripes.ext.converters.PhoneNumberConverter;

/**
 * Stripes action bean to manage {@link Group}
 * <p/>
 * User: Alex Wibowo
 * Date: 10/02/2009
 * Time: 1:06:53 PM
 */
public class ManageGroupActionBean extends AdministrationActionBean implements ValidationErrorHandler
{
    private static final Logger LOG = Logger.getLogger(ManageGroupActionBean.class.getName());

    public static final String EVENT_LIST = "listGroup";
    public static final String EVENT_GET = "getGroup";
    public static final String EVENT_SAVE = "saveGroup";
    public static final String EVENT_ADD = "addGroup";

    /**
     * Group Id as request parameter
     */
    private static final String REQUEST_PARAM_GROUP_ID = "group.groupId";

    @ValidateNestedProperties({
        @Validate(field = "name", required = true, on = EVENT_SAVE, maxlength = Group.MAX_NAME),
        @Validate(field = "abn", maxlength = Group.MAX_ABN),
        @Validate(field = "acn", maxlength = Group.MAX_ACN),

        @Validate(field = "contact.streetAddress.address1", maxlength = AbstractContact.Address.MAX_ADDRESS1),
        @Validate(field = "contact.streetAddress.address2", maxlength = AbstractContact.Address.MAX_ADDRESS2),
        @Validate(field = "contact.streetAddress.suburb", maxlength = AbstractContact.Address.MAX_SUBURB),
        @Validate(field = "contact.streetAddress.postCode", maxlength = AbstractContact.Address.MAX_POSTCODE),

        @Validate(field = "contact.poBoxAddress.address1", maxlength = AbstractContact.Address.MAX_POBOX_ADDRESS),
        @Validate(field = "contact.poBoxAddress.suburb", maxlength = AbstractContact.Address.MAX_SUBURB),
        @Validate(field = "contact.poBoxAddress.postCode", maxlength = AbstractContact.Address.MAX_POSTCODE),

        @Validate(field = "contact.website", maxlength = AbstractContact.MAX_WEBSITE),
        @Validate(field = "contact.email", maxlength = AbstractContact.MAX_EMAIL),
        @Validate(field = "contact.phone", maxlength = AbstractContact.MAX_PHONE, required=false, converter = PhoneNumberConverter.class),
        @Validate(field = "contact.fax", maxlength = AbstractContact.MAX_FAX, required=false, converter = PhoneNumberConverter.class),

        @Validate(field = "frameworkAgreementTerm", maxlength = Group.MAX_AGREEMENT_TERM)
            })
    private Group group;

    private boolean displayForm = false;
    private static final String MAINTAIN_GROUP_JSP = ADMIN_JSP_BASE + "/maintainGroup.jsp";

    /**
     * List out all {@link Group)
     */
    @DefaultHandler
    @HandlesEvent(EVENT_LIST)
    public Resolution displayGroup()
    {
        return new ForwardResolution(MAINTAIN_GROUP_JSP);
    }


    /**
     * Display page to add new group
     *
     * @return Resolution to page to add group
     */
    @HandlesEvent(EVENT_ADD)
    public Resolution addGroup()
    {
        displayForm = true;
        return displayGroup();
    }

    /**
     * Fetch the requested group {@link Group#groupId}, and set it to {@link #group}
     *
     * @return Resolution to page for editing group
     */
    @HandlesEvent(EVENT_GET)
    public Resolution getGroupForEdit()
    {
        if (group == null || group.getGroupId() == null)
        {
            addLocalizableValidationError("group.groupId", "/admin/ManageGroup.action.edit.groupId.required");
            return displayGroup();
        }

        group = groupServices.get(group.getGroupId());
        if (group == null)
        {
            addLocalizableValidationError("group.groupId", "error.model.notfound", "Group");
        }
        else
        {
            displayForm = true;
        }
        return displayGroup();
    }

    /**
     * Save {@link #group}
     *
     * @return RedirectResolution to event handler to get group with the same id
     */
    @HandlesEvent(EVENT_SAVE)
    public Resolution saveGroup()
    {
        group = groupServices.save(group);
        addLocalizableGlobalMessage("message.save.success");
        return new RedirectResolution(this.getClass(), EVENT_GET).addParameter("group.groupId", group.getGroupId());
    }

    @HandlesEvent("discontinue")
    public Resolution discontinue()
    {
        groupServices.discontinue(group.getGroupId());
        return new RedirectResolution(this.getClass(), "displayGroup");
    }

    @HandlesEvent("delete")
    public Resolution delete()
    {
        Resolution resolution;
        try
        {
            groupServices.delete(group.getGroupId());
            resolution = new RedirectResolution(this.getClass(), "displayGroup");
        }
        catch (DeleteGroupException e)
        {
            addSimpleGlobalError(e.getMessage());
            resolution = new ForwardResolution(MAINTAIN_GROUP_JSP);
        }
        return resolution;
    }

    /**
     * Fetch the group prior to updating/saving a group.
     * This is necessary, because Hibernate will increment the version on group otherwise. We think its because Stripes creates
     * a new instance of the object everytime - although test case disprove that.
     * Also note that the version on the group contact still gets incremented, again because of the way Stripes work.
     */
    /*  @Before(stages = LifecycleStage.BindingAndValidation)
    public void fetchGroup() {
        if (isGroupIdPresent()) {
            LOG.info(MessageFormat.format("Group ID is present as [{0}], trying to bind to action bean", getRequestGroupId()));
            group = groupServices.getGroup(Long.parseLong(getRequestGroupId()));
        }
    }*/
    private String getRequestGroupId()
    {
        return context.getRequest().getParameter(REQUEST_PARAM_GROUP_ID);
    }

    public Group getGroup()
    {
        return group;
    }

    public void setGroup(Group group)
    {
        this.group = group;
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
        displayForm = true;
        return context.getSourcePageResolution();
    }
    
    /**
     * Get the actual username from the toyota LDAP using the T/K number or the dealer name.  
     * @return The actual name from e-Dir
     */
    public String getLastMaintainedUserNameFromLDAP() {
    	return getLastMaintainedUserName(group);
    }
}
