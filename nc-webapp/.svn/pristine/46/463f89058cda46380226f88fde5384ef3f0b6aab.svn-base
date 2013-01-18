package au.com.toyota.nc.webapp.stripes.ext.converters;

import au.com.toyota.nc.common.model.hibernate.CommonValue;
import au.com.toyota.nc.common.services.MasterTableServices;
import net.sourceforge.stripes.integration.spring.SpringBean;
import net.sourceforge.stripes.validation.TypeConverter;
import net.sourceforge.stripes.validation.ValidationError;

import java.util.Collection;
import java.util.Locale;
import org.apache.log4j.Logger;

/**
 * Implementation of Stripes {@link TypeConverter} to fetch concrete {@link CommonValue} for a given id.
 * <p/>
 * User: Alex Wibowo
 * Date: 3/02/2009
 * Time: 12:12:32
 */
public class NCCommonValueConverter implements TypeConverter<CommonValue> {
    private static final Logger LOGGER = Logger.getLogger(NCCommonValueConverter.class.getName());

    @SpringBean("masterTableServices")
    private MasterTableServices masterTableServices;


    public void setLocale(Locale locale) {
        // Do nothing.  This doesn't use locales.
    }

    /**
     * @param formVal the persistence id of the common value. i.e {@link CommonValue#commonValueId}
     * @param targetClass concrete {@link CommonValue} class
     * @param errors an empty collection of validation errors that should be populated by the
     *        converter for any errors that occur during validation that are user input related.
     * @return concrete instance of targetClass with the given formVal id
     */
    public CommonValue convert(String formVal, Class<? extends CommonValue> targetClass, Collection<ValidationError> errors) {
        CommonValue value = masterTableServices.get(targetClass, Long.parseLong(formVal));
        //TODO: error handling... put into errors variable... etc
        return value;
    }
}
