package au.com.toyota.nc.webapp.stripes.ext.converters;

import au.com.toyota.nc.common.AbstractUnitTestCase;
import org.apache.log4j.Logger;
import org.junit.Assert;
import org.junit.Test;

/**
 * User: Deepthi Fernando
 * Date: 05/04/2009
 * Time: 3:16:36 PM
 */
public class ACNConverterUnitTest extends AbstractUnitTestCase
{
    private static final Logger LOG = Logger.getLogger(ACNConverterUnitTest.class.getName());


    @Test
    public void TestConnversion() {
        ACNConverter acnConverter = new ACNConverter();
        String acn = acnConverter.convert("34 5678 901",null,null);
        Assert.assertEquals("345 678 901", acn);
    }

}