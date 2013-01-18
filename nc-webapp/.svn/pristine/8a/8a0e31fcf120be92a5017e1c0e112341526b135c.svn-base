package au.com.toyota.nc.webapp.stripes.reports;

import au.com.toyota.nc.common.model.DealerStaffSearchRequest;
import au.com.toyota.nc.webapp.stripes.BaseActionBean;
import net.sourceforge.stripes.action.Before;
import net.sourceforge.stripes.controller.LifecycleStage;

public class AbstractStaffSearchReportActionBean extends BaseActionBean
{
    protected static final String EXPORT_EVENT = "export";
    protected static final String GENERATE_EVENT = "generate";

    protected DealerStaffSearchRequest searchReq;

    @Before(stages = {LifecycleStage.EventHandling}, on = {EXPORT_EVENT, GENERATE_EVENT})
    public void ensureDealerIdSetForMyDealerSearch()
    {
        if (searchReq != null && searchReq.isMyDealer() != null && searchReq.isMyDealer())
        {
            searchReq.setDealerID(staffServices.getDealerIDForGivenUserID(getContext().getLoginId()));
        }
    }

    public DealerStaffSearchRequest getSearchReq()
    {
        return searchReq;
    }

    public void setSearchReq(DealerStaffSearchRequest searchReq)
    {
        this.searchReq = searchReq;
    }
}
