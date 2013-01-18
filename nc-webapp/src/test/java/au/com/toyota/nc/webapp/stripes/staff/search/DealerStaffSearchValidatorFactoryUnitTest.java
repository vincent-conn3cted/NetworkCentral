package au.com.toyota.nc.webapp.stripes.staff.search;

import au.com.toyota.nc.common.AbstractUnitTestCase;
import au.com.toyota.nc.common.model.DealerStaffSearchRequest;
import au.com.toyota.nc.common.security.NCRole;
import org.junit.Test;

import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.Matchers.instanceOf;
import static org.junit.Assert.assertThat;

public class DealerStaffSearchValidatorFactoryUnitTest extends AbstractUnitTestCase
{
    @Test
    public void should_create_composite_or_validator_with_fine_search_and_multiple_parameters_validators_for_all_roles_except_dealer_searcher_and_updater() throws Exception
    {
        runTestForCompositeOrValidator(NCRole.Lexus);
        runTestForCompositeOrValidator(NCRole.NationalAdministrator);
        runTestForCompositeOrValidator(NCRole.NationalCR);
        runTestForCompositeOrValidator(NCRole.NationalCSD);
        runTestForCompositeOrValidator(NCRole.NationalFranDev);
        runTestForCompositeOrValidator(NCRole.NationalSales);
        runTestForCompositeOrValidator(NCRole.RegionalCSD);
        runTestForCompositeOrValidator(NCRole.RegionalFranDev);
        runTestForCompositeOrValidator(NCRole.RegionalSales);
        runTestForCompositeOrValidator(NCRole.Support);
        runTestForCompositeOrValidator(NCRole.TMCASearcher);
    }

    @Test
    public void should_create_mandatory_first_and_last_name_validator_for_dealer_updater_and_searcher() throws Exception
    {
        DealerStaffSearchRequest dealerStaffSearchRequest = new DealerStaffSearchRequest();
        final DealerStaffSearchValidator searcherValidator = DealerStaffSearchValidatorFactory.createValidatorFor(dealerStaffSearchRequest, NCRole.DealerSearcher);
        assertThat(searcherValidator, instanceOf(MandatoryFirstAndLastNameValidator.class));
        final DealerStaffSearchValidator updaterValidator = DealerStaffSearchValidatorFactory.createValidatorFor(dealerStaffSearchRequest, NCRole.DealerUpdater);
        assertThat(updaterValidator, instanceOf(MandatoryFirstAndLastNameValidator.class));
    }

    private void runTestForCompositeOrValidator(NCRole role)
    {
        DealerStaffSearchRequest dealerStaffSearchRequest = new DealerStaffSearchRequest();
        final DealerStaffSearchValidator validator = DealerStaffSearchValidatorFactory.createValidatorFor(dealerStaffSearchRequest, role);
        assertThat(validator, instanceOf(CompositeOrSearchValidator.class));
        CompositeOrSearchValidator compositeValidator = (CompositeOrSearchValidator) validator;
        final DealerStaffSearchValidator[] validators = compositeValidator.getValidators();
        assertThat(validators.length, is(2));
        assertThat(validators[0], is(instanceOf(FineSearchParametersLengthValidator.class)));
        assertThat(validators[1], is(instanceOf(MultipleSearchParametersValidator.class)));
    }


}
