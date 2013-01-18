package au.com.toyota.nc.webapp.stripes.reports.impl;

import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import au.com.toyota.nc.common.model.hibernate.Dealer;
import au.com.toyota.nc.common.model.hibernate.Location;
import au.com.toyota.nc.common.model.hibernate.PMA;
import au.com.toyota.nc.common.model.hibernate.Status;
import au.com.toyota.nc.webapp.stripes.reports.NetworkSummaryTableEntity;

/**
 * User: Alex Ooi
 * Date: 24/04/2009
 * Time: 09:13:50
 */
public class DealerNetworkSummaryTableEntityImpl implements NetworkSummaryTableEntity
{
    private final int principalAndBranches;

    private final Dealer dealer;

    private final int branches;

    private final int satelliteServices;

    private final int otherLocations;

    public DealerNetworkSummaryTableEntityImpl(Dealer dealer, int principalAndBranches, int branches, int satelliteServices, int otherLocations)
    {
        this.dealer = dealer;
        this.branches = branches;
        this.otherLocations = otherLocations;
        this.principalAndBranches = principalAndBranches;
        this.satelliteServices = satelliteServices;
    }

    public List<String> getRowLabels()
    {
        final PMA pma = dealer.getGeneralInfo().getPma();
        final String dealerName = dealer.getGeneralInfo().getDealerName();
        final String dealerCode = dealer.getGeneralInfo().getDealerCode();
        return Arrays.asList(MessageFormat.format("{0} ({1}, {2})", dealerName, pma.getName().toUpperCase(), dealerCode));
    }

    public String getPrincipalAndBranches()
    {
        return "" + principalAndBranches;
    }

    public String getDealerships()
    {
        return "1";
    }

    public String getBranches()
    {
        return "" + branches;
    }

    public String getSatelliteServices()
    {
        return "" + satelliteServices;
    }

    public String getOtherLocations()
    {
        return "" + otherLocations;
    }

    public String getMetro()
    {
        if (dealer.getGeneralInfo().getMetroFlag())
        {
            return "1";
        }
        else
        {
            return "0";
        }
    }

    public String getRural()
    {
        if (dealer.getGeneralInfo().getMetroFlag())
        {
            return "0";
        }
        else
        {
            return "1";
        }
    }

    public boolean getHasChildren()
    {
        return dealer.getLocations().size() > 0;
    }

    public List<NetworkSummaryTableEntity> getChildren()
    {
        final List<NetworkSummaryTableEntity> networkSummaryTableEntityArrayList = new ArrayList<NetworkSummaryTableEntity>();
        for (Location location : dealer.getLocations())
        {
            if (Status.Active.equals(location.getStatus()))
            {
                networkSummaryTableEntityArrayList.add(new LocationNetworkSummaryTableEntityImpl(location));
            }
        }
        Collections.sort(networkSummaryTableEntityArrayList, new LocationNetworkSummaryComparator());
        return networkSummaryTableEntityArrayList;
    }

    public String getStyleName()
    {
        return "";
    }
}
