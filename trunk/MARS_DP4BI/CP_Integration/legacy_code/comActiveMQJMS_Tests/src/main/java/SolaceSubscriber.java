
import com.solacesystems.jcsmp.BytesXMLMessage;
import com.solacesystems.jcsmp.JCSMPException;
import com.solacesystems.jcsmp.JCSMPFactory;
import com.solacesystems.jcsmp.JCSMPProperties;
import com.solacesystems.jcsmp.JCSMPSession;
import com.solacesystems.jcsmp.TextMessage;
import com.solacesystems.jcsmp.Topic;
import com.solacesystems.jcsmp.XMLMessageConsumer;
import com.solacesystems.jcsmp.XMLMessageListener;
import java.util.concurrent.CountDownLatch;
public class SolaceSubscriber {


    public static void main(String[] args) throws JCSMPException {

            final Object lock = new Object();

        System.out.println("TopicSubscriber initializing...");
            final JCSMPProperties properties = new JCSMPProperties();
            properties.setProperty(JCSMPProperties.HOST, "solace-enterprise-shared-0.apps.non-prod.pcf-maximus.com:7001");// host:port
            properties.setProperty(JCSMPProperties.USERNAME, "dpbi.user001"); // client-username
            properties.setProperty(JCSMPProperties.VPN_NAME, "v003"); // message-vpn
            properties.setProperty(JCSMPProperties.PASSWORD, "dpbi.user001"); // client-password
            final Topic topic = JCSMPFactory.onlyInstance().createTopic("mars-events-topic-dpbi");
            final JCSMPSession session = JCSMPFactory.onlyInstance().createSession(properties);
            final CountDownLatch latch = new CountDownLatch(1);

            session.connect();
            while (true) {
                System.out.println("Starting New...");
                // used for
                // synchronizing b/w threads
                /** Anonymous inner-class for MessageListener
                 *  This demonstrates the async threaded message callback */
                final XMLMessageConsumer cons = session.getMessageConsumer(new XMLMessageListener() {

                    public void onReceive(BytesXMLMessage msg) {
                        if (msg instanceof TextMessage) {
                            System.out.printf("TextMessage received: '%s'%n",
                                    ((TextMessage) msg).getText());
                        } else {
                            System.out.println("Message received.");
                        }
                        try {
                            System.out.printf("Message properties EventName value is %s%n", msg.getProperties().getString("EventName"));
                            System.out.println();
                        }
                        catch (Exception e){
                            System.out.println("No such key");
                        }
                        System.out.printf("Contains keys or not  %s%n", msg.getProperties().containsKey("EventName"));
                        System.out.println();
                        System.out.printf("Message properties key set is %s%n", msg.getProperties().keySet());
                        System.out.printf("Message properties size is %s%n", msg.getProperties().size());
                        System.out.println();
                        System.out.printf("Message Dump:%n%s%n", msg.dump());
                       // latch.countDown();  // unblock main thread
                    }


                    public void onException(JCSMPException e) {
                        System.out.printf("Consumer received exception: %s%n", e);
                        //latch.countDown();  // unblock main thread
                    }
                });
                session.addSubscription(topic);
                System.out.println("Connected. Awaiting message...");
                cons.start();
                // Consume-only session is now hooked up and running!

                try {
                    synchronized (lock) {

                    lock.wait();

                }
                } catch (InterruptedException e) {
                    System.out.println("I was awoken while waiting");
                }

            }
        }
}
