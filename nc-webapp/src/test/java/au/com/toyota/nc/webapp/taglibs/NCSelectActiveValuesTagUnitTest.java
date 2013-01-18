package au.com.toyota.nc.webapp.taglibs;

import au.com.toyota.nc.common.AbstractUnitTestCase;
import au.com.toyota.nc.common.model.hibernate.BusinessImprovement;
import au.com.toyota.nc.common.model.hibernate.CommonValue;
import au.com.toyota.nc.common.security.NCFieldPermission;
import static au.com.toyota.nc.common.security.NCFieldPermission.None;
import static au.com.toyota.nc.common.security.NCFieldPermission.Read;
import static au.com.toyota.nc.common.security.NCFieldPermission.Write;
import static au.com.toyota.nc.matchers.hamcrest.BlankStringMatcher.blank;
import static org.easymock.EasyMock.expect;
import org.easymock.classextension.EasyMock;
import org.easymock.classextension.IMocksControl;
import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;
import org.junit.Before;
import org.junit.Test;

import static javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE;
import static javax.servlet.jsp.tagext.Tag.SKIP_BODY;
import java.util.ArrayList;
import static java.util.Arrays.asList;
import java.util.List;

public class NCSelectActiveValuesTagUnitTest extends AbstractUnitTestCase
{
    private NCSelectActiveValuesTag tag;
    private NetworkCentralPageContext pageContext;
    private List collections;
    private CommonValue bigImprovement;
    private CommonValue smallImprovement;
    private CommonValue moderateImprovement;
    private CommonValue selectedImprovement;
    private IMocksControl strictControl;
    private NCTagHelper tagHelperMock;
    private static final String FIELD_NAME = "globalName";
    private static final String VALUE_ATTRIBUTE = "commonValueId";
    private static final String LABEL_ATTRIBUTE = "value";

    @Before
    public void createTag() throws Exception
    {
        strictControl = EasyMock.createStrictControl();
        tagHelperMock = strictControl.createMock(NCTagHelper.class);

        pageContext = new NetworkCentralPageContext();
        tag = new NCSelectActiveValuesTag(pageContext);
        tag.setName(FIELD_NAME);
        tag.setHelper(tagHelperMock);

        selectedImprovement = commonValueTestBuilder.withClass(BusinessImprovement.class).withCommonValueId(15L).withValue("Selected Improvement").create();
        bigImprovement = commonValueTestBuilder.withClass(BusinessImprovement.class).withCommonValueId(10L).withValue("Big Improvement").create();
        smallImprovement = commonValueTestBuilder.withClass(BusinessImprovement.class).withCommonValueId(5L).withValue("Small Improvements").create();
        moderateImprovement = commonValueTestBuilder.withClass(BusinessImprovement.class).withCommonValueId(20L).withValue("Moderate").create();
        collections = new ArrayList(asList(bigImprovement, smallImprovement, moderateImprovement));
    }

    @Test
    public void should_render_a_select_list_with_all_options_in_the_collection() throws Exception
    {
        tag.setCollections(collections);
        tag.setValueAttribute(VALUE_ATTRIBUTE);
        tag.setLabelAttribute(LABEL_ATTRIBUTE);
        tag.setSelectedObject(null);

        assertThat(pageContext.getBody(), is(blank()));
        final int response = generateTagForPermission(Write);
        assertThat(response, is(EVAL_BODY_INCLUDE));

        final String body = pageContext.getBody();

        StringBuilder expectationBuilder = new StringBuilder();
        expectationBuilder.append("<select name=\""+FIELD_NAME+"\">");
        expectationBuilder.append("<option value=\"").append(bigImprovement.getCommonValueId()).append("\" >");
        expectationBuilder.append(bigImprovement.getValue());
        expectationBuilder.append("</option>");
        expectationBuilder.append("<option value=\"").append(smallImprovement.getCommonValueId()).append("\" >");
        expectationBuilder.append(smallImprovement.getValue());
        expectationBuilder.append("</option>");
        expectationBuilder.append("<option value=\"").append(moderateImprovement.getCommonValueId()).append("\" >");
        expectationBuilder.append(moderateImprovement.getValue());
        expectationBuilder.append("</option>");
        expectationBuilder.append("</select>");

        assertThat(body, is(expectationBuilder.toString()));
    }


    @Test
    public void should_allow_selection_by_comparing_using_valueattribute_regardless_of_object_identity() throws Exception{
        tag.setCollections(collections);
        tag.setValueAttribute(VALUE_ATTRIBUTE);
        tag.setLabelAttribute(LABEL_ATTRIBUTE);

        BusinessImprovement  val = new BusinessImprovement();
        val.setCommonValueId(bigImprovement.getCommonValueId());
        val.setValue(bigImprovement.getValue());
        tag.setSelectedObject(val);

        assertThat(pageContext.getBody(), is(blank()));
        final int response = generateTagForPermission(Write);
        assertThat(response, is(EVAL_BODY_INCLUDE));

        final String body = pageContext.getBody();

        StringBuilder expectationBuilder = new StringBuilder();
        expectationBuilder.append("<select name=\""+FIELD_NAME+"\">");
          expectationBuilder.append("<option selected=\"\" value=\"").append(bigImprovement.getCommonValueId()).append("\" >");
        expectationBuilder.append(bigImprovement.getValue());
        expectationBuilder.append("</option>");
        expectationBuilder.append("<option value=\"").append(smallImprovement.getCommonValueId()).append("\" >");
        expectationBuilder.append(smallImprovement.getValue());
        expectationBuilder.append("</option>");
        expectationBuilder.append("<option value=\"").append(moderateImprovement.getCommonValueId()).append("\" >");
        expectationBuilder.append(moderateImprovement.getValue());
        expectationBuilder.append("</option>");
        expectationBuilder.append("</select>");

        assertThat(body, is(expectationBuilder.toString()));
    }

