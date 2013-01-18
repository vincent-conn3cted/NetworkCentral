package au.com.toyota.nc.webapp.stripes.admin;

import java.util.logging.Logger;

import net.sourceforge.stripes.action.DefaultHandler;
import net.sourceforge.stripes.action.ForwardResolution;
import net.sourceforge.stripes.action.HandlesEvent;
import net.sourceforge.stripes.action.RedirectResolution;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.validation.Validate;
import net.sourceforge.stripes.validation.ValidateNestedProperties;
import net.sourceforge.stripes.validation.ValidationErrorHandler;
import net.sourceforge.stripes.validation.ValidationErrors;
import au.com.toyota.nc.common.AbstractNCException;
import au.com.toyota.nc.common.model.hibernate.AbstractContact;
import au.com.toyota.nc.common.model.hibernate.DMSContactPerson;
import au.com.toyota.nc.common.model.hibernate.DMSProduct;
import au.com.toyota.nc.common.model.hibernate.DMSVendor;
import au.com.toyota.nc.common.services.exceptions.DeleteDmsVendorException;
import au.com.toyota.nc.webapp.adapter.DMSVendorJSONAdapter;
import au.com.toyota.nc.webapp.stripes.AjaxResolution;
import au.com.toyota.nc.webapp.stripes.ext.converters.PhoneNumberConverter;

/**
 * Stripes action bean to manage {@link DMSVendor}
 * <p/>
 * User: Alex Wibowo
 * Date: 11/02/2009
 * Time: 11:19:43 AM
 */
public class ManageDMSVendorActionBean extends AdministrationActionBean implements ValidationErrorHandler
{
    private static final Logger LOGGER = Logger.getLogger(ManageDMSVendorActionBean.class.getName());

    public static final String EVENT_LIST = "listVendor";
    public static final String EVENT_ADD = "addVendor";
    public static final String EVENT_SAVE = "saveVendor";
    public static final String EVENT_GET = "getVendor";
    public static final String EVENT_GET_JSON_VENDOR = "getJSONVendor";

    @ValidateNestedProperties({
        @Validate(field = "name", required = true, on = EVENT_SAVE, maxlength = DMSVendor.MAX_NAME),
        @Validate(field = "contacts.name", maxlength = DMSContactPerson.MAX_NAME),
        @Validate(field = "contacts.contact.streetAddress.address1", maxlength = AbstractContact.Address.MAX_ADDRESS1),
        @Validate(field = "contacts.contact.streetAddress.address2", maxlength = AbstractContact.Address.MAX_ADDRESS2),
        @Validate(field = "contacts.contact.phone", maxlength = AbstractContact.MAX_PHONE, required=false, converter = PhoneNumberConverter.class),
        @Validate(field = "products.name", maxlength = DMSProduct.MAX_NAME)
            })
    private DMSVendor vendor;

    private boolean displayForm = false;

    private static final String REQUEST_PARAM_DMS_VENDOR_ID = "vendor.dmsVendorId";
    private static final String MAINTAIN_DMS_VENDOR_JSP = ADMIN_JSP_BASE + "/maintainDMSVendor.jsp";

    /**
     * List out all DMSVendor
     */
    @DefaultHandler
    @HandlesEvent(EVENT_LIST)
    public Resolution listVendors()
    {
        return new ForwardResolution(MAINTAIN_DMS_VENDOR_JSP);
    }

    @HandlesEvent(EVENT_ADD)
    public Resolution addDMSVendor()
    {
        displayForm = true;
        return new ForwardResolution(MAINTAIN_DMS_VENDOR_JSP);
    }

    /**
     * Get DMSVendor with id {@link DMSVendor#dmsVendorId}
     */
    @HandlesEvent(EVENT_GET)
    public Resolution getDMSVendor()
    {
        if (vendor == null || vendor.getDmsVendorId() == null)
        {
            addLocalizableValidationError("dmsVendor.dmsVendorId", "error.dms.id.required");
            return listVendors();
        }

        vendor = dmsVendorServices.getDMSVendor(vendor.getDmsVendorId());
        if (vendor == null)
        {
            addLocalizableValidationError("dmsVendor.dmsVendorId", "error.model.notfound", "DMS Vendor");
        }
        else
        {
            displayForm = true;
        }
        return listVendors();
    }

    /**
     * Save/Update {@link #vendor}
     *
     * @return redirect resolution to get edited vendor
     */
    @HandlesEvent(EVENT_SAVE)
    public Resolution saveDMSVendor()
    {
        try {
            vendor = dmsVendorServices.saveDMSVendor(vendor);
            addLocalizableGlobalMessage("message.save.success");
            return new RedirectResolution(this.getClass(), EVENT_GET).addParameter(REQUEST_PARAM_DMS_VENDOR_ID, vendor.getDmsVendorId());
        } catch (AbstractNCException e) {
            addSimpleGlobalError(e.getMessage());
            return context.getSourcePageResolution();
        }
    }

    /**
     * @return {@link DMSVendor} as JSON object
     */
    @HandlesEvent(EVENT_GET_JSON_VENDOR)
    public Resolution getJSONVendor()
    {
        DMSVendor dmsVendor = dmsVendorServices.getDMSVendor(vendor.getDmsVendorId());
        return new AjaxResolution(new DMSVendorJSONAdapter(dmsVendor).toJSONObject());
    }

    @HandlesEvent("discontinue")
    public Resolution discontinue()
    {
        dmsVendorServices.discontinue(vendor.getDmsVendorId());
        return new RedirectResolution(ManageDMSVendorActionBean.class, EVENT_LIST);
    }

    @HandlesEvent("delete")
    public Resolution delete()
    {
        Resolution resolution;
        try
        {
            dmsVendorServices.delete(vendor.getDmsVendorId());
            resolution = new RedirectResolution(ManageDMSVendorActionBean.class, EVENT_LIST);
        }
        catch (DeleteDmsVendorException e)
        {
            addSimpleGlobalError(e.getMessage());
            resolution = new ForwardResolution(MAINTAIN_DMS_VENDOR_JSP);
        }
        return resolution;
    }

    public DMSVendor getVendor()
    {
        return vendor;
    }

    public void setVendor(DMSVendor vendor)
    {
        this.vendor = vendor;
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
     *  Get the actual username from the toyota LDAP using the T/K number or the dealer name.  
     * @return The actual name from e-Dir
     */
    public String getLastMaintainedUserNameFromLDAP() {
    	return getLastMaintainedUserName(vendor);
    }
    
}
