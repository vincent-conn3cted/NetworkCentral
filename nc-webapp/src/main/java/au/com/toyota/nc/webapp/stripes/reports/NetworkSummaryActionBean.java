package au.com.toyota.nc.webapp.stripes.reports;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import au.com.toyota.nc.common.model.hibernate.Region;
import au.com.toyota.nc.common.model.hibernate.State;
import au.com.toyota.nc.common.model.hibernate.ToyotaFranchise;
import au.com.toyota.nc.common.reports.networksummary.NetworkSummaryDealerStatistic;
import au.com.toyota.nc.common.reports.networksummary.NetworkSummaryService;
import au.com.toyota.nc.webapp.stripes.BaseActionBean;
import au.com.toyota.nc.webapp.stripes.reports.impl.DealerNetworkSummaryTableEntityImpl;
import au.com.toyota.nc.webapp.stripes.reports.impl.NetworkSummaryTotalTableEntity;
import au.com.toyota.nc.webapp.stripes.reports.impl.RegionNetworkSummaryTableEntityImpl;
import au.com.toyota.nc.webapp.stripes.reports.impl.StateNetworkSummaryTableEntityImpl;
import net.sourceforge.stripes.action.DefaultHandler;
import net.sourceforge.stripes.action.ForwardResolution;
import net.sourceforge.stripes.action.HandlesEvent;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.integration.spring.SpringBean;
import org.apache.log4j.Logger;

/**
 * User: Alex Ooi
 * Date: 24/04/2009
 * Time: 08:14:44
 */
public class NetworkSummaryActionBean extends BaseActionBean
{
    private static final Logger LOG = Logger.getLogger(NetworkSummaryActionBean.class);
    private static final String NETWORK_SUMMARY_PATH = JSP_BASE + "/reports/networkSummary";

    private List<NetworkSummaryTableEntity> networkSummaryTableEntities = new ArrayList<NetworkSummaryTableEntity>();

    private ToyotaFranchise toyotaFranchise;

    @SpringBean
    private NetworkSummaryService networkSummaryService;

    @DefaultHandler
    @HandlesEvent("menu")
    public Resolution menu()
    {
        LOG.info("Displaying the Network Summary menu");
        return new ForwardResolution(NETWORK_SUMMARY_PATH + "/menu.jsp");
    }

    @HandlesEvent("national")
    public Resolution national()
    {
        LOG.info("Displaying National Dealers");
        final List<NetworkSummaryDealerStatistic> summary = networkSummaryService.getNationalSummary(getToyotaFranchise());
        networkSummaryTableEntities.addAll(getDealershipTableEntities(summary));
        return forwardToListings();
    }

    @HandlesEvent("state")
    public Resolution state()
    {
        LOG.info("Displaying National Dealers");
        for (State state : State.values())
        {
            final List<NetworkSummaryDealerStatistic> summary = networkSummaryService.getStateSummary(state, getToyotaFranchise());
            List<NetworkSummaryTableEntity> stateDealerships = getDealershipTableEntities(summary);
            networkSummaryTableEntities.add(new StateNetworkSummaryTableEntityImpl(state, stateDealerships));
        }
        return forwardToListings();
    }

    @HandlesEvent("regional")
    public Resolution regional()
    {
        LOG.info("Displaying National Dealers");
        for (Region region : Region.values())
        {
            final List<NetworkSummaryDealerStatistic> summary = networkSummaryService.getRegionalSummary(region, getToyotaFranchise());
            List<NetworkSummaryTableEntity> regionDealerships = getDealershipTableEntities(summary);
            networkSummaryTableEntities.add(new RegionNetworkSummaryTableEntityImpl(region, regionDealerships));
        }
        return forwardToListings();
    }

    private List<NetworkSummaryTableEntity> getDealershipTableEntities(List<NetworkSummaryDealerStatistic> summary)
    {
        List<NetworkSummaryTableEntity> stateDealerships = new ArrayList<NetworkSummaryTableEntity>();
        for (NetworkSummaryDealerStatistic statistic : summary)
        {
            final DealerNetworkSummaryTableEntityImpl entity = new DealerNetworkSummaryTableEntityImpl(statistic.getDealer(),
                    statistic.getPrincipalAndBranches(), statistic.getBranches(),
                    statistic.getSatelliteServices(), statistic.getOtherLocations());
            stateDealerships.add(entity);
        }
        return stateDealerships;
    }

    public List<NetworkSummaryTableEntity> getNetworkSummaryTableEntities()
    {
        return networkSummaryTableEntities;
    }

    public List<NetworkSummaryTableEntity> getTotalSummary()
    {
        final NetworkSummaryTableEntity entity = new NetworkSummaryTotalTableEntity(getNetworkSummaryTableEntities());
        return Arrays.asList(entity);
    }

    public ToyotaFranchise getToyotaFranchise()
    {
        return toyotaFranchise;
    }

    public void setToyotaFranchise(ToyotaFranchise toyotaFranchise)
    {
        this.toyotaFranchise = toyotaFranchise;
    }

    private Resolution forwardToListings()
    {
        return new ForwardResolution(NETWORK_SUMMARY_PATH + "/list.jsp");
    }
}