    @Test
    public void given_empty_collection_and_brandnewobject_should_append_as_single_selected_option() throws Exception{
        tag.setValueAttribute(VALUE_ATTRIBUTE);
        tag.setLabelAttribute(LABEL_ATTRIBUTE);


        // Compose brand new object that doesnt exist in the collection, and give new ID too...
        BusinessImprovement  val = new BusinessImprovement();
        val.setCommonValueId(100L);
        tag.setSelectedObject(val);

        assertThat(pageContext.getBody(), is(blank()));
        final int response = generateTagForPermission(Write);
        assertThat(response, is(EVAL_BODY_INCLUDE));

        final String body = pageContext.getBody();

        StringBuilder expectationBuilder = new StringBuilder();
        expectationBuilder.append("<select name=\""+FIELD_NAME+"\">");
        expectationBuilder.append("<option selected=\"\" value=\"").append(val.getCommonValueId()).append("\" >");
        expectationBuilder.append("</option>");
        expectationBuilder.append("</select>");

        assertThat(body, is(expectationBuilder.toString()));
    }


    @Test
    public void given_brandnewobject_that_doesnt_exist_in_collection_should_append_as_new_option_and_select_it() throws Exception {
        tag.setCollections(collections);
        tag.setValueAttribute(VALUE_ATTRIBUTE);
        tag.setLabelAttribute(LABEL_ATTRIBUTE);


        // Compose brand new object that doesnt exist in the collection, and give new ID too...
        BusinessImprovement  val = new BusinessImprovement();
        val.setValue("blah");
        val.setCommonValueId(100L);
        tag.setSelectedObject(val);

        assertThat(pageContext.getBody(), is(blank()));
        final int response = generateTagForPermission(Write);
        assertThat(response, is(EVAL_BODY_INCLUDE));

        final String body = pageContext.getBody();

        StringBuilder expectationBuilder = new StringBuilder();
        expectationBuilder.append("<select name=\""+FIELD_NAME+"\">");
        expectationBuilder.append("<option value=\"").append(bigImprovement.getCommonValueId()).append("\" >");
        expectationBuilder.append(bigImprovement.getValue());
        expectationBuilder.append("</option>");
        expectationBuilder.append("<option value=\"").append(smallImprovement.getCommonValueId()).append("\" >");
        expectationBuilder.append(smallImprovement.getValue());
        expectationBuilder.append("</option>");
        expectationBuilder.append("<option value=\"").append(moderateImprovement.getCommonValueId()).append("\" >");
        expectationBuilder.append(moderateImprovement.getValue());
        expectationBuilder.append("</option>");
        expectationBuilder.append("<option selected=\"\" value=\"").append(val.getCommonValueId()).append("\" >");
        expectationBuilder.append("blah");
        expectationBuilder.append("</option>");
        expectationBuilder.append("</select>");

        assertThat(body, is(expectationBuilder.toString()));
    }


    @Test
    public void should_allow_selection_by_comparing_using_valueattribute_and_nullvalue_regardless_of_object_identity() throws Exception {
        collections.add(selectedImprovement);
        tag.setCollections(collections);
        tag.setValueAttribute(VALUE_ATTRIBUTE);
        tag.setLabelAttribute(LABEL_ATTRIBUTE);

        // Create brand new object, and set the identity as something thats in the collection
        BusinessImprovement val = new BusinessImprovement();
        val.setCommonValueId(selectedImprovement.getCommonValueId());
        tag.setSelectedObject(val);

        assertThat(pageContext.getBody(), is(blank()));
        final int response = generateTagForPermission(Write);
        assertThat(response, is(EVAL_BODY_INCLUDE));

        final String body = pageContext.getBody();

        StringBuilder expectationBuilder = new StringBuilder();
        expectationBuilder.append("<select name=\"" + FIELD_NAME + "\">");
        expectationBuilder.append("<option value=\"").append(bigImprovement.getCommonValueId()).append("\" >");
        expectationBuilder.append(bigImprovement.getValue());
        expectationBuilder.append("</option>");
        expectationBuilder.append("<option value=\"").append(smallImprovement.getCommonValueId()).append("\" >");
        expectationBuilder.append(smallImprovement.getValue());
        expectationBuilder.append("</option>");
        expectationBuilder.append("<option value=\"").append(moderateImprovement.getCommonValueId()).append("\" >");
        expectationBuilder.append(moderateImprovement.getValue());
        expectationBuilder.append("</option>");
        expectationBuilder.append("<option selected=\"\" value=\"").append(selectedImprovement.getCommonValueId()).append("\" >");
        expectationBuilder.append(selectedImprovement.getValue());
        expectationBuilder.append("</option>");
        expectationBuilder.append("</select>");

        assertThat(body, is(expectationBuilder.toString()));
    }


