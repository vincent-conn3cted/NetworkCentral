package au.com.toyota.nc.webapp.stripes.staff.search;

import au.com.toyota.nc.common.model.DealerStaffSearchRequest;

import static org.apache.commons.lang.StringUtils.isNotBlank;

/**
 * This validator will pass validation if at least 2 fine parameters or 2 bulk parameters are provided. If not, then
 * it will return invalid
 */
public class MultipleSearchParametersValidator extends AbstractDealerStaffSearchValidator implements DealerStaffSearchValidator
{
    public MultipleSearchParametersValidator(DealerStaffSearchRequest dealerStaffSearchRequest)
    {
        super(dealerStaffSearchRequest);
    }

    public boolean isValid()
    {
        return getCountOfBulkParameters() >= 2 || getCountOfFineParameters() >= 2;
    }

    public String getValidationErrorMessageKey()
    {
        return "error.staff.searchvalidator.generic";
    }

    private int getCountOfFineParameters()
    {
        int count = 0;
        if (isNotBlank(firstname))
        {
            count++;
        }
        if (isNotBlank(surname))
        {
            count++;
        }
        if (isNotBlank(locationSuburb))
        {
            count++;
        }
        if (isNotBlank(dealerName))
        {
            count++;
        }
        if (dealerStaffNo != null)
        {
            count++;
        }
        return count;
    }

    private int getCountOfBulkParameters()
    {
        int count = 0;
        if (region != null)
        {
            count++;
        }
        if (state != null)
        {
            count++;
        }
        if (department != null)
        {
            count++;
        }
        if (position != null)
        {
            count++;
        }
        return count;
    }
}
