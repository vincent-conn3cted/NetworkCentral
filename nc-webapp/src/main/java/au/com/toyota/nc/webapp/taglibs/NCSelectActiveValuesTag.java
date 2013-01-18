package au.com.toyota.nc.webapp.taglibs;

import au.com.toyota.nc.common.security.NCFieldPermission;
import au.com.toyota.nc.common.security.NCFieldSecurityMapper;
import com.toyota.ibus.common.util.Str;
import net.sourceforge.stripes.integration.spring.SpringBean;
import net.sourceforge.stripes.integration.spring.SpringHelper;
import net.sourceforge.stripes.tag.HtmlTagSupport;
import org.apache.commons.lang.StringUtils;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

public class NCSelectActiveValuesTag extends HtmlTagSupport
{
    public static final String DEFAULT_READONLY_CLASS = "formValue";

    @SpringBean
    private NCFieldSecurityMapper securityMapper;

    private NCTagHelper helper;

    private Object selectedObject;

    private String valueAttribute;

    private String labelAttribute;

    private List collections;

    private String readOnlyClass;

    private String name;

    private boolean bodyIncluded;

    public void setPageContext(PageContext pageContext)
    {
        super.setPageContext(pageContext);
        SpringHelper.injectBeans(this, getPageContext().getServletContext());
        this.helper = new NCTagHelper(securityMapper, getPageContext());
    }

    public NCSelectActiveValuesTag()
    {
    }

    //for tests
    NCSelectActiveValuesTag(PageContext pageContext)
    {
        super.setPageContext(pageContext);
    }

    public int doStartTag() throws JspException
    {
        final int returnValue;
        try
        {
            NCFieldPermission ncFieldPermission = helper.getFieldPermission(getName());
            bodyIncluded = false;
            switch (ncFieldPermission)
            {
                case Write:
                    bodyIncluded = true;
                    writeOpenSelectTag();
                    returnValue = EVAL_BODY_INCLUDE;
                    break;
                case Read:
                    writeAsSpanLabel(getPageContext().getOut());
                    returnValue = SKIP_BODY;
                    break;
                case None:
                    returnValue = SKIP_BODY;
                    break;
                default:
                    throw new IllegalArgumentException("Invalid field permission " + ncFieldPermission);
            }
        }
        catch (Exception e)
        {
            throw new RuntimeException(e);
        }
        return returnValue;
    }

    private void writeOpenSelectTag()
            throws JspException
    {
        set("name", getName());
        writeOpenTag(getPageContext().getOut(), "select");
    }

    private void writeAsSpanLabel(JspWriter out) throws Exception
    {
        set("class", !Str.isEmpty(readOnlyClass) ? readOnlyClass : DEFAULT_READONLY_CLASS);
        final Object selectedObject = getSelectedObject();
        if(selectedObject != null)
        {
            writeOpenTag(out, "span");
            out.append(evaluateLabel(selectedObject));
            writeCloseTag(out, "span");
        }
    }

    private void doSelectTag(final JspWriter out) throws Exception
    {
        for (Object collectionItem : getCombinedCollection())
        {
            String value = evaluateValue(collectionItem);
            String label = evaluateLabel(collectionItem);
            out.append("<option ");
            if (isCurrentValueSelected(collectionItem))
            {
                out.append("selected=\"\" ");
            }
            out.append("value=\"");
            out.append(value);
            out.append("\" ");
            out.append(">");
            out.append(label);
            out.append("</option>");
        }
        writeCloseTag(out, "select");
    }

    private String evaluateLabel(Object collectionItem) throws Exception
    {
        final Method labelAttributeMethod = createGetterMethod(collectionItem.getClass(), labelAttribute);
        return evaluate(collectionItem, labelAttributeMethod);
    }

    private String evaluateValue(Object collectionItem) throws Exception
    {
        final Method valueAttributeMethod = createGetterMethod(collectionItem.getClass(), valueAttribute);
        return evaluate(collectionItem, valueAttributeMethod);
    }

    private boolean isCurrentValueSelected(Object collectionItem) throws Exception {
        String itemValue = evaluateValue(collectionItem);
        return getSelectedObject() != null && itemValue.equals(evaluateValue(getSelectedObject()));
    }

    private String evaluate(Object object, Method method) throws Exception {
        Object objectValue = method.invoke(object);
        return objectValue!=null?objectValue.toString():"";
    }

    private Method createGetterMethod(Class clazz, String expression) throws NoSuchMethodException
    {
        final String methodName = "get" + StringUtils.capitalize(expression);
        return clazz.getMethod(methodName);
    }

    public int doEndTag() throws JspException
    {
            try
            {
                if(bodyIncluded)
                {
                    doSelectTag(getPageContext().getOut());
                }
            }
            catch (Exception e)
            {
                e.printStackTrace();
            }
        return EVAL_PAGE;
    }

    public void release()
    {
        super.release();
        collections = null;
        selectedObject = null;
        valueAttribute = null;
        labelAttribute = null;
        securityMapper = null;
        helper = null;
    }

    private List getCombinedCollection()
    {
       /* final List combinedCollection = new ArrayList(getCollections());
        if (getSelectedObject() != null && !combinedCollection.contains(getSelectedObject()))
        {
            combinedCollection.add(getSelectedObject());
        }
        return combinedCollection;*/
        final List combinedCollection = new ArrayList(getCollections());
        if (getSelectedObject() != null && !collectionHasItem(combinedCollection, getSelectedObject()))
        {
            combinedCollection.add(getSelectedObject());
        }
        return combinedCollection;
    }


    private boolean collectionHasItem(Collection col, Object item) {
        try {
            for (Object collectionItem : col) {
                String collectionItemValue = evaluateValue(collectionItem);
                String itemValue = evaluateValue(item);
                if (itemValue.equals(collectionItemValue)) {
                    return true;
                }
            }
        } catch (Exception e) {
            return false;
        }
        return false;
    }

    public Object getSelectedObject()
    {
        return selectedObject;
    }

    public void setSelectedObject(Object selectedObject)
    {
        this.selectedObject = selectedObject;
    }

    public String getValueAttribute()
    {
        return valueAttribute;
    }

    public void setValueAttribute(String valueAttribute)
    {
        this.valueAttribute = valueAttribute;
    }

    public String getLabelAttribute()
    {
        return labelAttribute;
    }

    public void setLabelAttribute(String labelAttribute)
    {
        this.labelAttribute = labelAttribute;
    }

    public List getCollections()
    {
        if (collections == null)
        {
            collections = new ArrayList();
        }
        return collections;
    }

    public void setCollections(List collections)
    {
        this.collections = collections;
    }

    public String getReadOnlyClass()
    {
        return readOnlyClass;
    }

    public void setReadOnlyClass(String readOnlyClass)
    {
        this.readOnlyClass = readOnlyClass;
    }

    public String getName()
    {
        return name;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    public void setHelper(NCTagHelper helper)
    {
        this.helper = helper;
    }
}
