package au.com.toyota.nc.webapp.stripes.ext.formatters;

import net.sourceforge.stripes.format.DefaultFormatterFactory;
import net.sourceforge.stripes.format.Formatter;
import net.sourceforge.stripes.config.Configuration;
import net.sourceforge.stripes.integration.spring.SpringHelper;
import org.apache.log4j.Logger;

import javax.servlet.ServletContext;
import java.util.Date;
import java.util.Locale;
import java.sql.Timestamp;


/**
 * A custom formatter, that allows both custom network-central format, as well as injecting formatter with Spring beans.
 * All formatter can use {@link net.sourceforge.stripes.integration.spring.SpringBean} annotation just like how
 * {@link net.sourceforge.stripes.action.ActionBean} does this.
 *
 * User: Alex Wibowo
 * Date: Apr 27, 2009
 * Time: 2:55:10 PM
 */
public class NCFormatterFactory extends DefaultFormatterFactory {
    private static final Logger LOG = Logger.getLogger(NCFormatterFactory.class.getName());

    @Override
    public void init(Configuration configuration) throws Exception {
        super.init(configuration); 
        LOG.info("Initializing formatters..");

        LOG.info("Registering date & timestamp formatter..");
        add(Date.class, NCDateTimeFormatter.class);
        add(Timestamp.class, NCDateTimeFormatter.class);
    }

    @Override
    public Formatter<?> getFormatter(Class<?> clazz, Locale locale, String formatType, String formatPattern) {
        Formatter<?> formatter = super.getFormatter(clazz, locale, formatType, formatPattern);
        ServletContext sc = getConfiguration().getServletContext();
        SpringHelper.injectBeans(formatter, sc);
        return formatter;
    }
}
