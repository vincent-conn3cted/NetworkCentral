package au.com.toyota.nc.webapp.stripes.ext.converters;

import net.sourceforge.stripes.validation.LocalizableError;
import net.sourceforge.stripes.validation.StringTypeConverter;
import net.sourceforge.stripes.validation.ValidationError;
import org.apache.commons.lang.StringUtils;

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
public class PhoneNumberConverter extends StringTypeConverter{
    private static final int PHONENO_LENGTH = 10;

    public String convert(String s, Class<? extends String> aClass, Collection<ValidationError> validationErrors) {
        StringBuffer sb = new StringBuffer();
        s= StringUtils.deleteWhitespace(s);

        if (StringUtils.isNumeric(s)){
            if (s.length()== PHONENO_LENGTH){
                sb.append(s.substring(0,2));
                sb.append(" ");
                sb.append(s.substring(2,6));
                sb.append(" ");
                sb.append(s.substring(6, PHONENO_LENGTH));
            }else{
                validationErrors.add(new LocalizableError("error.common.validation.phoneno"));
            }
        }else{
            validationErrors.add(new LocalizableError("error.common.validation.phoneno"));
        }

        return super.convert(sb.toString(), aClass, validationErrors);    //To change body of overridden methods use File | Settings | File Templates.
    }
}