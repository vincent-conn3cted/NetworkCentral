package au.com.toyota.nc.webapp.stripes.reports.impl;

import java.util.List;

import au.com.toyota.nc.webapp.stripes.reports.NetworkSummaryTableEntity;
import org.apache.commons.lang.math.NumberUtils;

/**
 * User: Alex Ooi
 * Date: 27/04/2009
 * Time: 12:30:37
 */
public abstract class AbstractNetworkSummaryTableEntity implements NetworkSummaryTableEntity
{
    protected final List<NetworkSummaryTableEntity> dealershipEntities;
    private String principalAndBranches;
    private String dealerships;
    private String branches;
    private String satelliteServices;
    private String otherLocations;
    private String metro;
    private String rural;

    public AbstractNetworkSummaryTableEntity(List<NetworkSummaryTableEntity> dealershipEntities)
    {
        this.dealershipEntities = dealershipEntities;
    }

    public String getPrincipalAndBranches()
    {
        return principalAndBranches;
    }

    public String getDealerships()
    {
        return dealerships;
    }

    public String getBranches()
    {
        return branches;
    }

    public String getSatelliteServices()
    {
        return satelliteServices;
    }

    public String getOtherLocations()
    {
        return otherLocations;
    }

    public String getMetro()
    {
        return metro;
    }

    public String getRural()
    {
        return rural;
    }

    public boolean getHasChildren()
    {
        return dealershipEntities.size() > 0;
    }

    public List<NetworkSummaryTableEntity> getChildren()
    {
        return dealershipEntities;
    }

    protected void calculateAggregateStatistics(List<NetworkSummaryTableEntity> dealershipEntities)
    {
        int tmpPricipalAndBranches = 0;
        int tmpDealerships = 0;
        int tmpBranches = 0;
        int tmpSatelliteServices = 0;
        int tmpOtherLocations = 0;
        int tmpMetros = 0;
        int tmpRurals = 0;
        for (NetworkSummaryTableEntity dealershipEntity : dealershipEntities)
        {
            tmpPricipalAndBranches = tmpPricipalAndBranches + parseNumberWithZeroAsDefault(dealershipEntity.getPrincipalAndBranches());
            tmpDealerships = tmpDealerships + parseNumberWithZeroAsDefault(dealershipEntity.getDealerships());
            tmpBranches = tmpBranches + parseNumberWithZeroAsDefault(dealershipEntity.getBranches());
            tmpSatelliteServices = tmpSatelliteServices + parseNumberWithZeroAsDefault(dealershipEntity.getSatelliteServices());
            tmpMetros = tmpMetros + parseNumberWithZeroAsDefault(dealershipEntity.getMetro());
            tmpRurals = tmpRurals + parseNumberWithZeroAsDefault(dealershipEntity.getRural());
            tmpOtherLocations = tmpOtherLocations + parseNumberWithZeroAsDefault(dealershipEntity.getOtherLocations());
        }
        principalAndBranches = "" + tmpPricipalAndBranches;
        dealerships = "" + tmpDealerships;
        branches = "" + tmpBranches;
        satelliteServices = "" + tmpSatelliteServices;
        otherLocations = "" + tmpOtherLocations;
        metro = "" + tmpMetros;
        rural = "" + tmpRurals;
    }

    private int parseNumberWithZeroAsDefault(String value)
    {
        int parsedValue = 0;
        if(NumberUtils.isNumber(value))
        {
            parsedValue = Integer.parseInt(value);
        }
        return parsedValue;
    }

    public String getStyleName()
    {
        return "";
    }
}
