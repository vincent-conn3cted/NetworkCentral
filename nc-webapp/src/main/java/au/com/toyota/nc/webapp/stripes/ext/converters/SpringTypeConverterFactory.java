package au.com.toyota.nc.webapp.stripes.ext.converters;

import java.util.Date;
import java.util.Locale;
import javax.servlet.ServletContext;

import au.com.toyota.nc.common.model.hibernate.CommonValueTypes;
import au.com.toyota.nc.common.model.hibernate.TMCAStaff;
import au.com.toyota.nc.common.model.search.LocationTypeSearchOption;
import au.com.toyota.nc.common.model.search.RegionSearchOption;
import net.sourceforge.stripes.config.Configuration;
import net.sourceforge.stripes.integration.spring.SpringHelper;
import net.sourceforge.stripes.validation.DefaultTypeConverterFactory;
import net.sourceforge.stripes.validation.TypeConverter;
import org.apache.log4j.Logger;

/**
 * The default type converter factory ({@link DefaultTypeConverterFactory}) doesnt do Spring injection.
 * This converter factory extends the default implementation, and use {@link SpringHelper} to inject
 * Spring bean dependencies. All type converters can use {@link net.sourceforge.stripes.integration.spring.SpringBean}
 * annotation just like how {@link net.sourceforge.stripes.action.ActionBean} does this.
 * 
 * User: Alex Wibowo
 * Date: 3/02/2009
 * Time: 12:15:34
 */
public class SpringTypeConverterFactory extends DefaultTypeConverterFactory {
    private static final Logger LOGGER = Logger.getLogger(SpringTypeConverterFactory.class.getName());

    public void init(Configuration configuration) {
        // Overriden method
        super.init(configuration);
        LOGGER.info("Initialising type converters..");


        // Iterate through each classes of the CommonValue class... and use NCCommonValueConverter as their converters
        LOGGER.info("Registering common type value converter");
        for (CommonValueTypes commonValueType : CommonValueTypes.values()) {
            add(commonValueType.getClazz(), NCCommonValueConverter.class);
        }

        LOGGER.info("Registering TMCAStaffConverter");
        add(TMCAStaff.class, TMCAStaffConverter.class);

        LOGGER.info("Registering NCDateTypeConverter");
        add(Date.class, NCDateTypeConverter.class);

        LOGGER.info("Registering LocationTypeSearchOptionsTypeConverter");
        add(LocationTypeSearchOption.class, LocationTypeSearchOptionsTypeConverter.class);

        LOGGER.info("Registering RegionSearchOptionsTypeConverter");
        add(RegionSearchOption.class, RegionSearchOptionsTypeConverter.class);
    }

    public TypeConverter getInstance(Class<? extends TypeConverter> clazz, Locale locale) throws Exception {
        TypeConverter tc = super.getInstance(clazz, locale);
        ServletContext sc = getConfiguration().getServletContext();
        SpringHelper.injectBeans(tc, sc);

        return tc;
    }
}
