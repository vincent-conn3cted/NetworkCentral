package au.com.toyota.nc.webapp.auditing.interceptors;

import au.com.toyota.nc.common.interceptors.RequestScopeRegistry;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.controller.ExecutionContext;
import net.sourceforge.stripes.controller.Interceptor;
import net.sourceforge.stripes.controller.Intercepts;
import net.sourceforge.stripes.controller.LifecycleStage;

import java.security.Principal;

@Intercepts(LifecycleStage.HandlerResolution)
public class RequestScopeRegistryInitializationInterceptor implements Interceptor
{
    public Resolution intercept(ExecutionContext executionContext) throws Exception
    {
        final Principal userPrincipal = executionContext.getActionBeanContext().getRequest().getUserPrincipal();
        if(userPrincipal != null)
        {
            final String userCn = userPrincipal.getName();
            RequestScopeRegistry.setUserCn(userCn);
        }
        return executionContext.proceed();
    }
}
