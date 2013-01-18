package au.com.toyota.nc.webapp.stripes.staff.search;

import static org.apache.commons.lang.StringUtils.isNotBlank;
import au.com.toyota.nc.common.model.DealerStaffSearchRequest;

/**
 * The firstname and lastname is required and of the minimum length or greater.
 */
public class MandatoryFirstAndLastNameValidator extends  AbstractDealerStaffSearchValidator implements DealerStaffSearchValidator
{
    public MandatoryFirstAndLastNameValidator(DealerStaffSearchRequest dealerStaffSearchRequest)
    {
        super(dealerStaffSearchRequest);
    }

    public boolean isValid()
    {
        return (getFieldLength(firstname) >= 2 && getFieldLength(surname) >= 2) || dealerStaffNo != null;
    }

    public String getValidationErrorMessageKey()
    {
        return "error.staff.searchvalidator.name";
    }
}
