package au.com.toyota.nc.webapp.adapter;

import au.com.toyota.nc.common.model.hibernate.Position;
import au.com.toyota.nc.common.utils.NCConstants;
import net.sf.json.JSONObject;
import org.apache.log4j.Logger;

import java.text.SimpleDateFormat;

/**
 * User: Alex Wibowo
 * Date: 7/02/2009
 * Time: 13:17:41
 */
public class PositionJSONAdapter implements JSONAdapter{
    private static final Logger LOGGER = Logger.getLogger(PositionJSONAdapter.class.getName());

    public static final String PROPERTY_ID= "id";
    public static final String PROPERTY_DESCRIPTION = "description";
    public static final String PROPERTY_SAP_SALES_CATEGORY = "sapSalesCategory";
    public static final String PROPERTY_SAP_SALES_POSITION = "sapSalesPosition";
    public static final String PROPERTY_EXPORT_HARDCOPY = "exportHardcopy";
    public static final String PROPERTY_EXPORT_MAILMERGE = "exportMailmerge";
    public static final String PROPERTY_EFFECTIVE_DATE = "effectiveDate";
    public static final String PROPERTY_TERMINATION_DATE = "terminationDate";


    private Position position;


    public PositionJSONAdapter(Position position){
        this.position=position;
    }


    public JSONObject toJSONObject() {
        SimpleDateFormat formatter = new SimpleDateFormat(NCConstants.FORMAT_DD_MM_YYYY_HH_mm);


        JSONObject result = new JSONObject();
        result.put(PROPERTY_ID, position.getPositionId());
        result.put(PROPERTY_DESCRIPTION, position.getDescription());
        result.put(PROPERTY_SAP_SALES_CATEGORY, position.getSapSalesCategory());
        result.put(PROPERTY_SAP_SALES_POSITION, position.getSapSalesPosition());
        result.put(PROPERTY_EXPORT_HARDCOPY, position.getExportHardCopyFlag());
        result.put(PROPERTY_EXPORT_MAILMERGE, position.getExportMailMergeFlag());
        result.put(PROPERTY_EFFECTIVE_DATE, position.getEffectiveDate()!=null?formatter.format(position.getEffectiveDate()):"");
        result.put(PROPERTY_TERMINATION_DATE, position.getTerminationDate()!=null?formatter.format(position.getTerminationDate()):"");
        
        return result;
    }
}
