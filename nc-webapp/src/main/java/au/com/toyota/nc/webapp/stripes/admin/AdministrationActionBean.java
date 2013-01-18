package au.com.toyota.nc.webapp.stripes.admin;

import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import net.sourceforge.stripes.action.DefaultHandler;
import net.sourceforge.stripes.action.ForwardResolution;
import net.sourceforge.stripes.action.Resolution;

import org.apache.log4j.Logger;

import au.com.toyota.nc.common.comparartors.GenericComparator;
import au.com.toyota.nc.common.model.hibernate.PositionDefinition;
import au.com.toyota.nc.webapp.stripes.BaseActionBean;

/**
 * User: Alex Wibowo
 * Date: 19/11/2008
 * Time: 17:08:05
 */
public class AdministrationActionBean extends BaseActionBean {
    private static final Logger LOG = Logger.getLogger(AdministrationActionBean.class.getName());

    protected static final String ADMIN_JSP_BASE = JSP_BASE + "/admin";
    
    private List<Long> positionDefinitionsIdsSelect;

    @DefaultHandler
    public Resolution displayAdminMenu() {
        return new ForwardResolution(ADMIN_JSP_BASE + "/adminMenu.jsp");
    }
    
    public List<PositionDefinition> getAllActivePositionDefinitions()
    {
        Set<PositionDefinition> allActivePositionDefinitions = new LinkedHashSet<PositionDefinition>(masterTableServices.findAllActive(PositionDefinition.class));
        List<PositionDefinition> allActivePositionDefinitionList = new ArrayList<PositionDefinition>(allActivePositionDefinitions);
        Collections.sort(allActivePositionDefinitionList, new GenericComparator<PositionDefinition>("description", true));       
        return allActivePositionDefinitionList;
    }

	public List<Long> getPositionDefinitionsIdsSelect() {
		return positionDefinitionsIdsSelect;
	}

	public void setPositionDefinitionsIdsSelect(
			List<Long> positionDefinitionsIdsSelect) {
		this.positionDefinitionsIdsSelect = positionDefinitionsIdsSelect;
	}
    
}
