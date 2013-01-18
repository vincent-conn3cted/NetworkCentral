package au.com.toyota.nc.webapp.dataproxy;

import au.com.toyota.isd.common.ldap.model.DealershipUser;
import au.com.toyota.isd.common.ldap.model.User;
import au.com.toyota.nc.common.auth.LdapUserDao;
import au.com.toyota.nc.common.security.NCRole;
import au.com.toyota.nc.common.staff.AppointmentTopology;
import au.com.toyota.nc.common.staff.exceptions.MultipleRolesException;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import java.text.MessageFormat;
import java.util.*;

import static au.com.toyota.nc.common.security.NCRole.*;

/**
 * Data proxy class for retrieving {@link NCRole} applicable for a known {@link User}
 * <p/>
 * Date: Jun 10, 2009
 * Time: 2:05:10 PM
 *
 * @author Alex Wibowo
 */
@Component
public class NCRoleDataProxy {

    private static final Logger LOG = Logger.getLogger(NCRoleDataProxy.class.getName());

    @Autowired
    private AppointmentTopology appointmentTopology;

    @Autowired
    private LdapUserDao ldapUserDao;

    /**
     * Get the application role ({@link NCRole}) for a given {@link User}. Will use
     * {@link HttpServletRequest#isUserInRole(String)}  to decide the role
     * given to the user.
     *
     * @param request {@link HttpServletRequest}
     * @param user    {@link User}
     * @return single unique {@link NCRole} application role
     * @throws MultipleRolesException if user has more than one application role
     */
    public NCRole getApplicationRole(HttpServletRequest request, User user) throws MultipleRolesException {
        Set<NCRole> directUserRole = new HashSet<NCRole>();
        boolean isTMCAUser = isTMCAUser(user);
        LOG.info(MessageFormat.format("Is the user [{0}] a TMCA User? [{1}]", user, isTMCAUser));
        for (NCRole ncRole : NCRole.values()) {
            if (isUserInRole(request, user, ncRole, isTMCAUser)) {
                LOG.info(MessageFormat.format("Found initial role [{0}] for user [{1}]", ncRole, user));
                directUserRole.add(ncRole);
            }
        }

        // If user is a dealer searcher, but with dealer updater role in other location (under same dealer), we would like to include this dealer updater role in the list..
        Set<NCRole> combinedUserRole = assignDealerUpdaterIfNecessary(Collections.unmodifiableCollection(directUserRole), user);

        // We now do the filtering of the roles:
        // 1. If user has TMCARole & any other special TMCA user roles (NationalAdmin, etc), then take out TMCARole from the equation, and use the special role instead
        // 2. If user has both DealerSearcher & DealerUpdater, promote user to DealerUpdater
        Set<NCRole> filteredUserRole = filterRole(Collections.unmodifiableCollection(combinedUserRole));

        if (filteredUserRole.size() > 1) {
            throw MultipleRolesException.multipleRolesForStaff(user.getCn(), filteredUserRole);
        } else {
            Iterator<NCRole> roleIterator = filteredUserRole.iterator();
            if (roleIterator.hasNext()) {
                return filteredUserRole.iterator().next();
            } else {
                return null;
            }
        }
    }

    private Set<NCRole> assignDealerUpdaterIfNecessary(final Collection<NCRole> directUserRole, final User user) {
        Set<NCRole> combinedRole = new HashSet<NCRole>();
        combinedRole.addAll(directUserRole);

        if (directUserRole.contains(DealerSearcher) && !directUserRole.contains(DealerUpdater)) {
            // First fetch all user roles, which include all roles in other location (bound under different username)
            final Set<NCRole> allUserRoles = appointmentTopology.findDealerRolesForUser(user.getCn());

            // If it turns out that user has Dealer Updater, then add it to the
            if (allUserRoles.contains(DealerUpdater)) {
                combinedRole.add(DealerUpdater);
            }
        }
        return combinedRole;
    }

    private boolean isUserInRole(HttpServletRequest request, User user, NCRole role, boolean isTMCAUser) {
        switch (role) {
            // These two roles are not mapped in weblogic.xml, since they are special
            case DealerUpdater:
                return isDealerUser(user) && request.isUserInRole(DealerUpdater.name());
            case DealerSearcher:
                // any users under dealer tree
                return isDealerUser(user);
            case TMCASearcher:
                // any user under tmca tree
                return isTMCAUser;
            default:
                // All other roles belong to tmca user
                return isTMCAUser && request.isUserInRole(role.name());
        }
    }

    private Set<NCRole> filterRole(final Collection<NCRole> knownRoles) {
        Set<NCRole> filteredRoles = new HashSet<NCRole>();
        filteredRoles.addAll(knownRoles);
        if (knownRoles.size() == 1) {
            return filteredRoles;
        }
        filterDealerRoles(filteredRoles);
        filterTMCARoles(filteredRoles);
        return filteredRoles;
    }

    private void filterTMCARoles(Collection<NCRole> knownRoles) {
        // Handle the case where the known roles contains some of the roles in NCRole.TMCA_USER_ROLE, as well as TMCASearcher
        // In such situation, we would like to remove TMCASearcher from this list, and use the special role instead.
        // Collections.disjoint  returns <tt>true</tt> if the two specified collections have no  elements in common.
        if (knownRoles.contains(TMCASearcher) && !Collections.disjoint(knownRoles, NCRole.TMCA_USER_ROLE)) {
            knownRoles.remove(TMCASearcher);
        }
    }

    private void filterDealerRoles(Collection<NCRole> knownRoles) {
        // Handle the case where user is both DealerSearcher and DealerUpdater -> raise privilege to DealerUpdater
        if (knownRoles.contains(DealerUpdater) && knownRoles.contains(DealerSearcher)) {
            knownRoles.remove(DealerSearcher);
        }
    }


    /**
     * @param user {@link User}
     * @return <code>true</code> if logged in user belongs to dealer tree, <code>false</code> otherwise
     * @see au.com.toyota.isd.common.ldap.model.DealershipUser
     */
    private boolean isDealerUser(User user) {
        boolean isDealershipUser = user instanceof DealershipUser;
        LOG.info(MessageFormat.format("Is user [{0}] a dealership user? [{1}]", user, isDealershipUser));
        return isDealershipUser;
    }

    /**
     * @param user {@link User}
     * @return <code>true</code> if user exists in the user tree, and user is not an external user
     */
    private boolean isTMCAUser(User user) {
        boolean userExists = ldapUserDao.userExists(user.getCn());
        boolean externalUserExists = ldapUserDao.externalUserExists(user.getCn());
        return userExists && !externalUserExists;
    }

    public void setAppointmentTopology(AppointmentTopology appointmentTopology) {
        this.appointmentTopology = appointmentTopology;
    }

    public void setLdapUserDao(LdapUserDao ldapUserDao) {
        this.ldapUserDao = ldapUserDao;
    }
}
