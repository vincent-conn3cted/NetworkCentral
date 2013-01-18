package au.com.toyota.nc.webapp.stripes.ext.converters;

import net.sourceforge.stripes.validation.DateTypeConverter;
import net.sourceforge.stripes.validation.ValidationError;

import org.apache.log4j.Logger;
import java.util.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.text.ParseException;

import au.com.toyota.nc.common.utils.NCConstants;

/**
 * Extension of Stripes {@link DateTypeConverter} to support date format as specified in {@link au.com.toyota.nc.common.utils.NCConstants#NC_DATE_FORMATS}
 * <p/>
 * User: Alex Wibowo
 * Date: 09/02/2009
 * Time: 11:16:49 AM
 */
public class NCDateTypeConverter extends DateTypeConverter {
    private static final Logger LOGGER = Logger.getLogger(NCDateTypeConverter.class.getName());


    protected DateFormat[] getDateFormats() {
        List<DateFormat> formats = new ArrayList<DateFormat>();
        for (String ncDateFormat : NCConstants.NC_DATE_FORMATS) {
            SimpleDateFormat sdf = new SimpleDateFormat(ncDateFormat);
            formats.add(sdf);
        }
        formats.addAll(Arrays.asList(super.getDateFormats()));
        return formats.toArray(new DateFormat[]{});
    }

    protected String[] getFormatStrings() {
        List<String> formats = new ArrayList<String>();
        for (String ncDateFormat : NCConstants.NC_DATE_FORMATS) {
            formats.add(ncDateFormat);
        }
        formats.addAll(Arrays.asList(super.getFormatStrings()));
        return (String[]) formats.toArray(new String[]{});
    }

    public Date convert(String string, Class<? extends Date> aClass, Collection<ValidationError> collection) {
        Date date = null;

        // Attempt to parse using all known formats for network central.
        for (String ncDateFormat : NCConstants.NC_DATE_FORMATS) {
            SimpleDateFormat sdf = new SimpleDateFormat(ncDateFormat);
            try{
                date = sdf.parse(string);
                break;
            }catch(ParseException pe){/* Do nothing, we'll get lots of these. */}
        }

        // If we still cant get the date, handover to superclass to try it
        if (date == null) {
            date = super.convert(string, aClass, collection);
        }
        return date;
    }
}
