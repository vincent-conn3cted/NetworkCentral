package au.com.toyota.nc.webapp.dataproxy;

import au.com.toyota.nc.common.model.hibernate.Location;
import net.sourceforge.stripes.action.Resolution;

import java.util.List;

public interface AutoSuggestionResolutionFactory
{
    Resolution resolveDealerNameSuggestions(List<Location> locations);

    Resolution resolveLocationNameSuggestions(List<Location> locations);
}
