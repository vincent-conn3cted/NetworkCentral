package au.com.toyota.nc.webapp.dataproxy;

import au.com.toyota.isd.common.ldap.model.User;
import au.com.toyota.isd.common.ldap.model.DealershipUser;
import au.com.toyota.nc.common.security.NCRole;
import au.com.toyota.nc.common.staff.AppointmentTopology;
import au.com.toyota.nc.common.auth.LdapUserDao;
import au.com.toyota.nc.webapp.NetworkCentralWebappTestCase;
import org.easymock.EasyMock;
import org.easymock.IMocksControl;
import static org.hamcrest.Matchers.is;
import static org.junit.Assert.assertThat;
import org.junit.Test;
import org.junit.Before;
import org.junit.After;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * Date: Jun 10, 2009
 * Time: 2:17:45 PM
 *
 * @author Alex Wibowo
 */
public class NCRoleDataProxyUnitTest extends NetworkCentralWebappTestCase {
    @Autowired
    private NCRoleDataProxy ncRoleDataProxy;

    private IMocksControl mockControl;

    private AppointmentTopology mockAppointmentTopology;

    private LdapUserDao mockLdapDao;
                                                                                                                                                                 

    @Before
    public void createMockAppointmentTopology() {
        mockControl = EasyMock.createNiceControl();
        mockAppointmentTopology = mockControl.createMock(AppointmentTopology.class);
        mockLdapDao = mockControl.createMock(LdapUserDao.class);
        ncRoleDataProxy.setAppointmentTopology(mockAppointmentTopology);
        ncRoleDataProxy.setLdapUserDao(mockLdapDao);
    }

    @After
    public void verifyMockControl() {
        mockControl.verify();
    }

    @Test
    public void given_dealeruser_with_dealersearcher_should_return_dealersearcher() throws Exception {
        final DealershipUser dealershipUser = new DealershipUser();
        dealershipUser.setCn("dealership.user");
        // here we dont expect the call to check user role in HttpServlet Request, since we are logging in as DealerUser
        HttpServletRequest mockRequest = mockControl.createMock(HttpServletRequest.class);
        EasyMock.expect(mockAppointmentTopology.findDealerRolesForUser("dealership.user")).andReturn(new HashSet<NCRole>(Arrays.asList(NCRole.DealerSearcher)));
        EasyMock.expect(mockLdapDao.userExists("dealership.user")).andReturn(true).anyTimes();
        EasyMock.expect(mockLdapDao.dealerUserExists("dealership.user")).andReturn(true).anyTimes();
        EasyMock.expect(mockLdapDao.externalUserExists("dealership.user")).andReturn(true).anyTimes();
        mockControl.replay();

        assertThat(ncRoleDataProxy.getApplicationRole(mockRequest, dealershipUser), is(NCRole.DealerSearcher));
    }


    @Test
    public void given_dealeruser_with_dealerupdater_and_dealersearcer_role_should_return_dealerupdater_role() throws Exception {
        final DealershipUser dealershipUser = new DealershipUser();
        dealershipUser.setCn("dealership.user");
        // here we dont expect the call to check user role in HttpServlet Request, since we are logging in as DealerUser
        HttpServletRequest mockRequest = mockControl.createMock(HttpServletRequest.class);
        EasyMock.expect(mockAppointmentTopology.findDealerRolesForUser("dealership.user")).andReturn(new HashSet<NCRole>(Arrays.asList(NCRole.DealerUpdater, NCRole.DealerSearcher)));
        EasyMock.expect(mockLdapDao.userExists("dealership.user")).andReturn(true).anyTimes();
        EasyMock.expect(mockLdapDao.dealerUserExists("dealership.user")).andReturn(true).anyTimes();
        EasyMock.expect(mockLdapDao.externalUserExists("dealership.user")).andReturn(true).anyTimes();
        mockControl.replay();

        assertThat(ncRoleDataProxy.getApplicationRole(mockRequest, dealershipUser), is(NCRole.DealerUpdater));
    }



    @Test
    public void given_tmcauser_with_tmcasearcherrole_should_return_tmcasearcher() throws Exception {
        HttpServletRequest mockRequest = mockControl.createMock(HttpServletRequest.class);
        // here we dont expect the call to check user role in HttpServlet Request, since we are logging in as TMCA user
        User user = new User();
        user.setCn("k00573");
        mockTMCAUser(user);
        mockControl.replay();
        assertThat(ncRoleDataProxy.getApplicationRole(mockRequest, user), is(NCRole.TMCASearcher));
    }

    private void mockTMCAUser(User user){
        EasyMock.expect(mockLdapDao.userExists(user.getCn())).andReturn(true).anyTimes();
        EasyMock.expect(mockLdapDao.dealerUserExists(user.getCn())).andReturn(false).anyTimes();
        EasyMock.expect(mockLdapDao.externalUserExists(user.getCn())).andReturn(false).anyTimes();
    }

