package au.com.toyota.nc.webapp.stripes.dealerLocations;

import au.com.toyota.nc.common.model.DealerLocationSearchRequest;
import au.com.toyota.nc.common.model.hibernate.Dealer;
import au.com.toyota.nc.common.model.hibernate.Status;
import au.com.toyota.nc.webapp.stripes.BaseActionBean;

import java.util.Arrays;
import java.util.List;

public abstract class BaseDealerLocationActionBean extends BaseActionBean
{
    protected static final String DEALER_JSP_BASE = JSP_BASE + "/dealer";

    protected static final String LOCATION_JSP_BASE = JSP_BASE + "/location";

    public static final String EVENT_SCHEDULE_ACTIVATION = "scheduleActivation";
    public static final String EVENT_ACTIVATE = "activate";
    public static final String EVENT_SCHEDULE_DEACTIVATION = "scheduleDeactivation";
    public static final String EVENT_DEACTIVATE = "deactivate";

    /**
     * Indication on showing the page as read only
     */
    protected Boolean showAsReadOnly = Boolean.FALSE;

    protected static final String[] CHANGE_STATUS_EVENTS = new String[]{
            EVENT_SCHEDULE_ACTIVATION,
            EVENT_ACTIVATE,
            EVENT_SCHEDULE_DEACTIVATION,
            EVENT_DEACTIVATE
    };

    /**
     * @return all {@link au.com.toyota.nc.common.model.hibernate.Dealer} to create location to
     */
    public List<Dealer> getAllDealersForCreatingLocation()
    {
        return dealerDBService.findDealerLocation(DealerLocationSearchRequest.createSearchRequestForCreatingLocation()).getDealers();
    }

    public Boolean getShowAsReadOnly()
    {
        return showAsReadOnly;
    }

    public void setShowAsReadOnly(Boolean showAsReadOnly)
    {
        this.showAsReadOnly = showAsReadOnly;
    }

    public List<Status> getAllowedStatusSearchParameter()
    {
        List<Status> allowedStatuses = context.getUserRole().getAllowedStatusForDealerLocationSearch();
        // damn BAs ... they said that when searching for editing or in edit mode then ONLY NATIONAL ADMIN can see anything other than Active. seems to make sense to put here cos its UI logic
        if (!showAsReadOnly && !getContext().getUserRole().isNationalAdmin())
        {
            allowedStatuses = Arrays.asList(Status.Active);
        }
        return allowedStatuses;
    }

}
