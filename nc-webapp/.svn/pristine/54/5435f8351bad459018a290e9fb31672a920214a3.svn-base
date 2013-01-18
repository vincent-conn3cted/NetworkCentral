package au.com.toyota.nc.webapp.stripes.staff.search;

/**
 * This validator takes other DealerStaffSearchValidators and returns valid if AT LEAST ONE of the validators is valid,
 * otherwise, if no validators are valid then it too will be invalid
 */
public class CompositeOrSearchValidator implements DealerStaffSearchValidator
{
    private final DealerStaffSearchValidator[] validators;

    public CompositeOrSearchValidator(DealerStaffSearchValidator... validators)
    {
        this.validators = validators;
    }

    DealerStaffSearchValidator[] getValidators()
    {
        return validators;
    }

    public boolean isValid()
    {
        boolean isValid = false;
        for (DealerStaffSearchValidator validator : validators)
        {
            isValid |= validator.isValid();
        }
        return isValid;
    }

    public String getValidationErrorMessageKey()
    {
        return "error.staff.searchvalidator.generic";
    }
}
