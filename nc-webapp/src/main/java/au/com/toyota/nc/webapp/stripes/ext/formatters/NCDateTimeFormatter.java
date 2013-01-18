package au.com.toyota.nc.webapp.stripes.ext.formatters;

import au.com.toyota.nc.common.utils.NCConstants;
import net.sourceforge.stripes.exception.StripesRuntimeException;
import net.sourceforge.stripes.format.Formatter;
import org.apache.commons.lang.StringUtils;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

/**
 * <p>Implements a basic formatter for Date objects. Accept several known types, as well
 * as arbitrary patterns.</p>
 *
 * <p>The supported format types are:</p>
 * <ul>
 *      <li>date: formatting as {@link NCConstants#FORMAT_DD_MM_YYYY}</li>
 *      <li>datetime: formatting as {@link NCConstants#FORMAT_DD_MM_YYYY_HH_mm}</li> 
 * </ul>
 *
 * Format pattern allows arbitrary date format pattern to be used. Proceed with caution!
 *
 * User: Alex Wibowo
 * Date: Apr 27, 2009
 * Time: 2:59:18 PM
 */
public class NCDateTimeFormatter implements Formatter<Date> {

    private String formatType;

    private String formatPattern;

    private Locale locale;

    private SimpleDateFormat formatter;


    public void setFormatType(String formatType) {
       this.formatType=formatType;
    }

    public void setFormatPattern(String formatPattern) {
        this.formatPattern=formatPattern;
    }

    public void setLocale(Locale locale) {
        this.locale=locale;
    }

    public void init() {
        if (formatType == null) {
            setFormatType("date");
        }

        String lcFormatType = formatType.toLowerCase();

        if (StringUtils.isEmpty(formatPattern)) {
            if (lcFormatType.equals(DateFormatType.DATE.value)) {
                formatter = new SimpleDateFormat(DateFormatType.DATE.dateFormat);
            }else if (lcFormatType.equals(DateFormatType.DATE_TIME.value)) {
                formatter = new SimpleDateFormat(DateFormatType.DATE_TIME.dateFormat);
            }else{
                throw new StripesRuntimeException("Invalid formatType for Date: " + formatType +
                        ". Allowed types are '"+ DateFormatType.DATE.value+"', '"+ DateFormatType.DATE_TIME.value+"'.");
            }
        }else{
            formatter = new SimpleDateFormat(formatPattern);
        }
    }

    public String format(Date input) {
        return this.formatter.format(input);
    }

    public static enum DateFormatType {
        DATE("date", NCConstants.FORMAT_DD_MM_YYYY),
        DATE_TIME("datetime",NCConstants.FORMAT_DD_MM_YYYY_HH_mm );

        private String value;
        private String dateFormat;


        DateFormatType(String value, String dateFormat) {
            this.value = value;
            this.dateFormat=dateFormat;
        }

        public String getValue() {
            return value;
        }

        public String getDateFormat() {
            return dateFormat;
        }
    }
}
