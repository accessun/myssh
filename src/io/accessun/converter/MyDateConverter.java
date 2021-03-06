package io.accessun.converter;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import org.apache.struts2.util.StrutsTypeConverter;

public class MyDateConverter extends StrutsTypeConverter {
    
    private DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

    @SuppressWarnings("rawtypes")
    @Override
    public Object convertFromString(Map context, String[] values, Class toClass) {
        if (toClass == Date.class) {
            try {
                return dateFormat.parse(values[0]);
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public String convertToString(Map context, Object o) {
        if (o instanceof Date) {
            return dateFormat.format((Date) o);
        }
        return null;
    }

}
