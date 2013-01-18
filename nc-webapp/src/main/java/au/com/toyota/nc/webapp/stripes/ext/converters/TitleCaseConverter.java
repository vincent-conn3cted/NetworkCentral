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
public class TitleCaseConverter extends StringTypeConverter{
    public String convert(String s, Class<? extends String> aClass, Collection<ValidationError> validationErrors) {
        s= conertToTitleCase(s.toLowerCase());
        return super.convert(s, aClass, validationErrors);    //To change body of overridden methods use File | Settings | File Templates.
    }

    /*
    Convert alex marson to Alex Marson
     */
    private String conertToTitleCase(String actualName) {
        StringBuilder name = new StringBuilder(actualName);
        name.setCharAt(0, (char)(name.charAt(0) -32));

        for(int i = 1 ; i < name.length() ; i++){
            if(name.charAt(i -1) == ' ' && name.charAt(i) != ' '){
                name.setCharAt(i, (char)(name.charAt(i) -32));
            }
        }
        return name.toString();
    }
}