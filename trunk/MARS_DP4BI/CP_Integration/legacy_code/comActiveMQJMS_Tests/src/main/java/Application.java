import javax.jms.*;
import com.google.gson.internal.LinkedTreeMap;
import com.solacesystems.jms.SolConnectionFactory;
import com.solacesystems.jms.SolJmsUtility;
import org.apache.commons.lang3.ObjectUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import com.google.gson.Gson;
import org.apache.logging.log4j.message.ObjectArrayMessage;
import org.apache.commons.lang3.StringUtils;
import org.hibernate.HibernateException;
import org.hibernate.Transaction;
import java.util.*;

public class Application implements MessageListener {

    static final Logger logger = LogManager.getLogger("RollingFileLogger");
    static final Logger errorLogger = LogManager.getLogger("DetailedLogger");
    private final Object lock = new Object();
    Gson gson = new Gson();
    String splitString[] = new String[2];
    Map<String,Object> prevMap = new HashMap<String,Object>();
    private TopicSubscriber subscriber;
    private Session session;
    private String keys;
    private org.hibernate.SessionFactory hibernateSessionFactory;



    public Application(){
        try{

            SolConnectionFactory cf = SolJmsUtility.createConnectionFactory();

            cf.setHost("smf://solace-enterprise-shared-0.apps.non-prod.pcf-maximus.com:7001");
            cf.setVPN("v003");
            cf.setUsername("dpbi.user001");
            cf.setPassword("getyourownclient!");
            Connection connection = cf.createConnection();
            connection.setClientID("client:1");
            this.session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);
            Topic topic = session.createTopic("mars-events-topic-dpbi");
            this.subscriber = session.createDurableSubscriber(topic, topic.getTopicName());
            System.out.println("topic.getTopicName() is " + topic.getTopicName().toString());
            this.subscriber.setMessageListener(this);
            System.out.println("Subscriber is " + subscriber.toString());
            connection.start();
            System.out.println("getClientID() is " + connection.getClientID());
            System.out.println("Waiting for messages...");
            System.out.println("My Thread in constructor is " + Thread.currentThread().toString());
             hibernateSessionFactory = HibernateUtil.createSessionFactory();

            synchronized (lock) {

                    lock.wait();

            }
            System.out.println("Ended");

        } catch(Exception up){
            up.printStackTrace();
        }
    }

    public void onMessage(Message message) {

        org.hibernate.Session hibernateSession = hibernateSessionFactory.openSession();
        System.out.println("message.toString() is " + message.toString());

        Transaction tx = null;

        try {

            if(message.getJMSRedelivered() == true){
                System.out.println("Message redelivered");

            }
            else{
                System.out.println("Message first time delivery");
            }

            TextMessage msg = (TextMessage) message;

            Map<String,Object> msgMap = new HashMap<String,Object>();
            Map<String,Object> addressMap = new HashMap<String,Object>();

            String jsonMessageinitial = msg.getText();
            String eventNameType = msg.getStringProperty("EventName");
            msgMap = gson.fromJson(jsonMessageinitial, msgMap.getClass());

            this.splitString = parseEventNameType(eventNameType);
            msgMap.put("eventType", this.splitString[1]);
            msgMap.put("eventName", this.splitString[0]);
            //addressMap = gson.fromJson(ObjectUtils.defaultIfNull(msgMap.getOrDefault("address",""),"null").toString(), addressMap.getClass());
            //addressMap = gson.fromJson(jsonMessageinitial , addressMap.getClass());
            System.out.println("Printing Message");
            System.out.println("Text is " + jsonMessageinitial);
            //System.out.println("LinkedTreeMap addressZip is " + ((LinkedTreeMap)msgMap.get("address")).get("addressZip"));
            //System.out.println("addressId  is " + ((LinkedTreeMap)msgMap.get("address")).get("addressId"));
            //System.out.println(" addressMap is " + addressMap);
            //System.out.println("eventType is " + msgMap.getOrDefault("eventType", "null").toString());
            //System.out.println("eventName is " + msgMap.getOrDefault("eventName", "null").toString());
            //msg.getJMSTimestamp()
            keys = "";
            for ( String key : msgMap.keySet() ) {
                keys += (key + ",");
            }
            msgMap.put("keys", keys);

            if (prevMap.equals(msgMap)){
                //System.out.println("previous map is same current");
                HashMap<String, Object> propertyMap = getMessageProperties(message);

                errorLogger.info("Duplicate:"  +  "msg text is " + msg.getText() + ", Property Map is " + propertyMap + ", msg.getJMSTimestamp() is " + msg.getJMSTimestamp() + ", msg.getJMSType() is " + msg.getJMSType() + ", msg.getJMSCorrelationID() is " + msg.getJMSCorrelationID() + ", msg.toString()) is " + msg.toString());
                //List<String> ll = Collections.list(msg.getPropertyNames());
                //System.out.println("Property elements: "+ ll);
            }
            else{
                //System.out.println("previous map is not the same as current");
                HashMap<String, Object> propertyMap = getMessageProperties(message);
                System.out.println("Property Map is " + propertyMap);
                System.out.println("Outputting" + new ObjectArrayMessage(ObjectUtils.defaultIfNull(msgMap.getOrDefault("eventType",""),"null").toString()));
                logger.info(new ObjectArrayMessage(ObjectUtils.defaultIfNull(msgMap.getOrDefault("eventType",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("eventName",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("genericFieldNumber3",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("preferredLanguageCode",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("genericFieldNumber2",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("callDuration",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("genericFieldNumber1",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("contactChannelType",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("consumerLastName",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("linkRefId",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("consumerPhone",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("contactType",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("createdOn",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("genericFieldNumber4",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("inboundCallQueue",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("contactRecordId",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("contactRecordEndTime",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("uiid",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("correlationId",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("contactRecordStartTime",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("programTypes",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("genericFieldDate3",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("genericFieldDate4",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("contactCompaignType",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("genericFieldText4",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("genericFieldDate1",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("updatedBy",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("genericFieldDate2",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("genericFieldText2",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("contactRecordActions",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("organizationName",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("genericFieldText3",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("genericFieldText1",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("contactRecordStatusType",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("updatedOn",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("linkRefType",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("consumerFirstName",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("contactOutcome",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("consumerType",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("wrapUpTime",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("createdBy",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("contactRecordType",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("consumerAuthenticatedInd",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("contactReasonEditType",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("consumerEmail",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("mergedConsumerId",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("consumerDateOfBirth",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("dateOfDeathNotifiedBy",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("notBornInd",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("ssnValidationCode",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("dateOfDeath",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("usResidentStatusCode",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("ethinicityCode",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("aiNa",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("caseId",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("consumerIdentificationNo",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("consumerSuffix",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("dateOfDeathNotifiedDate",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("consumerStatus",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("consumerMiddleName",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("optIn",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("consumerSSN",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("mergeReason",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("communicationPreferences",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("ssnValidationAgency",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("genderCode",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("dateOfSsnValidation",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("contacts",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("raceCode",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("uuiid",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("address",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("keys",""),"null").toString()));
                MARSEventsPersistance mEPObj = new MARSEventsPersistance(ObjectUtils.defaultIfNull(msgMap.getOrDefault("eventType",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("eventName",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("genericFieldNumber3",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("preferredLanguageCode",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("genericFieldNumber2",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("callDuration",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("genericFieldNumber1",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("contactChannelType",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("consumerLastName",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("linkRefId",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("consumerPhone",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("contactType",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("createdOn",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("genericFieldNumber4",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("inboundCallQueue",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("contactRecordId",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("contactRecordEndTime",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("uiid",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("correlationId",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("contactRecordStartTime",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("programTypes",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("genericFieldDate3",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("genericFieldDate4",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("contactCompaignType",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("genericFieldText4",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("genericFieldDate1",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("updatedBy",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("genericFieldDate2",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("genericFieldText2",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("contactRecordActions",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("organizationName",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("genericFieldText3",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("genericFieldText1",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("contactRecordStatusType",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("updatedOn",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("linkRefType",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("consumerFirstName",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("contactOutcome",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("consumerType",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("wrapUpTime",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("createdBy",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("contactRecordType",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("consumerAuthenticatedInd",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("contactReasonEditType",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("consumerEmail",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("mergedConsumerId",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("consumerDateOfBirth",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("dateOfDeathNotifiedBy",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("notBornInd",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("ssnValidationCode",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("dateOfDeath",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("usResidentStatusCode",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("ethinicityCode",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("aiNa",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("caseId",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("consumerIdentificationNo",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("consumerSuffix",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("dateOfDeathNotifiedDate",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("consumerStatus",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("consumerMiddleName",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("optIn",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("consumerSSN",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("mergeReason",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("communicationPreferences",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("ssnValidationAgency",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("genderCode",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("dateOfSsnValidation",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("contacts",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("raceCode",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("uuiid",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("address",""),"null").toString(),ObjectUtils.defaultIfNull(msgMap.getOrDefault("keys",""),"null").toString());
                tx = hibernateSession.beginTransaction();
                hibernateSession.persist(mEPObj);
                hibernateSession.save(mEPObj);
                tx.commit();
                errorLogger.info("Not Duplicate:"  +  "msg text is " + msg.getText() +  ", Property Map is " + propertyMap + ", msg.getJMSTimestamp() is " + msg.getJMSTimestamp() + ", msg.getJMSType() is " + msg.getJMSType() + ", msg.getJMSCorrelationID() is " + msg.getJMSCorrelationID() + ", msg.toString()) is " + msg.toString());
                //List<String> ll = Collections.list(msg.getPropertyNames());
                //System.out.println("Property elements: "+ ll);
            }
            //System.out.println("prevMap keyset is " + prevMap.keySet().toString());
            //System.out.println("msgMap keyset is " + msgMap.keySet().toString());
            prevMap = msgMap;
            hibernateSession.close();


            //message.acknowledge();
            //subscriber.close();
            //session.unsubscribe("mars-events-topic-dpbi");


        }

        catch (HibernateException e){

            if(tx!=null){

                tx.rollback();
                System.out.println(e);

            }

        }
        catch (Exception up) {
            up.printStackTrace();
        }
        finally {
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

    private static HashMap<String, Object> getMessageProperties(Message msg) throws JMSException
    {
        HashMap<String, Object> properties = new HashMap<String, Object> ();
        Enumeration srcProperties = msg.getPropertyNames();
        while (srcProperties.hasMoreElements()) {
            String propertyName = (String)srcProperties.nextElement ();
            properties.put(propertyName, msg.getObjectProperty (propertyName));
        }
        return properties;
    }

    public static void main(String[] args) {
        new Thread() {
            public void run() {
                new Application();
            }}.start();
        System.out.println("Ended in Main");
    }

}
