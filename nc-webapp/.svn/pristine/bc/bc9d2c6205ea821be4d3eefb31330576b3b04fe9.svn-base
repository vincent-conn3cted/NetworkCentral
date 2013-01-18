package au.com.toyota.nc.webapp.stripes.staff.search;

import au.com.toyota.nc.common.model.DealerStaffSearchRequest;

/**
 * This validator will pass validation if one of the fine search parameters meets the minimum field length required
 */
public class FineSearchParametersLengthValidator extends AbstractDealerStaffSearchValidator implements DealerStaffSearchValidator
{
    public FineSearchParametersLengthValidator(DealerStaffSearchRequest dealerStaffSearchRequest)
    {
        super(dealerStaffSearchRequest);
    }

    public boolean isValid()
    {
        return getFieldLength(firstname) >= 2 ||
            getFieldLength(surname) >= 2 ||
            getFieldLength(dealerStaffNo) > 0 ||
            getFieldLength(dealerName) >= 2 ||
            getFieldLength(locationSuburb) >= 4;
    }

    public String getValidationErrorMessageKey()
    {
        return "error.staff.searchvalidator.generic";
    }

}
