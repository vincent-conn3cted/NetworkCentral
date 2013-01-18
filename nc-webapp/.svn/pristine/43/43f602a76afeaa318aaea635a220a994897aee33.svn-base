package au.com.toyota.nc.webapp.stripes.bulkimport;

import java.io.IOException;
import java.util.List;

import au.com.toyota.nc.common.bulkimport.BulkUserImportBroker;
import au.com.toyota.nc.common.bulkimport.BulkUserImportResponse;
import au.com.toyota.nc.webapp.stripes.BaseActionBean;
import net.sourceforge.stripes.action.DefaultHandler;
import net.sourceforge.stripes.action.FileBean;
import net.sourceforge.stripes.action.ForwardResolution;
import net.sourceforge.stripes.action.HandlesEvent;
import net.sourceforge.stripes.action.RedirectResolution;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.integration.spring.SpringBean;
import net.sourceforge.stripes.validation.ValidationMethod;
import org.apache.log4j.Logger;

public class BulkImportActionBean extends BaseActionBean
{
    private static final Logger LOGGER = Logger.getLogger(BulkImportActionBean.class.getName());

    private static final String EVENT_BULK_UPLOAD = "bulkUpload";

    private FileBean usersFile;
    private boolean loadForEdms;
    private List<BulkUserImportResponse> responses;

    @SpringBean
    private BulkUserImportBroker importBroker;

    @DefaultHandler
    public Resolution displayInitialPage()
    {
        loadForEdms = true;
        return new ForwardResolution(JSP_BASE + "/bulkimport/index.jsp");
    }

    @ValidationMethod(on=EVENT_BULK_UPLOAD)
    public void validateFileName()
    {
        if (usersFile == null || usersFile.getFileName().equals(""))
        {
            addSimpleGlobalError("Please select a .csv or .txt file to upload");
        }
        else
        {
            String[] filenameParts = usersFile.getFileName().split("\\.");
            String extensionInLowercase = filenameParts[filenameParts.length - 1].toLowerCase();
            LOGGER.debug("File name extension is: " + extensionInLowercase);
            if (!extensionInLowercase.equals("txt") && !extensionInLowercase.equals("csv"))
            {
                addSimpleGlobalError("Please select a .csv or .txt file to upload");
            }
        }
    }

    @HandlesEvent(EVENT_BULK_UPLOAD)
    public Resolution bulkUpload() throws IOException // userFile.getReader throws this
    {
        LOGGER.debug("Uploaded file: " + usersFile.getFileName() + " (load for eDMS is: " + loadForEdms + ")");
        this.responses = importBroker.importUsers(usersFile.getReader(), loadForEdms);
        return new RedirectResolution(BulkImportActionBean.class, "displayInitialPage").flash(this);
    }

    public FileBean getUsersFile()
    {
        return usersFile;
    }

    public void setUsersFile(FileBean usersFile)
    {
        this.usersFile = usersFile;
    }

    public boolean getLoadForEdms()
    {
        return loadForEdms;
    }

    public void setLoadForEdms(boolean loadForEdms)
    {
        this.loadForEdms = loadForEdms;
    }

    public List<BulkUserImportResponse> getResponses()
    {
        return responses;
    }
}
