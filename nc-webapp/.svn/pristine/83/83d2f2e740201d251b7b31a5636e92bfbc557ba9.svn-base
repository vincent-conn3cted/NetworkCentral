package au.com.toyota.nc.webapp.stripes.dealerLocations;

import au.com.toyota.nc.common.locations.ChangeLocationTypeOperation;
import au.com.toyota.nc.common.locations.exceptions.ChangeLocationTypeException;
import au.com.toyota.nc.common.locations.exceptions.InvalidLocationException;
import au.com.toyota.nc.common.locations.impl.ChangeLocationTypeOperationFactory;
import au.com.toyota.nc.common.model.hibernate.Location;
import au.com.toyota.nc.common.model.hibernate.LocationType;
import au.com.toyota.nc.webapp.stripes.BaseActionBean;
import net.sourceforge.stripes.action.ForwardResolution;
import net.sourceforge.stripes.action.HandlesEvent;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.integration.spring.SpringBean;

import java.util.ArrayList;
import static java.util.Arrays.asList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ChangeLocationTypeActionBean extends BaseActionBean
{
    @SpringBean
    private ChangeLocationTypeOperationFactory changeLocationTypeOperationFactory;

    private Long locationId;

    private LocationType newLocationType;

    private Boolean showAsReadOnly;

    private String lastTabShown;

    private String newSapCode;

    private Long replacementLocationId;

    @HandlesEvent("show")
    public Resolution show()
    {
        return new ForwardResolution(JSP_BASE + "/location/changetype/show.jsp");
    }

    @HandlesEvent("change")
    public Resolution change() throws InvalidLocationException
    {
        try
        {
            final ChangeLocationTypeOperation operation = changeLocationTypeOperationFactory.createInstance(locationId, replacementLocationId, newLocationType, newSapCode);
            locationTopology.changeLocationType(operation);
            addLocalizableGlobalMessage("location.type.change.success", newLocationType);
        }
        catch (ChangeLocationTypeException e)
        {
            addSimpleGlobalWarning(e.getMessage());
        }
        return createChangedLocationResolution();
    }

    private Resolution createChangedLocationResolution() throws InvalidLocationException
    {
        final String targetTab;
        final Location location = locationDBService.fetchLocation(locationId);
        if(location.getType().isSupportLocation())
        {
            targetTab = ManageLocationActionBean.EVENT_SHOW_SUPPORT_LOCATION;
        }
        else
        {
            targetTab = ManageLocationActionBean.EVENT_SHOW_GENERAL_INFORMATION;
        }
        final Resolution resolution = new ForwardResolution(ManageLocationActionBean.class, ManageLocationActionBean.EVENT_DISPLAY_TAB)
                .addParameter("location.locationId", locationId).addParameters(getParametersOnTabSwitch(targetTab));
        return resolution;
    }

    protected Map<String, Object> getParametersOnTabSwitch(String lastTabShown)
    {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put(ManageLocationActionBean.REQUEST_LAST_TAB_SHOWN, lastTabShown);
        params.put(ManageLocationActionBean.REQUEST_READ_ONLY_MODE, getShowAsReadOnly());
        params.put(ManageLocationActionBean.REQUEST_PARAM_LOCATION_ID, locationId);
        return params;
    }

    public Location getLocation() throws InvalidLocationException
    {
        return locationDBService.fetchLocation(locationId);
    }

    public List<Location> getReplacementLocations() throws InvalidLocationException
    {
        final List<Location> dealersLocations;
        if(getLocation().getDealer().getGeneralInfo().getStatus().isActive())
        {
            dealersLocations = new ArrayList<Location>(getLocation().getDealer().getActiveNonPrincipalLocations());
        }
        else
        {
            dealersLocations = new ArrayList<Location>(getLocation().getDealer().getLocations());
        }
        dealersLocations.remove(getLocation());
        return dealersLocations;
    }

    public List<LocationType> getNewLocationTypes()
    {
        final List<LocationType> locationTypeList = new ArrayList<LocationType>(asList(LocationType.values()));
        locationTypeList.remove(LocationType.Principal);
        return locationTypeList;
    }

    public String getLastTabShown()
    {
        return lastTabShown;
    }

    public void setLastTabShown(String lastTabShown)
    {
        this.lastTabShown = lastTabShown;
    }

    public Boolean getShowAsReadOnly()
    {
        return showAsReadOnly;
    }

    public void setShowAsReadOnly(Boolean showAsReadOnly)
    {
        this.showAsReadOnly = showAsReadOnly;
    }

    public Long getLocationId()
    {
        return locationId;
    }

    public void setLocationId(Long locationId)
    {
        this.locationId = locationId;
    }

    public LocationType getNewLocationType()
    {
        return newLocationType;
    }

    public void setNewLocationType(LocationType newLocationType)
    {
        this.newLocationType = newLocationType;
    }

    public String getNewSapCode()
    {
        return newSapCode;
    }

    public void setNewSapCode(String newSapCode)
    {
        this.newSapCode = newSapCode;
    }

    public Long getReplacementLocationId()
    {
        return replacementLocationId;
    }

    public void setReplacementLocationId(Long replacementLocationId)
    {
        this.replacementLocationId = replacementLocationId;
    }
}
