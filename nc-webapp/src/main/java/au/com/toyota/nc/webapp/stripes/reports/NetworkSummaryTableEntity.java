package au.com.toyota.nc.webapp.stripes.reports;

import java.util.List;

/**
 * User: Alex Ooi
 * Date: 24/04/2009
 * Time: 09:16:51
 */
public interface NetworkSummaryTableEntity
{
    List<String> getRowLabels();

    String getPrincipalAndBranches();

    String getDealerships();

    String getBranches();

    String getSatelliteServices();

    String getOtherLocations();

    String getMetro();

    String getRural();

    boolean getHasChildren();

    List<NetworkSummaryTableEntity> getChildren();

    /**
     * The css style to apply to all values that are output as a result of the getRowLabels()
     */
    String getStyleName();
}
