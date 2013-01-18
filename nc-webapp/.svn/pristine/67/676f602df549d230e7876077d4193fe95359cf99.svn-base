package au.com.toyota.nc.webapp.stripes.ext.handlers;

/**
 * <p>
 * When a 500 (internal server error) happens in NC then actions need to be taken (other than just directing to an error page). The
 * side-effects of this internal server error should be encapsulated within individual implementations of this interface. Each interested
 * listener will be notified of the exception and can deal with it in a manner that is appropriate.
 * </p>
 * <p>
 * The only condition of implementations of this interface is that they do NOT throw exceptions themself. If they were to do so then it
 * would merely cover up the original exception. Remember, the reason why this interface is being notified is because an exception
 * occurred in the first place. Throwing another exception would not cover up the original cause of the exception and not be very helpful
 * when it comes to investigating the problem.
 * </p>
 */
public interface ExceptionListener
{
    /**
     * Remember, implementations of this method must NOT throw any exception. See above for explanation
     */
    void notify(Throwable exception);
}
