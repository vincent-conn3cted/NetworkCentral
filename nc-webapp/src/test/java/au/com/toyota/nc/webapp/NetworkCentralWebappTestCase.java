package au.com.toyota.nc.webapp;

import org.springframework.test.context.junit4.AbstractTransactionalJUnit4SpringContextTests;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.beans.factory.annotation.Autowired;
import au.com.toyota.nc.common.utils.builders.*;

/**
 * Date: May 6, 2009
 * Time: 1:22:53 PM
 *
 * @author Alex Wibowo
 */
@ContextConfiguration(locations = {"classpath:applicationContextTest-web.xml"})
public abstract class NetworkCentralWebappTestCase extends AbstractTransactionalJUnit4SpringContextTests {

    @Autowired
    protected DealerTestBuilder dealerTestBuilder;

    @Autowired
    protected LocationTestBuilder locationTestBuilder;

    @Autowired
    protected SapDealerTestBuilder sapDealerTestBuilder;

    @Autowired
    protected SapLocationTestBuilder sapLocationTestBuilder;

    @Autowired
    protected SpecialConditionTestBuilder specialConditionTestBuilder;

    @Autowired
    protected DealerCommitteeTestBuilder dealerCommitteeTestBuilder;

    @Autowired
    protected DealerMarketingSubscriptionTestBuilder dealerMarketingSubscriptionTestBuilder;
}
