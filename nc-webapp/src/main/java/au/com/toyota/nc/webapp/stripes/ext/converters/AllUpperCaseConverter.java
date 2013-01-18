package au.com.toyota.nc.webapp.stripes.ext.converters;

import net.sourceforge.stripes.validation.StringTypeConverter;
import net.sourceforge.stripes.validation.ValidationError;

import java.util.Collection;

/**
 * Convert provided string to all upper case
 * 
 * Created by IntelliJ IDEA.
 * User: Deepthi Fernando
 * Date: 18/03/2009
 * Time: 1:13:58 PM
 * To change this template use File | Settings | File Templates.
 */
public class AllUpperCaseConverter extends StringTypeConverter{
    public String convert(String s, Class<? extends String> aClass, Collection<ValidationError> validationErrors) {
        s= s.toUpperCase();
        return super.convert(s, aClass, validationErrors);    //To change body of overridden methods use File | Settings | File Templates.
    }
}