    @Test
    public void should_include_the_selectedObject_in_the_rendered_select_list_as_selected() throws Exception
    {
        tag.setCollections(null);
        tag.setValueAttribute(VALUE_ATTRIBUTE);
        tag.setLabelAttribute(LABEL_ATTRIBUTE);
        tag.setSelectedObject(selectedImprovement);

        assertThat(pageContext.getBody(), is(blank()));
        final int response = generateTagForPermission(Write);
        assertThat(response, is(EVAL_BODY_INCLUDE));

        final String body = pageContext.getBody();

        StringBuilder expectationBuilder = new StringBuilder();
        expectationBuilder.append("<select name=\""+FIELD_NAME+"\">");
        expectationBuilder.append("<option selected=\"\" value=\"").append(selectedImprovement.getCommonValueId()).append("\" >");
        expectationBuilder.append(selectedImprovement.getValue());
        expectationBuilder.append("</option>");
        expectationBuilder.append("</select>");

        assertThat(body, is(expectationBuilder.toString()));
    }

    @Test
    public void should_not_include_a_duplicate_when_the_collections_includes_the_selectedObject() throws Exception
    {
        collections.add(selectedImprovement);
        tag.setCollections(collections);
        tag.setValueAttribute(VALUE_ATTRIBUTE);
        tag.setLabelAttribute(LABEL_ATTRIBUTE);
        tag.setSelectedObject(selectedImprovement);

        assertThat(pageContext.getBody(), is(blank()));
        final int response = generateTagForPermission(Write);
        assertThat(response, is(EVAL_BODY_INCLUDE));

        final String body = pageContext.getBody();

        StringBuilder expectationBuilder = new StringBuilder();
        expectationBuilder.append("<select name=\""+FIELD_NAME+"\">");
        expectationBuilder.append("<option value=\"").append(bigImprovement.getCommonValueId()).append("\" >");
        expectationBuilder.append(bigImprovement.getValue());
        expectationBuilder.append("</option>");
        expectationBuilder.append("<option value=\"").append(smallImprovement.getCommonValueId()).append("\" >");
        expectationBuilder.append(smallImprovement.getValue());
        expectationBuilder.append("</option>");
        expectationBuilder.append("<option value=\"").append(moderateImprovement.getCommonValueId()).append("\" >");
        expectationBuilder.append(moderateImprovement.getValue());
        expectationBuilder.append("</option>");
        expectationBuilder.append("<option selected=\"\" value=\"").append(selectedImprovement.getCommonValueId()).append("\" >");
        expectationBuilder.append(selectedImprovement.getValue());
        expectationBuilder.append("</option>");
        expectationBuilder.append("</select>");

        assertThat(body, is(expectationBuilder.toString()));
    }

    @Test
    public void should_render_a_span_of_just_the_label_of_the_selected_object_when_permission_is_read_and_selectedObject_is_provided() throws Exception
    {
        tag.setValueAttribute(VALUE_ATTRIBUTE);
        tag.setLabelAttribute(LABEL_ATTRIBUTE);
        tag.setSelectedObject(selectedImprovement);

        assertThat(pageContext.getBody(), is(blank()));
        final int response = generateTagForPermission(Read);
        assertThat(response, is(SKIP_BODY));

        final String body = pageContext.getBody();
        assertThat(body, is("<span class=\"formValue\">" + selectedImprovement.getValue() + "</span>"));
    }

    @Test
    public void should_render_nothing_if_permission_is_read_and_selectedObject_is_null() throws Exception
    {
        tag.setSelectedObject(null);

        assertThat(pageContext.getBody(), is(blank()));
        final int response = generateTagForPermission(Read);
        assertThat(response, is(SKIP_BODY));

        final String body = pageContext.getBody();
        assertThat(body, is(blank()));
    }

    @Test
    public void should_render_nothing_when_permission_is_none() throws Exception
    {
        tag.setCollections(collections);
        tag.setValueAttribute(VALUE_ATTRIBUTE);
        tag.setLabelAttribute(LABEL_ATTRIBUTE);
        tag.setSelectedObject(selectedImprovement);

        assertThat(pageContext.getBody(), is(blank()));
        final int response = generateTagForPermission(None);
        assertThat(response, is(SKIP_BODY));

        final String body = pageContext.getBody();
        assertThat(body, is(blank()));
    }

    private int generateTagForPermission(final NCFieldPermission fieldPermission) throws Exception
    {
        expect(tagHelperMock.getFieldPermission(FIELD_NAME)).andReturn(fieldPermission).once();
        strictControl.replay();
        final int response = tag.doStartTag();
        tag.doEndTag();
        strictControl.verify();
        return response;
    }

}
