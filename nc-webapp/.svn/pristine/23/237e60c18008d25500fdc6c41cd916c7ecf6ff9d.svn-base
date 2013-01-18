package au.com.toyota.nc.webapp.stripes.staff.search;

import au.com.toyota.nc.common.AbstractUnitTestCase;
import au.com.toyota.nc.common.model.DealerStaffSearchRequest;
import org.junit.Test;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

public class FineSearchParametersLengthValidatorUnitTest extends AbstractUnitTestCase
{
    @Test
    public void should_be_valid_if_only_firstname_is_provided_and_length_is_greater_than_or_equla_to_2() throws Exception
    {
        DealerStaffSearchRequest request = new DealerStaffSearchRequest();
        request.setFirstname("owieuroiweurw");
        runTest(request, true);
        request = new DealerStaffSearchRequest();
        request.setFirstname("ab");
        runTest(request, true);
    }

    @Test
    public void should_be_invalid_if_only_firstname_is_provided_and_trimmed_length_is_not_greater_than_2() throws Exception
    {
        DealerStaffSearchRequest request = new DealerStaffSearchRequest();
        request.setFirstname("  a  ");
        runTest(request, false);
    }

    @Test
    public void should_be_valid_if_only_lastname_is_provided_and_length_is_greater_than_or_equal_to_2() throws Exception
    {
        DealerStaffSearchRequest request = new DealerStaffSearchRequest();
        request.setSurname("wioeruioweur");
        runTest(request, true);
        request = new DealerStaffSearchRequest();
        request.setSurname("ab");
        runTest(request, true);
    }

    @Test
    public void should_be_invalid_if_only_lastname_is_provided_and_trimmed_length_is_not_greater_than_2() throws Exception
    {
        DealerStaffSearchRequest request = new DealerStaffSearchRequest();
        request.setSurname("  a  ");
        runTest(request, false);
    }

    @Test
    public void should_be_valid_if_only_DEALER_STAFF_NO_is_provided_and_length_is_greater_than_2() throws Exception
    {
        final DealerStaffSearchRequest request = new DealerStaffSearchRequest();
        request.setDealerStaffNo(8483L);
        runTest(request, true);
    }

    @Test
    public void should_be_valid_if_only_DEALER_STAFF_NO_is_provided() throws Exception
    {
        DealerStaffSearchRequest request = new DealerStaffSearchRequest();
        request.setDealerStaffNo(1L);
        runTest(request, true);
        request = new DealerStaffSearchRequest();
        request.setDealerStaffNo(0L);
        runTest(request, true);
        request = new DealerStaffSearchRequest();
        request.setDealerStaffNo(4892389423894L);
        runTest(request, true);
    }

    @Test
    public void should_be_valid_if_only_DEALER_NAME_is_provided_and_length_is_greater_than_2() throws Exception
    {
        final DealerStaffSearchRequest request = new DealerStaffSearchRequest();
        request.setDealerName("oiwuioweru");
        runTest(request, true);
    }

    @Test
    public void should_be_invalid_if_only_DEALER_NAME_is_provided_and_trimmed_length_is_not_greater_than_1() throws Exception
    {
        DealerStaffSearchRequest request = new DealerStaffSearchRequest();
        request.setDealerName("    a    ");
        runTest(request, false);
        request = new DealerStaffSearchRequest();
        request.setDealerName("a");
        runTest(request, false);
        request = new DealerStaffSearchRequest();
        request.setDealerName("ab");
        runTest(request, true);
    }

    @Test
    public void should_be_valid_if_only_DEALER_SUBURB_is_provided_and_length_is_greater_than_2() throws Exception
    {
        final DealerStaffSearchRequest request = new DealerStaffSearchRequest();
        request.setLocationSuburb("oiwuioweru");
        runTest(request, true);
    }

    @Test
    public void should_be_invalid_if_only_DEALER_SUBURB_is_provided_and_trimmed_length_is_not_greater_than_3() throws Exception
    {
        DealerStaffSearchRequest request = new DealerStaffSearchRequest();
        request.setLocationSuburb("    o   ");
        runTest(request, false);
        request = new DealerStaffSearchRequest();
        request.setLocationSuburb("123");
        runTest(request, false);
    }

    @Test
    public void should_be_invalid_if_two_fine_parameters_provided_but_both_are_blank() throws Exception
    {
        final DealerStaffSearchRequest request = new DealerStaffSearchRequest();
        request.setLocationSuburb("      ");
        request.setFirstname("      ");
        runTest(request, false);
    }

    @Test
    public void should_return_the_generic_validation_error_message() throws Exception
    {
        final FineSearchParametersLengthValidator validator = new FineSearchParametersLengthValidator(new DealerStaffSearchRequest());
        assertThat(validator.getValidationErrorMessageKey(), is("error.staff.searchvalidator.generic"));
    }

    private void runTest(DealerStaffSearchRequest request, boolean valid)
    {
        final FineSearchParametersLengthValidator validator = new FineSearchParametersLengthValidator(request);
        assertThat(validator.isValid(), is(valid));
    }

}
