package au.com.toyota.nc.webapp.stripes.dealerLocations.validators;

import au.com.toyota.nc.common.model.DateRange;
import au.com.toyota.nc.common.model.hibernate.*;
import au.com.toyota.nc.webapp.NetworkCentralWebappTestCase;
import au.com.toyota.nc.webapp.stripes.NCActionBeanContext;
import org.hamcrest.Matchers;
import org.joda.time.DateTime;
import static org.junit.Assert.assertThat;
import static org.junit.Assert.assertTrue;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

/**
 *
 */
public class ManageDealerLocationActionBeanValidatorUnitTest extends NetworkCentralWebappTestCase{

    @Autowired
    private ManageDealerLocationActionBeanValidator validator;


    private NCActionBeanContext context;


    @Before
    public void setupContext(){
        context = new NCActionBeanContext();
    }

    @Test
    public void should_fail_dealer_name_and_franchise_validation_if_any_fail() {
        Dealer dealer = dealerTestBuilder.withDealerName("").withPrimaryFranchise(ToyotaFranchise.Toyota).create();
        validator.validateDealerNameAndFranchise(dealer, context);
        assertThat(context.getValidationErrors().size(), Matchers.is(1));
        assertTrue(context.getValidationErrors().containsKey("dealer.generalInfo.dealerName"));

        dealer=dealerTestBuilder.withDealerName(" ").withPrimaryFranchise(ToyotaFranchise.Toyota).create();
        setupContext();
        validator.validateDealerNameAndFranchise(dealer, context);
        assertThat(context.getValidationErrors().size(), Matchers.is(1));
        assertTrue(context.getValidationErrors().containsKey("dealer.generalInfo.dealerName"));

        dealer=dealerTestBuilder.withDealerName(null).withPrimaryFranchise(ToyotaFranchise.Toyota).create();
        setupContext();
        validator.validateDealerNameAndFranchise(dealer, context);
        assertThat(context.getValidationErrors().size(), Matchers.is(1));
        assertTrue(context.getValidationErrors().containsKey("dealer.generalInfo.dealerName"));


        dealer=dealerTestBuilder.withDealerName("DealerName").withPrimaryFranchise(ToyotaFranchise.Lexus).create();
        setupContext();
        validator.validateDealerNameAndFranchise(dealer, context);
        assertThat(context.getValidationErrors().size(), Matchers.is(0));


        dealer=dealerTestBuilder.withDealerName("DealerName").withPrimaryFranchise(null).create();
        setupContext();
        validator.validateDealerNameAndFranchise(dealer, context);
        assertThat(context.getValidationErrors().size(), Matchers.is(1));
        assertTrue(context.getValidationErrors().containsKey("dealer.generalInfo.mainFranchise"));

         dealer=dealerTestBuilder.withDealerName(null).withPrimaryFranchise(null).create();
        setupContext();
        validator.validateDealerNameAndFranchise(dealer, context);
        assertThat(context.getValidationErrors().size(), Matchers.is(2));
        assertTrue(context.getValidationErrors().containsKey("dealer.generalInfo.dealerName"));
        assertTrue(context.getValidationErrors().containsKey("dealer.generalInfo.mainFranchise"));
    }


    @Test
    public void should_fail_specialcondition_validation_if_type_empty() {
        SpecialCondition sc = specialConditionTestBuilder.withType(null).create();
        sc.setRemovedFromDealer(false);
        Dealer dealer = dealerTestBuilder.create();
        dealer.getSpecialConditions().add(sc);
        validator.validateSpecialConditions(dealer, context);
        assertThat(context.getValidationErrors().size(), Matchers.is(1));
        assertTrue(context.getValidationErrors().containsKey("dealer.specialConditions[0].type"));
    }

    @Test
    public void should_fail_specialcondition_validation_if_number_empty(){
        SpecialCondition sc = specialConditionTestBuilder.withNumber("").create();
        sc.setRemovedFromDealer(false);
        Dealer dealer = dealerTestBuilder.create();
        dealer.getSpecialConditions().add(sc);
        validator.validateSpecialConditions(dealer, context);
        assertThat(context.getValidationErrors().size(), Matchers.is(1));
        assertTrue(context.getValidationErrors().containsKey("dealer.specialConditions[0].number"));

        setupContext();
        sc = specialConditionTestBuilder.withNumber("  ").create();
        sc.setRemovedFromDealer(false);
        dealer = dealerTestBuilder.create();
        dealer.getSpecialConditions().add(sc);
        validator.validateSpecialConditions(dealer, context);
        assertThat(context.getValidationErrors().size(), Matchers.is(1));
        assertTrue(context.getValidationErrors().containsKey("dealer.specialConditions[0].number"));

        setupContext();
        sc = specialConditionTestBuilder.withNumber(null).create();
        sc.setRemovedFromDealer(false);
        dealer = dealerTestBuilder.create();
        dealer.getSpecialConditions().add(sc);
        validator.validateSpecialConditions(dealer, context);
        assertThat(context.getValidationErrors().size(), Matchers.is(1));
        assertTrue(context.getValidationErrors().containsKey("dealer.specialConditions[0].number"));

    }

