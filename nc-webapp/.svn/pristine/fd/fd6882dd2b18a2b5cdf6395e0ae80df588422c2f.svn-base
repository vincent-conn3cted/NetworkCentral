package au.com.toyota.nc.webservices;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import au.com.toyota.nc.common.locations.LocationDBService;
import au.com.toyota.nc.common.model.hibernate.Location;
import au.com.toyota.nc.common.model.hibernate.MakerCode;
import au.com.toyota.webservices.schema.ibus._2005._02._18.addressing.ObjectFactory;
import au.com.toyota.webservices.schema.nc._2010._04._16.userslocationsdetails.UsersLocationsDetails;
import au.com.toyota.webservices.schema.nc._2010._04._16.userslocationsdetails.UsersLocationsDetailsResponse;
import com.toyota.ibus.common.ws.SOAPMessage;
import com.toyota.ibus.common.ws.SOAPMessageFactory;
import com.toyota.ibus.common.ws.WebServiceServlet;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

public class UsersLocationsServlet extends WebServiceServlet
{
    @Override
    protected Class getRequestBodyElementClass()
    {
        return UsersLocationsDetails.class;
    }

    @Override
    protected SOAPMessage webServiceImpl(SOAPMessage message, String s) throws Exception
    {
        UsersLocationsDetails request = (UsersLocationsDetails) message.getBodyElement();
        List<Location> locationDtos = lookupLocationService().fetchLocationsByUsercode(request.getUsercode());
        List<UsersLocationsDetailsResponse.Locations> responseLocations = populateLocationsForResponse(locationDtos);
        UsersLocationsDetailsResponse locationsResponse = new UsersLocationsDetailsResponse();
        if (responseLocations.size() > 0)
        {
            locationsResponse.getLocations().addAll(responseLocations);
        }
        else
        {
            locationsResponse.setError("No active locations found!");
        }
        return createSoapResponse(locationsResponse);
    }

    private LocationDBService lookupLocationService()
    {
        ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(getServletContext());
        Map beans = context.getBeansOfType(LocationDBService.class);
        return (LocationDBService) beans.values().toArray()[0];
    }

    private List<UsersLocationsDetailsResponse.Locations> populateLocationsForResponse(List<Location> locationDaos)
    {
        List<UsersLocationsDetailsResponse.Locations> responseLocations = new ArrayList<UsersLocationsDetailsResponse.Locations>();
        for (Location locationDao : locationDaos)
        {
            UsersLocationsDetailsResponse.Locations newLocation = new UsersLocationsDetailsResponse.Locations();
            newLocation.setName(locationDao.getLocationName());
            newLocation.setDestinationCode(locationDao.getDestinationCode());
            MakerCode makerCode = locationDao.getMakerCode();
            if (makerCode != null)
            {
                newLocation.setMakerCode(makerCode.getCode());
            }
            responseLocations.add(newLocation);
        }
        return responseLocations;
    }

    private SOAPMessage createSoapResponse(UsersLocationsDetailsResponse locationsResponse)
    {
        SOAPMessage soapDoc = SOAPMessageFactory.newInstance_1_1(locationsResponse, new Class[]{ObjectFactory.class});
        soapDoc.setSenderId("networkcentral");
        soapDoc.setMessageIdUniquely();
        return soapDoc;
    }
}