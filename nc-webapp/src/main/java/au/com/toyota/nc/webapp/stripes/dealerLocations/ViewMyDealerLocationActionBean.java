package au.com.toyota.nc.webapp.stripes.dealerLocations;

import au.com.toyota.nc.common.locations.LocationDealerSearchService;
import au.com.toyota.nc.common.model.DealerLocationSearchRequest;
import au.com.toyota.nc.common.model.hibernate.Appointment;
import au.com.toyota.nc.common.model.hibernate.Location;
import au.com.toyota.nc.common.staff.exceptions.AppointmentNotFoundException;
import net.sourceforge.stripes.action.DefaultHandler;
import net.sourceforge.stripes.action.ForwardResolution;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.integration.spring.SpringBean;
import org.apache.log4j.Logger;

import java.text.MessageFormat;
import java.util.List;

/**
 * Stripes action bean for viewing dealer & location for the logged in user
 * Date: Jun 11, 2009
 * Time: 9:46:21 AM
 *
 * @author Alex Wibowo
 */
public class ViewMyDealerLocationActionBean extends BaseDealerLocationActionBean {
    private static final Logger LOG = Logger.getLogger(ViewMyDealerLocationActionBean.class.getName());

    @SpringBean
    private LocationDealerSearchService locationDealerSearchService;

    protected DealerLocationSearchRequest searchReq;

    private List<Location> locations;

    @DefaultHandler
    public Resolution viewMyDealerLocation() throws AppointmentNotFoundException {
        LOG.info(MessageFormat.format("View my dealer location for user with id [{0}]", context.getLoginId()));

        LOG.debug(MessageFormat.format("Finding dealer for user [{0}]", context.getLoginId()));
        Appointment directAppointment = getLoggedInUsersAppointment();
        searchReq = new DealerLocationSearchRequest();
        searchReq.setDealerId(directAppointment.getDealer().getDealerId());

        LOG.debug(MessageFormat.format("Found dealer for user [{0}] as [{0}]. Find all locations for dealer..",
                context.getLoginId(), directAppointment.getDealer().getDealerId()));
        locations = locationDealerSearchService.findLocationForRole(searchReq, context.getUserRole());

        return new ForwardResolution(LOCATION_JSP_BASE + "/viewMyLocation.jsp");
    }

    public DealerLocationSearchRequest getSearchReq() {
        return searchReq;
    }

    public void setSearchReq(DealerLocationSearchRequest searchReq) {
        this.searchReq = searchReq;
    }

    public List<Location> getLocations()
    {
        return locations;
    }
}
