package au.com.toyota.nc.webapp.stripes.staff.search;

import au.com.toyota.nc.common.AbstractUnitTestCase;
import au.com.toyota.nc.common.model.DealerStaffSearchRequest;
import au.com.toyota.nc.common.model.hibernate.Department;
import au.com.toyota.nc.common.model.hibernate.Region;
import au.com.toyota.nc.common.model.hibernate.State;
import au.com.toyota.nc.common.model.search.EnumeratedRegionSearchOption;
import org.junit.Test;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

public class MandatoryFirstAndLastNameValidatorUnitTest extends AbstractUnitTestCase
{
    @Test
    public void should_fail_validation_if_only_firstname_provided() throws Exception
    {
        final DealerStaffSearchRequest request = new DealerStaffSearchRequest();
        request.setFirstname("Alex");
        request.setLocationSuburb("salkfjakls");
        request.setDepartment(Department.Fleet);
        final MandatoryFirstAndLastNameValidator validator = new MandatoryFirstAndLastNameValidator(request);
        assertThat(validator.isValid(), is(false));
    }

    @Test
    public void should_fail_validation_if_only_lastname_provided() throws Exception
    {
        final DealerStaffSearchRequest request = new DealerStaffSearchRequest();
        request.setSurname("Ooi");
        request.setDealerName("salkfjakls");
        request.setLocationState(State.ACT);
        final MandatoryFirstAndLastNameValidator validator = new MandatoryFirstAndLastNameValidator(request);
        assertThat(validator.isValid(), is(false));
    }

    @Test
    public void should_pass_validation_if_firstname_and_lastname_not_provided_but_dealer_staff_number_provided() throws Exception
    {
        final DealerStaffSearchRequest request = new DealerStaffSearchRequest();
        request.setFirstname(null);
        request.setSurname(null);
        request.setDealerStaffNo(834L);
        request.setDealerRegion(new EnumeratedRegionSearchOption(Region.Eastern));
        final MandatoryFirstAndLastNameValidator validator = new MandatoryFirstAndLastNameValidator(request);
        assertThat(validator.isValid(), is(true));
    }

    @Test
    public void should_fail_validation_if_firstname_not_of_minimum_length_after_trimming() throws Exception
    {
        final DealerStaffSearchRequest request = new DealerStaffSearchRequest();
        request.setFirstname("   a  ");
        request.setSurname("Doxey");
        final MandatoryFirstAndLastNameValidator validator = new MandatoryFirstAndLastNameValidator(request);
        assertThat(validator.isValid(), is(false));
    }

    @Test
    public void should_fail_validation_if_lastname_not_of_minimum_length_after_trimming() throws Exception
    {
        final DealerStaffSearchRequest request = new DealerStaffSearchRequest();
        request.setFirstname("John");
        request.setSurname(" b    ");
        final MandatoryFirstAndLastNameValidator validator = new MandatoryFirstAndLastNameValidator(request);
        assertThat(validator.isValid(), is(false));
    }
    
    @Test
    public void should_pass_validation_if_lastname_of_minimum_length_after_trimming() throws Exception
    {
        final DealerStaffSearchRequest request = new DealerStaffSearchRequest();
        request.setFirstname("John");
        request.setSurname(" ba    ");
        final MandatoryFirstAndLastNameValidator validator = new MandatoryFirstAndLastNameValidator(request);
        assertThat(validator.isValid(), is(true));
    }

    @Test
    public void should_return_the_name_validation_error_message() throws Exception
    {
        final MandatoryFirstAndLastNameValidator validator = new MandatoryFirstAndLastNameValidator(new DealerStaffSearchRequest());
        assertThat(validator.getValidationErrorMessageKey(), is("error.staff.searchvalidator.name"));
    }

    @Test
    public void should_pass_validation_if_firstname_and_lastname_of_minimum_length_after_trimming() throws Exception
    {
        final DealerStaffSearchRequest request = new DealerStaffSearchRequest();
        request.setFirstname("Bob");
        request.setSurname("Dole");
        final MandatoryFirstAndLastNameValidator validator = new MandatoryFirstAndLastNameValidator(request);
        assertThat(validator.isValid(), is(true));
    }

}
