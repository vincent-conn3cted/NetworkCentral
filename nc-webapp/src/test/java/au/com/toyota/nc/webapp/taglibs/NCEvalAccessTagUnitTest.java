package au.com.toyota.nc.webapp.taglibs;

import au.com.toyota.nc.common.AbstractUnitTestCase;
import au.com.toyota.nc.common.security.NCFieldPermission;
import org.easymock.classextension.EasyMock;
import org.easymock.classextension.IMocksControl;
import static org.hamcrest.CoreMatchers.is;
import org.junit.Assert;
import static org.junit.Assert.assertThat;
import org.junit.Before;
import org.junit.Test;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.Tag;

public class NCEvalAccessTagUnitTest extends AbstractUnitTestCase
{
    private IMocksControl strictControl;
    private NCTagHelper ncTagHelper;
    private NCEvalAccessTag tag;
    private static final String FIELD = "evalAccess";

    @Before
    public void createData() throws Exception
    {
        strictControl = EasyMock.createStrictControl();
        ncTagHelper = strictControl.createMock(NCTagHelper.class);

        tag = new NCEvalAccessTag(ncTagHelper);
    }

    @Test
    public void should_not_allow_body_evaluation_if_permission_is_dont_restrict() throws Exception
    {
        EasyMock.expect(ncTagHelper.getFieldPermission(FIELD)).andReturn(NCFieldPermission.DoNotRestrict).once();

        strictControl.replay();
        final int evalValue = tag.doStartTag();
        strictControl.verify();
        assertThat(evalValue, is(Tag.SKIP_BODY));
    }

    @Test
    public void should_allow_body_evaluation_if_permission_is_conditional_restrict() throws Exception
    {
        EasyMock.expect(ncTagHelper.getFieldPermission(FIELD)).andReturn(NCFieldPermission.ConditionalRestrict).once();

        strictControl.replay();
        final int evalValue = tag.doStartTag();
        strictControl.verify();
        assertThat(evalValue, is(Tag.EVAL_BODY_INCLUDE));
    }

    @Test
    public void should_throw_illegal_argument_exception_if_permission_is_write() throws Exception
    {
        runIllegalArgumentTest(NCFieldPermission.Write);
    }

    @Test
    public void should_throw_illegal_argument_exception_if_permission_is_read() throws Exception
    {
        runIllegalArgumentTest(NCFieldPermission.Read);
    }

    @Test
    public void should_throw_illegal_argument_exception_if_permission_is_none() throws Exception
    {
        runIllegalArgumentTest(NCFieldPermission.None);
    }

    private void runIllegalArgumentTest(NCFieldPermission field) throws JspException
    {
        EasyMock.expect(ncTagHelper.getFieldPermission(FIELD)).andReturn(field).once();
        try
        {
            strictControl.replay();
            tag.doStartTag();
            Assert.fail("expected exception to be thrown");
        }
        catch (IllegalArgumentException e)
        {
            assertThat(e.getMessage(), is("Invalid field permission " + field));
        }
        finally
        {
            strictControl.verify();
        }
    }
}
