package au.com.toyota.nc.webapp.stripes.dealerLocations.validators;

import org.apache.log4j.Logger;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Component;
import au.com.toyota.nc.common.model.hibernate.SpecialCondition;
import au.com.toyota.nc.common.model.hibernate.Dealer;
import au.com.toyota.nc.common.model.hibernate.DealerCommittee;
import au.com.toyota.nc.common.model.hibernate.DealerMarketingSubscription;
import au.com.toyota.nc.common.model.DateRangeException;
import au.com.toyota.nc.webapp.stripes.NCActionBeanContext;

import java.text.MessageFormat;

/**
 *
 */
@Component
public class ManageDealerLocationActionBeanValidator {
    private static final Logger LOG = Logger.getLogger(ManageDealerLocationActionBeanValidator.class.getName());


    /**
     * Validate {@link au.com.toyota.nc.common.model.hibernate.Dealer.GeneralInfo#dealerName} and
     * {@link au.com.toyota.nc.common.model.hibernate.Dealer.GeneralInfo#mainFranchise}
     *
     * @param dealer
     * @param context
     */
    public void validateDealerNameAndFranchise(Dealer dealer, NCActionBeanContext context) {
        if (null == dealer.getGeneralInfo() || StringUtils.isBlank(dealer.getGeneralInfo().getDealerName())) {
            context.addLocalizableValidationError("dealer.generalInfo.dealerName", "validation.required.valueNotPresent");
        }
        if (null == dealer.getGeneralInfo() || null == dealer.getGeneralInfo().getMainFranchise()) {
            context.addLocalizableValidationError("dealer.generalInfo.mainFranchise", "validation.required.valueNotPresent");
        }
    }


    /**
     * Validate {@link Dealer#specialConditions}
     *
     * @param dealer
     * @param context
     */
    public void validateSpecialConditions(Dealer dealer, NCActionBeanContext context) {
        LOG.debug("Validating special condition");
        for (int i = 0; i < dealer.getSpecialConditions().size(); i++) {
            SpecialCondition specialCondition = dealer.getSpecialConditions().get(i);

            // Dont validate if special condition is a null object
            if (specialCondition == null || specialCondition.isNullObject()) {
                LOG.debug(MessageFormat.format("Skip validation for special condition [{0}], since it is a null object", i));
                continue;
            }
            doSpecialConditionValidation(i, specialCondition, context);
        }
        LOG.debug("Finished validating special condition");
    }

    private void doSpecialConditionValidation(int i, SpecialCondition specialCondition, NCActionBeanContext context) {
        if (null == specialCondition.getType()) {
            context.addLocalizableValidationError("dealer.specialConditions[" + i + "].type", "validation.required.valueNotPresent");
        }
        if (StringUtils.isBlank(specialCondition.getNumber())) {
            context.addLocalizableValidationError("dealer.specialConditions[" + i + "].number", "validation.required.valueNotPresent");
        }
    }


    /**
     * Validate {@link Dealer#committees}
     *
     * @param dealer
     * @param context
     */
    public void validateDealerCommittee(Dealer dealer, NCActionBeanContext context) {
        LOG.debug("Validating dealer committee");
        for (int i = 0; i < dealer.getCommittees().size(); i++) {
            DealerCommittee committee = dealer.getCommittees().get(i);

            // Dont validate if committee is a null object
            if (committee == null || committee.isNullObject()) {
                LOG.debug(MessageFormat.format("Skip validation for dealer committee [{0}], since it is a null object", i));
                continue;
            }
            doDealerCommitteeValidation(i, committee, context);
        }
        LOG.debug("Finished validating dealer committee");
    }

    private void doDealerCommitteeValidation(int i, DealerCommittee committee, NCActionBeanContext context) {
        if (committee.getValidDate() != null) {
            try {
                committee.getValidDate().validate();
            } catch (DateRangeException e) {
                context.addSimpleValidationError("dealer.committees[" + i + "].validDate.endDate", e.getMessage());
            }
        }
    }

    /**
     * Validate {@link Dealer#marketingSubscription}
     *
     * @param dealer
     * @param context
     */
    public void validateSubscription(Dealer dealer, NCActionBeanContext context) {
        LOG.debug("Validating subscription");
        for (int i = 0; i < dealer.getMarketingSubscription().size(); i++) {
            DealerMarketingSubscription subscription = dealer.getMarketingSubscription().get(i);

            // Dont validate if committee is a null object
            if (subscription == null || subscription.isNullObject()) {
                LOG.debug(MessageFormat.format("Skip validation for subscription [{0}], since it is a null object", i));
                continue;
            }
            doMarketingSubscriptionValidation(i, subscription, context);
        }
        LOG.debug("Finished validating subscription");
    }

    private void doMarketingSubscriptionValidation(int i, DealerMarketingSubscription subscription, NCActionBeanContext context) {
        if (subscription.getSubscriptionDate() != null) {
            try {
                subscription.getSubscriptionDate().validate();
            } catch (DateRangeException e) {
                context.addSimpleValidationError("dealer.marketingSubscription[" + i + "].subscriptionDate.endDate", e.getMessage());
            }
        }
    }


}
