package au.com.toyota.nc.webapp.stripes.ext.handlers.impl;

import au.com.toyota.nc.common.batch.email.NetworkCentralExceptionEmail;
import au.com.toyota.nc.common.email.EmailService;
import au.com.toyota.nc.common.email.exceptions.EmailServiceException;
import au.com.toyota.nc.webapp.stripes.ext.handlers.ExceptionListener;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.text.MessageFormat;
import java.util.List;

@Component
public class SendEmailExceptionListener implements ExceptionListener
{
    private static final Logger LOG = Logger.getLogger(SendEmailExceptionListener.class);

    @Autowired
    private EmailService emailService;

    @Resource(name = "networkCentralExceptionRecepients")
    private List<String> recepients;

    public void notify(Throwable exception)
    {
        try
        {
            if (!(exception instanceof java.net.SocketException || exception instanceof javax.servlet.jsp.el.ELException || exception instanceof java.lang.IllegalStateException )){
                LOG.warn("Notifying that exception");
                emailService.send(new NetworkCentralExceptionEmail(exception, recepients));
            }
        }
        catch (EmailServiceException e)
        {
            // do not re-throw exception, because it will cover up the original exception that is trying to be reported
            LOG.warn(MessageFormat.format("Got error message [{0}] when trying to send email of exception", e.getMessage()));
            e.printStackTrace();
        }
    }
}
