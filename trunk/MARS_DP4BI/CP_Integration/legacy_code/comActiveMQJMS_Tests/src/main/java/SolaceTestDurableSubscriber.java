import javax.jms.*;
import com.solacesystems.jms.SolConnectionFactory;
import com.solacesystems.jms.SolJmsUtility;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class SolaceTestDurableSubscriber implements MessageListener{

        static final Logger logger = LogManager.getLogger("XML_ROLLING_FILE_APPENDER");
        private final Object lock = new Object();

        public SolaceTestDurableSubscriber(){
            try{

                SolConnectionFactory cf = SolJmsUtility.createConnectionFactory();
                cf.setHost("smf://solace-enterprise-shared-0.apps.non-prod.pcf-maximus.com:7001");
                cf.setVPN("v003");
                cf.setUsername("dpbi.user001");
                cf.setPassword("dpbi.user001");
                Connection connection = cf.createConnection();
                //connection.setClientID("client:1");
                Session session = connection.createSession(false, Session.CLIENT_ACKNOWLEDGE);
                Topic topic = session.createTopic("mars-events-topic-dpbi");
                TopicSubscriber subscriber = session.createDurableSubscriber(topic, topic.getTopicName());
                subscriber.setMessageListener(this);
                connection.start();
                System.out.println("Waiting for messages...");
                System.out.println("My Thread in constructor is " + Thread.currentThread().toString());

                synchronized (lock) {

                    lock.wait();

                }
                System.out.println("Ended");

            } catch(Exception up){
                up.printStackTrace();
            }
        }

        public void onMessage(Message message) {


            try {

                TextMessage msg = (TextMessage) message;
                System.out.println("Printing Message");
                System.out.println("Text is " + msg.getText());
                System.out.println("After Printing Message");
                System.out.println("I am " + this.toString());
                System.out.println("My Thread is " + Thread.currentThread().toString());
                //logger.info(msg.getText());
                //System.out.println("Latch count is " + latch.getCount());
                //message.acknowledge();
                //String queriedMsg = msg.getBody(String.class);
                //System.out.println("Body is " + queriedMsg);
                //latch.countDown();

            }

            catch (Exception up) {
                up.printStackTrace();
            }
            finally {
            }
        }

        public static void main(String[] args) {
            new Thread() {
                public void run() {
                    new SolaceTestDurableSubscriber();
                }}.start();
            System.out.println("Ended in Main");
        }

    }



