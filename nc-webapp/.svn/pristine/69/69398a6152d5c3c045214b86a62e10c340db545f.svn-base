package au.com.toyota.nc.webapp.stripes.ext.converters;

import net.sourceforge.stripes.validation.TypeConverter;
import net.sourceforge.stripes.validation.ValidationError;
import net.sourceforge.stripes.integration.spring.SpringBean;
import au.com.toyota.nc.common.model.hibernate.TMCAStaff;
import au.com.toyota.nc.common.staff.StaffServices;

import java.util.Locale;
import java.util.Collection;

import org.apache.log4j.Logger;

/**
 * User: Alex Wibowo
 * Date: 21/02/2009
 * Time: 12:09:16 AM
 */
public class TMCAStaffConverter implements TypeConverter<TMCAStaff> {
    private static final Logger LOG = Logger.getLogger(NCCommonValueConverter.class.getName());

    @SpringBean("peopleServices")
    private StaffServices staffServices;

    public void setLocale(Locale locale) {
        // Do nothing.  This doesn't use locales.
    }

    public TMCAStaff convert(String formVal, Class<? extends TMCAStaff> targetClass, Collection<ValidationError> errors) {
        LOG.info("Finding tmcastaff with id " + formVal);
        TMCAStaff tmcaStaff = staffServices.getTMCAStaff(Long.parseLong(formVal));
        return tmcaStaff;
    }
}

