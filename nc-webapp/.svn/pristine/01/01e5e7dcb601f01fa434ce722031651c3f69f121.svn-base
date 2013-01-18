package au.com.toyota.nc.webapp.decorator;

import java.beans.IntrospectionException;
import java.beans.Introspector;
import java.beans.MethodDescriptor;
import java.io.Serializable;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import au.com.toyota.nc.common.utils.NCDateFormatter;
import au.com.toyota.nc.common.utils.annotations.DisplayName;
import au.com.toyota.nc.common.utils.annotations.Skipable;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;

/**
 * Created by IntelliJ IDEA.
 * User: Deepthi Fernando
 * Date: 10/03/2009
 * Time: 12:13:06 PM
 * To change this template use File | Settings | File Templates.
 */
@Repository("requestDecorator")
public class RequestDecoratorHelper implements Serializable {
    private static final Logger LOGGER = Logger.getLogger(RequestDecoratorHelper.class.getName());

    /**
     * base on the search parameters selected by the user, something similer to following will generate to display on the result screen
     * Your seach for name 'F' for ownertype 'company' and acn '777-' returned the following results
     * @return
     */
    public static String getRequestParameterDecoratorString(Object o){
        StringBuffer stringBuffer = new StringBuffer();
        ArrayList<SearchParameter> searchParameters = new ArrayList<SearchParameter>();

        Class objClazz = o.getClass();

        try{
            MethodDescriptor[] descriptors = Introspector.getBeanInfo(objClazz).getMethodDescriptors();
            descriptors = sortByName(descriptors);
            stringBuffer.append("Your Search ");
            // Get all methods of the clazz, and iterate through each method
            for (MethodDescriptor descriptor : descriptors) {
//                descriptor.
                String method = descriptor.getName();
                if (isSkipAble(method)) continue;
                method = removeGetOrIs(method);

                Method caMethod = descriptor.getMethod();
                if (caMethod.isAnnotationPresent(Skipable.class)) continue;
                if (caMethod.isAnnotationPresent(DisplayName.class)) method = caMethod.getAnnotation(DisplayName.class).name();

                if (caMethod.getParameterTypes().length !=0 ) continue;

                caMethod.getReturnType();

                if (getString(caMethod.invoke(o))!=null)
                    searchParameters.add(new SearchParameter(method, getString(caMethod.invoke(o))));
            }

            stringBuffer.append(addForClauses(searchParameters));
            stringBuffer.append(" returned the following results");

        }catch (InvocationTargetException ite){
            throw new RuntimeException(ite.getMessage());
        }catch (IllegalAccessException iae){
            throw new RuntimeException(iae.getMessage());
        }catch (IntrospectionException ie){
            throw new RuntimeException(ie.getMessage());
        }

        return stringBuffer.toString();

    }

    private static MethodDescriptor[] sortByName(MethodDescriptor[] descriptors)
    {
        final List<MethodDescriptor> methodDescriptorList = Arrays.asList(descriptors);
        Collections.sort(methodDescriptorList, new Comparator<MethodDescriptor>()
        {
            public int compare(MethodDescriptor o1, MethodDescriptor o2)
            {
                return o1.getName().compareTo(o2.getName());
            }
        });
        return methodDescriptorList.toArray(new MethodDescriptor[methodDescriptorList.size()]);
    }

    public static String removeGetOrIs(String name) {
        if (name.startsWith("get"))
            return name.substring(3, 4).toUpperCase() + name.substring(4).toLowerCase();
        else
            return name.substring(2, 3).toUpperCase() + name.substring(3).toLowerCase();
    }


    /*
     *
     * @param searchParameters
     * @return
     */
    private static String addForClauses(ArrayList< SearchParameter> searchParameters) {
        StringBuffer sb = new StringBuffer();

        Iterator it_search = searchParameters.iterator();
        while (it_search.hasNext()){
            SearchParameter searchParameter = (SearchParameter)it_search.next();

            if (it_search.hasNext() || searchParameters.size()==1)
                sb.append(" for ");
            else
                sb.append(" and ");

            sb.append(searchParameter.getName());
            sb.append(" ");
            sb.append(searchParameter.getValue());
        }

        return sb.toString();
    }

    /*
        Test for known types

     */
    private static String getString(Object o){
        NCDateFormatter formatter = new NCDateFormatter();
        if (o == null) return null;
        if (o.getClass().isPrimitive()) return o.toString();
        if (o instanceof String) return o.toString();
        if (o instanceof Integer) return o.toString();
        if (o instanceof Long) return o.toString();
        if (o instanceof Date) return formatter.format((Date)o);
        if (o instanceof StringBuffer) return o.toString();
        if (o instanceof Float) return o.toString();
        if (o instanceof Boolean) return o.toString();
        if (o instanceof Enum) return o.toString();

        return null;
    }

    /*
        select only user define methods, (not language define methods). its assumed only getters and isMethods
        are use by the developer to access the properties
     */
    private static boolean isSkipAble(String methodName){
        if (methodName.startsWith("get") || methodName.startsWith("is")) {
            if (methodName.equals("getRequestParameters") || methodName.equals("getClass"))
                return true;
            else
                return false;
        }else{
            return true;
        }
    }

    /*
    value object to hold search parameter and its value where value is not null.
        */
    static class SearchParameter{
        private String name;
        private String value;

        SearchParameter(String name, String value) {
            this.name = name;
            this.value = value;
        }

        public String getName() {
            return name;
/*
            if (name.startsWith("get"))
                return name.substring(3, 4).toUpperCase() + name.substring(4).toLowerCase();
            else
                return name.substring(2, 3).toUpperCase() + name.substring(3).toLowerCase();
*/
        }

        public void setName(String name) {
            this.name = name;
        }

        public String getValue() {
            return "'" + value + "'";
        }

        public void setValue(String value) {
            this.value = value;
        }
    }
}
