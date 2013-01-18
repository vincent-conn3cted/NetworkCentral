package au.com.toyota.nc.webapp.stripes.bulkimport;

import java.util.ArrayList;
import java.util.List;

import net.sourceforge.stripes.action.FileBean;
import org.junit.Test;

import static org.hamcrest.core.Is.is;
import static org.junit.Assert.assertThat;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: Mar 18, 2010
 * Time: 4:55:14 PM
 * To change this template use File | Settings | File Templates.
 */
public class BulkImportActionBeanTest
{
    private class TestBulkImportActionBean extends BulkImportActionBean
    {
        public List<String> errors = new ArrayList<String>();
        @Override
        public void addSimpleGlobalError(String errorMessage, Object... params) {
            errors.add(errorMessage);
        }
    }

    @Test
    public void field_name_validation_should_allow_txt() throws Exception {
        // given
        TestBulkImportActionBean testActionBean = new TestBulkImportActionBean();
        testActionBean.setUsersFile(createTestFileBean("some-file.txt"));

        // when
        testActionBean.validateFileName();

        // then
        assertThat(testActionBean.errors.size(), is(0));
    }

    @Test
    public void field_name_validation_should_allow_csv() throws Exception {
        // given
        TestBulkImportActionBean testActionBean = new TestBulkImportActionBean();
        testActionBean.setUsersFile(createTestFileBean("some-file.csv"));

        // when
        testActionBean.validateFileName();

        // then
        assertThat(testActionBean.errors.size(), is(0));
    }

    @Test
    public void field_name_validation_should_allow_csv_with_multiple_dots() throws Exception {
        // given
        TestBulkImportActionBean testActionBean = new TestBulkImportActionBean();
        testActionBean.setUsersFile(createTestFileBean("some-file.new.csv"));

        // when
        testActionBean.validateFileName();

        // then
        assertThat(testActionBean.errors.size(), is(0));
    }

    @Test
    public void field_name_validation_should_not_allow_png() throws Exception {
        // given
        TestBulkImportActionBean testActionBean = new TestBulkImportActionBean();
        testActionBean.setUsersFile(createTestFileBean("some-file.png"));

        // when
        testActionBean.validateFileName();

        // then
        assertThat(testActionBean.errors.size(), is(1));
    }

    @Test
    public void field_name_validation_should_not_allow_png_with_multiple_dots() throws Exception {
        // given
        TestBulkImportActionBean testActionBean = new TestBulkImportActionBean();
        testActionBean.setUsersFile(createTestFileBean("some-file.new.png"));

        // when
        testActionBean.validateFileName();

        // then
        assertThat(testActionBean.errors.size(), is(1));
    }

    @Test
    public void field_name_validation_should_not_allow_an_empty_file_extension() throws Exception {
        // given
        TestBulkImportActionBean testActionBean = new TestBulkImportActionBean();
        testActionBean.setUsersFile(createTestFileBean("some-file."));

        // when
        testActionBean.validateFileName();

        // then
        assertThat(testActionBean.errors.size(), is(1));
    }

    @Test
    public void field_name_validation_should_not_allow_no_file_extension() throws Exception {
        // given
        TestBulkImportActionBean testActionBean = new TestBulkImportActionBean();
        testActionBean.setUsersFile(createTestFileBean("some-file"));

        // when
        testActionBean.validateFileName();

        // then
        assertThat(testActionBean.errors.size(), is(1));
    }

    private FileBean createTestFileBean(final String filename)
    {
        return new FileBean(null, null, null) {
            public String getFileName() {
                return filename;
            }
        };
    }
}