    @Test
    public void should_skip_null_special_condition(){
         SpecialCondition sc = specialConditionTestBuilder.withNumber("").create();
        sc.setRemovedFromDealer(true);
        Dealer dealer = dealerTestBuilder.create();
        dealer.getSpecialConditions().add(sc);
        validator.validateSpecialConditions(dealer, context);
        assertThat(context.getValidationErrors().size(), Matchers.is(0));
    }

    @Test
    public void shouldnt_fail_empty_special_condition(){
        Dealer dealer = dealerTestBuilder.create();
        validator.validateSpecialConditions(dealer, context);
        assertThat(context.getValidationErrors().size(), Matchers.is(0));
    }

    @Test
    public void shouldnt_fail_committee_validation_if_daterange_valid(){
           DealerCommittee committee = dealerCommitteeTestBuilder.create();
        committee.setValidDate(new DateRange(new DateTime().minusDays(3).toDate(), new DateTime().toDate()));
        committee.setRemovedFromDealer(false);

        Dealer dealer = dealerTestBuilder.create();
        dealer.getCommittees().add(committee);
        validator.validateDealerCommittee(dealer, context);
        assertThat(context.getValidationErrors().size(), Matchers.is(0));
    }
    
    @Test
    public void should_fail_committee_validation_if_daterange_invalid(){
        DealerCommittee committee = dealerCommitteeTestBuilder.create();
        committee.setValidDate(new DateRange(new DateTime().plusDays(3).toDate(), new DateTime().toDate()));
        committee.setRemovedFromDealer(false);

        Dealer dealer = dealerTestBuilder.create();
        dealer.getCommittees().add(committee);

        validator.validateDealerCommittee(dealer, context);
        assertThat(context.getValidationErrors().size(), Matchers.is(1));
        assertTrue(context.getValidationErrors().containsKey("dealer.committees[0].validDate.endDate"));
    }

    @Test
    public void shouldnt_fail_committee_validation_if_nodaterange(){
        DealerCommittee committee = dealerCommitteeTestBuilder.create();
        committee.setRemovedFromDealer(false);
        committee.setValidDate(null);
        Dealer dealer = dealerTestBuilder.create();


        validator.validateDealerCommittee(dealer, context);
        assertThat(context.getValidationErrors().size(), Matchers.is(0));

    }
    @Test
    public void should_skip_null_committee(){
        DealerCommittee committee = dealerCommitteeTestBuilder.create();
        committee.setValidDate(new DateRange(new DateTime().plusDays(3).toDate(), new DateTime().toDate()));
        committee.setRemovedFromDealer(true);
        Dealer dealer = dealerTestBuilder.create();
        dealer.getCommittees().add(committee);

        validator.validateDealerCommittee(dealer, context);
        assertThat(context.getValidationErrors().size(), Matchers.is(0));
    }

    @Test
    public void shouldnt_fail_empty_committee(){
        Dealer dealer = dealerTestBuilder.create();
        validator.validateDealerCommittee(dealer, context);
        assertThat(context.getValidationErrors().size(), Matchers.is(0));
    }


    @Test
    public void shouldnt_fail_subscription_validation_if_daterange_valid(){
            DealerMarketingSubscription subscription = dealerMarketingSubscriptionTestBuilder
                .withSubscriptionDate(new DateRange(new DateTime().minusDays(3).toDate(), new DateTime().toDate()))
                .create();
        subscription.setRemovedFromDealer(false);
        Dealer dealer = dealerTestBuilder.create();
        dealer.getMarketingSubscription().add(subscription);

        validator.validateSubscription(dealer, context);
        assertThat(context.getValidationErrors().size(), Matchers.is(0));
    }


    @Test
    public void should_fail_subscription_validation_if_daterange_invalid() {
        DealerMarketingSubscription subscription = dealerMarketingSubscriptionTestBuilder
                .withSubscriptionDate(new DateRange(new DateTime().plusDays(3).toDate(), new DateTime().toDate()))
                .create();
        subscription.setRemovedFromDealer(false);
        Dealer dealer = dealerTestBuilder.create();
        dealer.getMarketingSubscription().add(subscription);


        validator.validateSubscription(dealer, context);
        assertThat(context.getValidationErrors().size(), Matchers.is(1));
        assertTrue(context.getValidationErrors().containsKey("dealer.marketingSubscription[0].subscriptionDate.endDate"));
    }

    @Test
    public void shouldnt_fail_subscription_validation_if_no_daterange(){
        DealerMarketingSubscription subscription = dealerMarketingSubscriptionTestBuilder.withSubscriptionDate(null).create();
        subscription.setRemovedFromDealer(false);
        Dealer dealer = dealerTestBuilder.create();
        dealer.getMarketingSubscription().add(subscription);

        validator.validateSubscription(dealer, context);
        assertThat(context.getValidationErrors().size(), Matchers.is(0));
    }

    @Test
    public void should_skip_null_subscription(){
        DealerMarketingSubscription subscription = dealerMarketingSubscriptionTestBuilder.create();
        subscription.setRemovedFromDealer(true);
        Dealer dealer = dealerTestBuilder.create();
        dealer.getMarketingSubscription().add(subscription);


        validator.validateSubscription(dealer, context);
        assertThat(context.getValidationErrors().size(), Matchers.is(0));
    }
    
    @Test
    public void shouldnt_fail_empty_subscription(){
      Dealer dealer = dealerTestBuilder.create();

        validator.validateSubscription(dealer, context);
        assertThat(context.getValidationErrors().size(), Matchers.is(0));
    }



    

}
