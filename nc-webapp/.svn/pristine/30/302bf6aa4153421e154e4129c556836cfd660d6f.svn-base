package au.com.toyota.nc.webapp.taglibs;

import org.junit.Assert;
import org.junit.Test;

/**
 * User: Alex Wibowo
 * Date: Mar 13, 2009
 * Time: 5:34:13 AM
 */
public class NCTagHelperUnitTest
{
    @Test
    public void testSimpleWithoutArrayShouldNotReplace(){
        String field= "dealer";
        Assert.assertEquals(field, new NCTagHelper(null,null).removeArrayIndex(field));
    }

    @Test
    public void testSimpleNoArrayWithNestedPropertiesShouldNotReplace() {
        String field = "dealer.dealerName";
        Assert.assertEquals(field, new NCTagHelper(null,null).removeArrayIndex(field));
    }

    @Test
    public void testSimpleArrayShouldReplace() {
        String field = "dealer.businessImprovement[0]";
        Assert.assertEquals("dealer.businessImprovement[]", new NCTagHelper(null,null).removeArrayIndex(field));
    }

    @Test
    public void testSimpleArrayWithBigNumberShouldReplace(){
        String field = "dealer.businessImprovement[10]";
        Assert.assertEquals("dealer.businessImprovement[]", new NCTagHelper(null,null).removeArrayIndex(field));
    }

    @Test
    public void testNestedArray(){
        String field = "dealer.businessImprovement[0].property[1]";
        Assert.assertEquals("dealer.businessImprovement[].property[]", new NCTagHelper(null,null).removeArrayIndex(field));
    }

    @Test
    public void testNestedArray2(){
        String field = "dealer.businessImprovement[0].property[1].simpleProperty";
        Assert.assertEquals("dealer.businessImprovement[].property[].simpleProperty", new NCTagHelper(null,null).removeArrayIndex(field));
    }

    @Test
    public void testEmptyArray(){
        String field = "dealer.businessImprovement[]";
        Assert.assertEquals("dealer.businessImprovement[]", new NCTagHelper(null,null).removeArrayIndex(field));
    }

    @Test
    public void testNestedArraySeparatedShouldReplaceAll(){
        String field = "dealer.businessImprovement[0].simpleProperty.arrayProperty[1].bla";
        Assert.assertEquals("dealer.businessImprovement[].simpleProperty.arrayProperty[].bla", new NCTagHelper(null,null).removeArrayIndex(field));
    }

    @Test
    public void testSimplePropertyWithNumber(){
        String field = "dealer.dealerName23";
        Assert.assertEquals(field, new NCTagHelper(null,null).removeArrayIndex(field));
    }

    @Test
    public void testMixPropertyNumberWithArray(){
         String field = "dealer.dealerName23.arrayProperty[2].simpleProperty1000";
        Assert.assertEquals("dealer.dealerName23.arrayProperty[].simpleProperty1000", new NCTagHelper(null,null).removeArrayIndex(field));
    }



}
