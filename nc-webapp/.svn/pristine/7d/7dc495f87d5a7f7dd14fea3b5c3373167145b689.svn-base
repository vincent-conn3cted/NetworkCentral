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

public class MultipleSearchParametersValidatorUnitTest extends AbstractUnitTestCase
{
    @Test
    public void should_be_valid_if_more_than_one_bulk_search_parameters_are_selected() throws Exception
    {
        final DealerStaffSearchRequest request = new DealerStaffSearchRequest();
        request.setDealerRegion(new EnumeratedRegionSearchOption(Region.Eastern));
        request.setDepartment(Department.Fleet);
        runTest(request, true);
    }

    @Test
    public void should_be_valid_if_more_than_one_fine_search_parameters_are_selected() throws Exception
    {
        final DealerStaffSearchRequest request = new DealerStaffSearchRequest();
        request.setDealerStaffNo(472L);
        request.setFirstname("owieui");
        runTest(request, true);
    }

    @Test
    public void should_be_valid_if_more_than_one_fine_search_parameters_are_provided_and_are_less_than_2_characters() throws Exception
    {
        final DealerStaffSearchRequest request = new DealerStaffSearchRequest();
        request.setFirstname("a");
        request.setSurname("a");
        runTest(request, true);
    }

    @Test
    public void should_be_invalid_if_only_one_bulk_and_one_fine_search_parameter_provided() throws Exception
    {
        final DealerStaffSearchRequest request = new DealerStaffSearchRequest();
        request.setFirstname("a");
        request.setDepartment(Department.Fleet);
        runTest(request, false);
    }

    @Test
    public void should_be_invalid_if_only_one_bulk_search_parameter_provided() throws Exception
    {
        final DealerStaffSearchRequest request = new DealerStaffSearchRequest();
        request.setLocationState(State.ACT);
        runTest(request, false);
    }

    @Test
    public void should_be_invalid_if_only_one_fine_search_parameter_provided() throws Exception
    {
        final DealerStaffSearchRequest request = new DealerStaffSearchRequest();
        request.setDealerStaffNo(2L);
        runTest(request, false);
    }

    @Test
    public void should_return_the_generic_validation_error_message() throws Exception
    {
        final MultipleSearchParametersValidator validator = new MultipleSearchParametersValidator(new DealerStaffSearchRequest());
        assertThat(validator.getValidationErrorMessageKey(), is("error.staff.searchvalidator.generic"));
    }

    private void runTest(DealerStaffSearchRequest request, boolean valid)
    {
        final MultipleSearchParametersValidator validator = new MultipleSearchParametersValidator(request);
        assertThat(validator.isValid(), is(valid));
    }

}