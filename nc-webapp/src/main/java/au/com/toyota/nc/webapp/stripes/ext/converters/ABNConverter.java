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
public class ABNConverter extends StringTypeConverter{
    private static final int ABN_LENGTH = 11;

    public String convert(String s, Class<? extends String> aClass, Collection<ValidationError> validationErrors) {
        StringBuffer sb = new StringBuffer();
        s= StringUtils.deleteWhitespace(s);

        if (StringUtils.isNumeric(s)){
            if (s.length()== ABN_LENGTH){
                sb.append(s.substring(0,2));
                sb.append(" ");
                sb.append(s.substring(2,5));
                sb.append(" ");
                sb.append(s.substring(5,8));
                sb.append(" ");
                sb.append(s.substring(8, ABN_LENGTH));
            }else{
                validationErrors.add(new LocalizableError("error.common.validation.abn"));
            }
        }else{
            validationErrors.add(new LocalizableError("error.common.validation.abn"));
        }
        return super.convert(sb.toString(), aClass, validationErrors);    //To change body of overridden methods use File | Settings | File Templates.
    }
}