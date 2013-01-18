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
public class PhoneNumberConverterUnitTest extends AbstractUnitTestCase
{
    private static final Logger LOG = Logger.getLogger(PhoneNumberConverterUnitTest.class.getName());

    @Test
    public void TestConnversion() {
        PhoneNumberConverter phoneNumberConverter = new PhoneNumberConverter();
        String phone = phoneNumberConverter.convert("038845 9007",null,null);
        Assert.assertEquals("03 8845 9007", phone);
    }

}