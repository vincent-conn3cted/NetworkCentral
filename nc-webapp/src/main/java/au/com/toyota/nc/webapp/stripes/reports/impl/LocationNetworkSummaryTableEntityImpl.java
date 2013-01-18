package au.com.toyota.nc.webapp.stripes.reports.impl;

import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.List;

import au.com.toyota.nc.common.model.hibernate.AbstractContact;
import au.com.toyota.nc.common.model.hibernate.Location;
import au.com.toyota.nc.webapp.stripes.reports.NetworkSummaryTableEntity;
import org.apache.commons.lang.StringUtils;

/**
 * User: Alex Ooi
 * Date: 24/04/2009
 * Time: 11:31:38
 */
public class LocationNetworkSummaryTableEntityImpl implements NetworkSummaryTableEntity
{
    private final Location location;

    public LocationNetworkSummaryTableEntityImpl(Location location)
    {
        this.location = location;
    }

    public List<String> getRowLabels()
    {
        final ArrayList<String> rowLabels = new ArrayList<String>();

        rowLabels.add(createLocationTitle());
        rowLabels.add("");
        appendLocationInfomation(rowLabels);
        appendAddressInformation(rowLabels);
        appendContactInformation(rowLabels);

        return rowLabels;
    }

    private void appendLocationInfomation(ArrayList<String> rowLabels)
    {
        rowLabels.add(location.getLocationName());
    }

    private void appendAddressInformation(ArrayList<String> rowLabels)
    {
        final AbstractContact.Address address = location.getContact().getStreetAddress();
        rowLabels.add(address.getAddress1() + " " + address.getAddress2());
        rowLabels.add(address.getSuburb() + " " + address.getState().getLabel() + " " + address.getPostCode());
    }

    private void appendContactInformation(ArrayList<String> rowLabels)
    {
        final String phone = location.getContact().getPhone();
        if (StringUtils.isNotBlank(phone))
        {
            rowLabels.add("Phone: " + phone);
        }
        final String fax = location.getContact().getFax();
        if (StringUtils.isNotBlank(fax))
        {
            rowLabels.add("Fax: " + fax);
        }
    }

    private String createLocationTitle()
    {
        final AbstractContact.Address address = location.getContact().getStreetAddress();
        return MessageFormat.format("{0} ({1}, {2})", location.getType().getDescription(), address.getSuburb(), address.getState().getLabel());
    }

    public String getPrincipalAndBranches()
    {
        return "";
    }

    public String getDealerships()
    {
        return "";
    }

    public String getBranches()
    {
        return "";
    }

    public String getSatelliteServices()
    {
        return "";
    }

    public String getOtherLocations()
    {
        return "";
    }

    public String getMetro()
    {
        return "";
    }

    public String getRural()
    {
        return "";
    }

    public boolean getHasChildren()
    {
        return false;
    }

    public List<NetworkSummaryTableEntity> getChildren()
    {
        return new ArrayList<NetworkSummaryTableEntity>();
    }

    public Location getLocation()
    {
        return location;
    }

    public String getStyleName()
    {
        String styleName = "locationRow";
        if (location.getType().isPrincipal())
        {
            styleName = "principalLocationRow";
        }
        return styleName;
    }
}
