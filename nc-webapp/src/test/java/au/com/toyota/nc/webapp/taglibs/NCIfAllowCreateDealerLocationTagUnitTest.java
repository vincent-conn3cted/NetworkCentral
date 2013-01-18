package au.com.toyota.nc.webapp.taglibs;

import au.com.toyota.nc.common.AbstractUnitTestCase;
import au.com.toyota.nc.common.security.NCRole;
import org.easymock.IMocksControl;
import org.easymock.classextension.EasyMock;
import org.junit.Test;
import org.junit.Before;
import static org.hamcrest.MatcherAssert.assertThat;
import org.hamcrest.Matchers;
import static org.hamcrest.Matchers.is;

import javax.servlet.jsp.tagext.Tag;

/**
 *
 */
public class NCIfAllowCreateDealerLocationTagUnitTest extends AbstractUnitTestCase {
    private IMocksControl strictControl;
    private NCTagHelper ncTagHelper;
    private NCIfAllowCreateDealerLocationTag tag;

    @Before
    public void createMocks() throws Exception {
        strictControl = EasyMock.createStrictControl();
        ncTagHelper = strictControl.createMock(NCTagHelper.class);
        tag = new NCIfAllowCreateDealerLocationTag(ncTagHelper);
    }


    @Test
    public void should_not_evaluate_body_if_user_isnt_allowed_to_create_dealerlocation() throws Exception{
        EasyMock.expect(ncTagHelper.getUserRole()).andReturn(NCRole.TMCASearcher).once();
        assertThat(NCRole.TMCASearcher.isAllowCreateDealerLocation(), is(false));
        strictControl.replay();
        final int evalValue = tag.doStartTag();
        strictControl.verify();
        assertThat(evalValue, is(Tag.SKIP_BODY));
    }

    @Test
    public void should_evaluate_body_if_user_user_is_allowed_to_create_dealerlocation() throws Exception{
        EasyMock.expect(ncTagHelper.getUserRole()).andReturn(NCRole.NationalAdministrator).once();
        assertThat(NCRole.NationalAdministrator.isAllowCreateDealerLocation(), is(true));
        strictControl.replay();
        final int evalValue = tag.doStartTag();
        strictControl.verify();
        assertThat(evalValue, is(Tag.EVAL_BODY_INCLUDE));

    }
}