    @Test
    public void given_tmca_user_with_nationaladmin_role_should_return_national_admin() throws Exception {
        final User user = new User();
        user.setCn("tmca.user");
        HttpServletRequest mockRequest = mockControl.createMock(HttpServletRequest.class);
        mockTMCAUser(user);
        for (NCRole ncRole : NCRole.values()) {
            if (NCRole.NationalAdministrator == ncRole) {
                EasyMock.expect(mockRequest.isUserInRole(ncRole.toString())).andReturn(true);
            }else if (NCRole.DealerUpdater == ncRole) {
                // do nothing... shouldnt call request.isUserInRole since user is not a dealer user
            }else if (NCRole.DealerSearcher != ncRole && NCRole.TMCASearcher != ncRole) {
                EasyMock.expect(mockRequest.isUserInRole(ncRole.toString())).andReturn(false);
            }
        }
        mockControl.replay();
        assertThat(ncRoleDataProxy.getApplicationRole(mockRequest, user), is(NCRole.NationalAdministrator));
    }

    @Test
    public void given_tmca_user_with_nationalfdd_role_should_return_nationalfdd() throws Exception {
          final User user = new User();
        user.setCn("tmca.user");
        HttpServletRequest mockRequest = mockControl.createMock(HttpServletRequest.class);
        mockTMCAUser(user);
        for (NCRole ncRole : NCRole.values()) {
            if (NCRole.NationalFranDev == ncRole) {
                EasyMock.expect(mockRequest.isUserInRole(ncRole.toString())).andReturn(true);
            }else if (NCRole.DealerUpdater == ncRole) {
                // do nothing... shouldnt call request.isUserInRole since user is not a dealer user

            }else if (NCRole.DealerSearcher != ncRole && NCRole.TMCASearcher != ncRole) {
                EasyMock.expect(mockRequest.isUserInRole(ncRole.toString())).andReturn(false);
            }
        }
        mockControl.replay();
        assertThat(ncRoleDataProxy.getApplicationRole(mockRequest, user), is(NCRole.NationalFranDev));
    }

    @Test
    public void given_tmca_user_with_nationalcsd_role_should_return_nationalcsd() throws Exception {
        final User user = new User();
        user.setCn("tmca.user");
        HttpServletRequest mockRequest = mockControl.createMock(HttpServletRequest.class);
        mockTMCAUser(user);
        for (NCRole ncRole : NCRole.values()) {
            if (NCRole.NationalCSD == ncRole) {
                EasyMock.expect(mockRequest.isUserInRole(ncRole.toString())).andReturn(true);
            }else if (NCRole.DealerUpdater == ncRole) {
                // do nothing... shouldnt call request.isUserInRole since user is not a dealer user

            }else if (NCRole.DealerSearcher != ncRole && NCRole.TMCASearcher != ncRole) {
                EasyMock.expect(mockRequest.isUserInRole(ncRole.toString())).andReturn(false);
            }
        }
        mockControl.replay();
        assertThat(ncRoleDataProxy.getApplicationRole(mockRequest, user), is(NCRole.NationalCSD));
    }

    @Test
    public void given_tmca_user_with_nationalsales_role_should_return_nationalsales() throws Exception {
          final User user = new User();
        user.setCn("tmca.user");
        HttpServletRequest mockRequest = mockControl.createMock(HttpServletRequest.class);
        mockTMCAUser(user);
        for (NCRole ncRole : NCRole.values()) {
            if (NCRole.NationalSales == ncRole) {
                EasyMock.expect(mockRequest.isUserInRole(ncRole.toString())).andReturn(true);
            }else if (NCRole.DealerUpdater == ncRole) {
                // do nothing... shouldnt call request.isUserInRole since user is not a dealer user

            }else if (NCRole.DealerSearcher != ncRole && NCRole.TMCASearcher != ncRole) {
                EasyMock.expect(mockRequest.isUserInRole(ncRole.toString())).andReturn(false);
            }
        }
        mockControl.replay();
        assertThat(ncRoleDataProxy.getApplicationRole(mockRequest, user), is(NCRole.NationalSales));
    }

    @Test
    public void given_tmca_user_with_support_role_should_return_support() throws Exception{
        final User user = new User();
        user.setCn("tmca.user");
        HttpServletRequest mockRequest = mockControl.createMock(HttpServletRequest.class);
        mockTMCAUser(user);
        for (NCRole ncRole : NCRole.values()) {
            if (NCRole.Support == ncRole) {
                EasyMock.expect(mockRequest.isUserInRole(ncRole.toString())).andReturn(true);
            }else if (NCRole.DealerUpdater == ncRole) {
                // do nothing... shouldnt call request.isUserInRole since user is not a dealer user

            }else if (NCRole.DealerSearcher != ncRole && NCRole.TMCASearcher != ncRole) {
                EasyMock.expect(mockRequest.isUserInRole(ncRole.toString())).andReturn(false);
            }
        }
        mockControl.replay();
        assertThat(ncRoleDataProxy.getApplicationRole(mockRequest, user), is(NCRole.Support));
    }

