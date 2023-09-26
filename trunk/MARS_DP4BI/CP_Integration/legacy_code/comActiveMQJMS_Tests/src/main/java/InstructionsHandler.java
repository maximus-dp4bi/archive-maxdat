import com.google.gson.Gson;
import org.apache.commons.lang3.StringUtils;
import org.hibernate.Transaction;
import pojomappings.MarsContactRecordEvents;

import javax.jms.TextMessage;
import javax.xml.soap.Text;

public class InstructionsHandler {

    private String eventNameType;
    private String eventNameTypeArr[];
    private String eventName;
    private String eventType;
    private Object pojo;
    private String jsonMessageinitial;
    private Gson gson;

    public InstructionsHandler(){

        gson = new Gson();

    }

    public void log(TextMessage message){

        try {
            jsonMessageinitial = message.getText();
            eventNameType = message.getStringProperty("EventName");
            eventNameTypeArr = parseEventNameType(eventNameType);
            eventName = eventNameTypeArr[0];
            eventType = eventNameTypeArr[1];
            pojo = getPojo(message, eventName);
            logToOracle(pojo, eventName, eventType);
        }
        catch (javax.jms.JMSException jmsE){

            System.out.println("Error in InstructionsHandler logToOracle");
            jmsE.printStackTrace();
        }

    }

    private Object getPojo(TextMessage message, String eventName){


        switch(eventName){
            case "PROJECT":
               Object pojo = gson.fromJson(jsonMessageinitial, MarsContactRecordEvents.class);
               return pojo;

        }

        return null;
    }

    private void logToOracle(Object messageObj, String eventName, String eventType){

        org.hibernate.Session hibernateSession = HibernateUtil.createSessionFactory().openSession();
        Transaction tx = null;

        switch(eventName){
            case "PROJECT":
                if (eventType == "SAVE"){
                    break;
                }
                else if (eventType == "UPDATE"){
                    break;
                }
        }
    }

    public String[] parseEventNameType(String eventNameType){

        String nameTypeStr = StringUtils.substring(eventNameType, 0, eventNameType.length()-6);
        System.out.println("nameTypeStr is " + nameTypeStr);
        String splitStr[] = new String[2];
        int lastUnderScore = nameTypeStr.lastIndexOf("_");
        String eventName = nameTypeStr.substring(0, lastUnderScore);
        //System.out.println("Event Name is " + eventName);
        String eventType = nameTypeStr.substring(lastUnderScore+1);
        //System.out.println("Event Type is " + eventType);
        splitStr[0] = eventName;
        splitStr[1] = eventType;

        return splitStr;
    }
}
