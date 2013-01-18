package au.com.toyota.nc.webapp.stripes.staff.search;

import au.com.toyota.nc.common.AbstractUnitTestCase;
import org.junit.Test;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

public class CompositeOrSearchValidatorUnitTest extends AbstractUnitTestCase
{
    @Test
    public void should_be_valid_if_at_least_one_validator_is_valid() throws Exception
    {
        final CompositeOrSearchValidator validator = new CompositeOrSearchValidator(
            new SimpleStaffSearchValidator(false), 
            new SimpleStaffSearchValidator(false),
            new SimpleStaffSearchValidator(true),
            new SimpleStaffSearchValidator(false));
        assertThat(validator.isValid(), is(true));
    }

    @Test
    public void should_be_invalid_if_no_validators_are_valid() throws Exception
    {
        final CompositeOrSearchValidator validator = new CompositeOrSearchValidator();
        assertThat(validator.isValid(), is(false));
    }

    @Test
    public void should_return_the_generic_validation_error_message() throws Exception
    {
        final CompositeOrSearchValidator validator = new CompositeOrSearchValidator();
        assertThat(validator.getValidationErrorMessageKey(), is("error.staff.searchvalidator.generic"));
    }

    private static class SimpleStaffSearchValidator implements DealerStaffSearchValidator
    {
        private final boolean valid;

        public SimpleStaffSearchValidator(final boolean valid)
        {
            this.valid = valid;
        }

        public boolean isValid()
        {
            return valid;
        }

        public String getValidationErrorMessageKey()
        {
            return null;
        }
    }
}