    @Test
    public void given_tmca_user_with_nationalcr_role_should_return_nationalcr() throws Exception{
         final User user = new User();
        user.setCn("tmca.user");
        HttpServletRequest mockRequest = mockControl.createMock(HttpServletRequest.class);
        mockTMCAUser(user);
        for (NCRole ncRole : NCRole.values()) {
            if (NCRole.NationalCR == ncRole) {
                EasyMock.expect(mockRequest.isUserInRole(ncRole.toString())).andReturn(true);
            }else if (NCRole.DealerUpdater == ncRole) {
                // do nothing... shouldnt call request.isUserInRole since user is not a dealer user

            }else if (NCRole.DealerSearcher != ncRole && NCRole.TMCASearcher != ncRole) {
                EasyMock.expect(mockRequest.isUserInRole(ncRole.toString())).andReturn(false);
            }
        }
        mockControl.replay();
        assertThat(ncRoleDataProxy.getApplicationRole(mockRequest, user), is(NCRole.NationalCR));
    }

    @Test
    public void given_tmca_user_with_lexus_role_should_return_lexus()throws Exception{
         final User user = new User();
        user.setCn("tmca.user");
        HttpServletRequest mockRequest = mockControl.createMock(HttpServletRequest.class);
        mockTMCAUser(user);
        for (NCRole ncRole : NCRole.values()) {
            if (NCRole.Lexus == ncRole) {
                EasyMock.expect(mockRequest.isUserInRole(ncRole.toString())).andReturn(true);
            }else if (NCRole.DealerUpdater == ncRole) {
                // do nothing... shouldnt call request.isUserInRole since user is not a dealer user

            }else if (NCRole.DealerSearcher != ncRole && NCRole.TMCASearcher != ncRole) {
                EasyMock.expect(mockRequest.isUserInRole(ncRole.toString())).andReturn(false);
            }
        }
        mockControl.replay();
        assertThat(ncRoleDataProxy.getApplicationRole(mockRequest, user), is(NCRole.Lexus));
    }

    @Test
    public void given_tmca_user_with_regionalfdd_role_should_return_regionalfdd() throws Exception{
         final User user = new User();
        user.setCn("tmca.user");
        HttpServletRequest mockRequest = mockControl.createMock(HttpServletRequest.class);
        mockTMCAUser(user);
        for (NCRole ncRole : NCRole.values()) {
            if (NCRole.RegionalFranDev == ncRole) {
                EasyMock.expect(mockRequest.isUserInRole(ncRole.toString())).andReturn(true);
            }else if (NCRole.DealerUpdater == ncRole) {
                // do nothing... shouldnt call request.isUserInRole since user is not a dealer user

            }else if (NCRole.DealerSearcher != ncRole && NCRole.TMCASearcher != ncRole) {
                EasyMock.expect(mockRequest.isUserInRole(ncRole.toString())).andReturn(false);
            }
        }
        mockControl.replay();
        assertThat(ncRoleDataProxy.getApplicationRole(mockRequest, user), is(NCRole.RegionalFranDev));
    }
    @Test
    public void given_tmca_user_with_regionalcsd_role_should_return_regionalcsd() throws Exception{
         final User user = new User();
        user.setCn("tmca.user");
        HttpServletRequest mockRequest = mockControl.createMock(HttpServletRequest.class);
        mockTMCAUser(user);
        for (NCRole ncRole : NCRole.values()) {
            if (NCRole.RegionalCSD == ncRole) {
                EasyMock.expect(mockRequest.isUserInRole(ncRole.toString())).andReturn(true);
            }else if (NCRole.DealerUpdater == ncRole) {
                // do nothing... shouldnt call request.isUserInRole since user is not a dealer user

            }else if (NCRole.DealerSearcher != ncRole && NCRole.TMCASearcher != ncRole) {
                EasyMock.expect(mockRequest.isUserInRole(ncRole.toString())).andReturn(false);
            }
        }
        mockControl.replay();
        assertThat(ncRoleDataProxy.getApplicationRole(mockRequest, user), is(NCRole.RegionalCSD));
    }

    @Test
    public void given_tmca_user_with_regionalsales_role_should_return_regionalsales()throws Exception{
         final User user = new User();
        user.setCn("tmca.user");
        HttpServletRequest mockRequest = mockControl.createMock(HttpServletRequest.class);
        mockTMCAUser(user);
        for (NCRole ncRole : NCRole.values()) {
            if (NCRole.RegionalSales == ncRole) {
                EasyMock.expect(mockRequest.isUserInRole(ncRole.toString())).andReturn(true);
            } else if (NCRole.DealerUpdater == ncRole) {
                // do nothing... shouldnt call request.isUserInRole since user is not a dealer user
                
            }else if (NCRole.DealerSearcher != ncRole && NCRole.TMCASearcher != ncRole) {
                EasyMock.expect(mockRequest.isUserInRole(ncRole.toString())).andReturn(false);
            }
        }
        mockControl.replay();
        assertThat(ncRoleDataProxy.getApplicationRole(mockRequest, user), is(NCRole.RegionalSales));
    }


}
