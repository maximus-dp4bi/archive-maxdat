
import java.util.concurrent.CountDownLatch;

import com.solacesystems.jcsmp.*;

public class DurableTopicSubscriber {
    public static void main(String[] args) throws JCSMPException {


        System.out.println("TopicSubscriber initializing...");
        final JCSMPProperties properties = new JCSMPProperties();
        properties.setProperty(JCSMPProperties.HOST, "solace-enterprise-shared-0.apps.non-prod.pcf-maximus.com:7001");// host:port
        properties.setProperty(JCSMPProperties.USERNAME, "dpbi.user001"); // client-username
        properties.setProperty(JCSMPProperties.VPN_NAME,  "v003"); // message-vpn
        properties.setProperty(JCSMPProperties.PASSWORD, "dpbi.user001"); // client-password


        final Topic topic = JCSMPFactory.onlyInstance().createTopic("mars-events-topic-dpbi");
        final JCSMPSession session = JCSMPFactory.onlyInstance().createSession(properties);
        /**/

        session.connect();

        final CountDownLatch latch = new CountDownLatch(1); // used for
        // synchronizing b/w threads
        /** Anonymous inner-class for MessageListener
         *  This demonstrates the async threaded message callback */
        final XMLMessageConsumer cons = session.getMessageConsumer(new XMLMessageListener() {

            public void onReceive(BytesXMLMessage msg) {
                if (msg instanceof TextMessage) {
                    System.out.printf("TextMessage received: '%s'%n",
                            ((TextMessage)msg).getText());
                } else {
                    System.out.println("Message received.");
                }
                System.out.printf("Message Dump:%n%s%n",msg.dump());
                latch.countDown();  // unblock main thread
            }


            public void onException(JCSMPException e) {
                System.out.printf("Consumer received exception: %s%n",e);
                latch.countDown();  // unblock main thread
            }
        });
        session.addSubscription(topic);
        System.out.println("Connected. Awaiting message...");
        cons.start();
        // Consume-only session is now hooked up and running!

        try {
            latch.await(); // block here until message received, and latch will flip
        } catch (InterruptedException e) {
            System.out.println("I was awoken while waiting");
        }
        // Close consumer
        cons.close();
        System.out.println("Exiting.");
        session.closeSession();
    }
}
