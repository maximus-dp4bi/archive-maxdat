package com.main;

import com.hibernate.HibernateUtil;
import com.solacesystems.jms.SolConnectionFactory;
import com.solacesystems.jms.SolJmsUtility;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.hibernate.HibernateException;
import org.hibernate.Transaction;
import javax.jms.*;


public class Worker implements MessageListener{

    private Session session;
    private TopicSubscriber subscriber;
    private org.hibernate.SessionFactory hibernateSessionFactory;
    private final Object lock = new Object();
    private Transaction tx;
    private PojoBuilder architect;
    private String prevMsg;
    private String jsonMessageinitial;
    private static final Logger detailedLogger = LogManager.getLogger("DetailedLogger");
    private static final Logger exceptionLogger = LogManager.getLogger("ExceptionLogger");

    public Worker(){

        try{
            prevMsg = "";
            jsonMessageinitial = "";
            SolConnectionFactory cf = SolJmsUtility.createConnectionFactory();
            hibernateSessionFactory = HibernateUtil.createSessionFactory();
            cf.setHost("smf://solace-enterprise-shared-0.apps.non-prod.pcf-maximus.com:7001");
            cf.setVPN("v003");
            cf.setUsername("dpbi.user001");
            cf.setPassword("getyourownclient!");
            Connection connection = cf.createConnection();
            connection.setClientID("client:1");
            this.session = connection.createSession(false, Session.CLIENT_ACKNOWLEDGE);
            Topic topic = session.createTopic("mars-events-topic-dpbi");
            this.subscriber = session.createDurableSubscriber(topic, topic.getTopicName());
            System.out.println("topic.getTopicName() is " + topic.getTopicName().toString());
            this.subscriber.setMessageListener(this);
            System.out.println("Subscriber is " + subscriber.toString());
            connection.start();
            System.out.println("getClientID() is " + connection.getClientID());
            System.out.println("Waiting for messages...");
            System.out.println("My Thread in constructor is " + Thread.currentThread().toString());

            System.out.println("hibernateSessionFactory created");
            synchronized (lock) {

                lock.wait();

            }
            System.out.println("Ended");

        } catch(Exception up){
            up.printStackTrace();
        }
    }


    public void onMessage(Message message) {
        TextMessage msg = (TextMessage) message;
        org.hibernate.Session hibernateSession = hibernateSessionFactory.openSession();

            try {
                jsonMessageinitial = msg.getText();
                detailedLogger.info("Message is " + jsonMessageinitial + " EVENT TYPE is " + msg.getStringProperty("EventName"));

                System.out.println("Message is " + jsonMessageinitial);
                System.out.println("Message eventname is " + msg.getStringProperty("EventName"));

                System.out.println("prevMsg is " + prevMsg);
                System.out.println("currMsg is " + jsonMessageinitial);
                if (!jsonMessageinitial.equals(prevMsg)) {

                    tx = null;
                    architect = new PojoBuilder(hibernateSession);
                    architect.setTextMessage(msg);
                    Object pojo = architect.buildPojo();
                    if (msg.getStringProperty("EventName").equals("CONTACT_RECORD_SAVE_EVENT") || msg.getStringProperty("EventName").equals("CONTACT_RECORD_UPDATE_EVENT")) {

                        if (pojo != null) {
                            tx = hibernateSession.beginTransaction();
                            //hibernateSession.reconnect();
                            hibernateSession.persist(pojo);
                            hibernateSession.save(pojo);
                            tx.commit();

                        }
                    }
                    hibernateSession.close();
                }
                // message.acknowledge();
                System.out.println("Message resolved");
                prevMsg = jsonMessageinitial;

            } catch (HibernateException e) {

                if (tx != null) {

                    exceptionLogger.info(e.getMessage());
                    tx.rollback();
                    e.printStackTrace();
                    hibernateSession.close();

                }

            }
            catch(javax.persistence.PersistenceException e){
                exceptionLogger.info(e.getMessage());
                e.printStackTrace();
                hibernateSession.close();
            }
            catch (Exception e) {
                exceptionLogger.info(e.getMessage());
                e.printStackTrace();
            } finally {
                }

    }
}
