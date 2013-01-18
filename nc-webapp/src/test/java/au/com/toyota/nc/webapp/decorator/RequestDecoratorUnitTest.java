package au.com.toyota.nc.webapp.decorator;

import java.io.Serializable;
import java.util.Date;

import au.com.toyota.nc.common.model.hibernate.Status;
import junit.framework.TestCase;
import org.apache.log4j.Logger;
import org.junit.Test;

/**
 * User: Deepthi Fernando
 *
 * Date: 15/03/2009
 * Time: 13:43:46
 */
public class RequestDecoratorUnitTest extends TestCase
{
    private static final Logger LOG = Logger.getLogger(RequestDecoratorUnitTest.class);

    @Test
    public void testRequestDecorator()
    {
        assertEquals(getExpectedString(), RequestDecoratorHelper.getRequestParameterDecoratorString(new RequestDecoratorUnitTest().populateRequest()));
    }

    private String getExpectedString(){
        return "Your Search  for Effectivedate '01/01/1970' for Id '1000' for Length '30000000' for Name 'My New Name' for Newvalue '500000.0' for Note 'Note 1' for Salary '60000' for Status 'Active' for Time '600000000' and True 'false' returned the following results";
    }

    private DummyRequest populateRequest(){
        DummyRequest request = new DummyRequest();
        request.setEffectiveDate(new Date(0L));
        request.setId(1000);
        request.setLength(30000000L);
        request.setName("My New Name");
        request.setNewValue(500000F);
        request.setNote(new StringBuffer("Note 1"));
        request.setSalary(60000);
        request.setStatus(Status.Active);
        request.setTime(600000000);
        request.setTrue(Boolean.FALSE);

        return request;
    }

}

class DummyRequest implements Serializable {
    private int id;
    private long time;
    private String name;
    private Integer salary;
    private Long length;
    private Date effectiveDate;
    private StringBuffer note;
    private Float newValue;
    private Boolean isTrue;
    private Status status;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public long getTime() {
        return time;
    }

    public void setTime(long time) {
        this.time = time;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getSalary() {
        return salary;
    }

    public void setSalary(Integer salary) {
        this.salary = salary;
    }

    public Long getLength() {
        return length;
    }

    public void setLength(Long length) {
        this.length = length;
    }

    public Date getEffectiveDate() {
        return effectiveDate;
    }

    public void setEffectiveDate(Date effectiveDate) {
        this.effectiveDate = effectiveDate;
    }

    public StringBuffer getNote() {
        return note;
    }

    public void setNote(StringBuffer note) {
        this.note = note;
    }

    public Float getNewValue() {
        return newValue;
    }

    public void setNewValue(Float newValue) {
        this.newValue = newValue;
    }

    public Boolean getTrue() {
        return isTrue;
    }

    public void setTrue(Boolean aTrue) {
        isTrue = aTrue;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }
}