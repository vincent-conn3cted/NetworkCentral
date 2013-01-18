package au.com.toyota.nc.webapp.stripes.staff.search;

import au.com.toyota.nc.common.model.DealerStaffSearchRequest;
import au.com.toyota.nc.common.security.NCRole;

public class DealerStaffSearchValidatorFactory
{
    public static DealerStaffSearchValidator createValidatorFor(DealerStaffSearchRequest request, NCRole role)
    {
        DealerStaffSearchValidator validator;
        switch(role)
        {
            case DealerSearcher:
            case DealerUpdater:
                //stoopid updaters and searchers must always provide both the first and last names when doing a search
                validator = new MandatoryFirstAndLastNameValidator(request);
                break;
            default:
                // everybody else has much less strict guidelines
                validator = new CompositeOrSearchValidator(new FineSearchParametersLengthValidator(request), new MultipleSearchParametersValidator(request));
                break;
        }
        return validator;
    }
}
