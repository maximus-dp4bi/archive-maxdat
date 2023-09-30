import com.solacesystems.jcsmp.*;

    /**
     * Publishes a messages to a topic using Solace JMS 1.1 API implementation.
     *
     * This is the Publisher in the Publish/Subscribe messaging pattern.
     */
    public class TopicPublisher {

        private class SimplePublisherEventHandler implements JCSMPStreamingPublishEventHandler {
            public void responseReceived(String messageID) {
                System.out.println("Producer received response for msg: " + messageID);
            }

            public void handleError(String messageID, JCSMPException e, long timestamp) {
                System.out.println("Producer received error for msg: " + messageID + " - " + timestamp);
            }

        }


        public void run() throws Exception {

            final JCSMPProperties properties = new JCSMPProperties();
            properties.setProperty(JCSMPProperties.HOST, "solace-enterprise-shared-0.apps.non-prod.pcf-maximus.com:7001");// host:port
            properties.setProperty(JCSMPProperties.USERNAME, "dpbi.user001"); // client-username
            properties.setProperty(JCSMPProperties.VPN_NAME,  "v003"); // message-vpn
            properties.setProperty(JCSMPProperties.PASSWORD, "dpbi.user001"); // client-password

            System.out.printf("TopicPublisher is connecting to Solace messaging server");

            // Create a non-transacted, auto ACK session.
            JCSMPSession session = JCSMPFactory.onlyInstance().createSession(properties);



            // Create the publishing topic programmatically
            final Topic topic = JCSMPFactory.onlyInstance().createTopic("mars-events-topic-dpbi");

            // Create the message producer for the created topic
            XMLMessageProducer  messageProducer = session.getMessageProducer(new SimplePublisherEventHandler());

            TextMessage message = JCSMPFactory.onlyInstance().createMessage(com.solacesystems.jcsmp.TextMessage.class);
            // Create the message
            message.setText("{\"contactRecordActions\":[{\"contactRecordActionType\":\"Haris\",\"contactRecordActionId\":\"\"}],\"contactRecordId\":14074,\"contactRecordReasonId\":\"\",\"contactRecordReasonType\":\"Complaint - Customer Service\",\"notes\":\"test100\",\"correlationId\":\"221423586370960\",\"createdBy\":234,\"updatedBy\":null,\"updatedOn\":null,\"createdOn\":\"2019-02-19T10:52:32Z\",\"uiid\":\"213593066100\"}");

            System.out.printf("Sending message '%s' to topic '%s'...%n", message.getText(), topic.toString());

            // Send the message
            // NOTE: JMS Message Priority is not supported by the Solace Message Bus
            messageProducer.send(message, topic);
            System.out.println("Sent successfully. Exiting...");


            messageProducer.close();

        }

        public static void main(String[] args) throws Exception {

            new TopicPublisher().run();
        }
    }

