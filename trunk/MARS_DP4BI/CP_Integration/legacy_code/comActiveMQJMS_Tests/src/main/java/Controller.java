package com.maximus.samples.solace.clientcert.controller;

import com.maximus.samples.solace.clientcert.model.SimpleMessage;
import com.maximus.samples.solace.clientcert.model.SimpleSubscription;
import com.solacesystems.jcsmp.*;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.PostConstruct;
import java.util.LinkedList;
import java.util.Queue;

@RestController
public class Controller {
    private static final Log logger = LogFactory.getLog(Controller.class);

    private JCSMPSession session;
    private Queue<TextMessage> receivedMessages = new LinkedList<>();
    private XMLMessageProducer producer;

    private class SimplePublisherEventHandler implements JCSMPStreamingPublishEventHandler {
        @Override
        public void responseReceived(String messageID) {
            logger.info("Producer received response for msg: " + messageID);
        }

        @Override
        public void handleError(String messageID, JCSMPException e, long timestamp) {
            logger.error("Producer received error for msg: " + messageID + " - " + timestamp, e);
        }

    }

    private class SimpleMessageListener implements XMLMessageListener {

        @Override
        public void onReceive(BytesXMLMessage receivedMessage) {

            if (receivedMessage instanceof TextMessage) {
                TextMessage tm = (TextMessage) receivedMessage;
                receivedMessages.add(tm);
                logger.info("Received message : " + tm.getText());
            } else {
                logger.error("Received message that was not a TextMessage: " + receivedMessage.dump());
            }
        }

        @Override
        public void onException(JCSMPException e) {
            logger.error("Consumer received exception: %s%n", e);
        }
    }

    @PostConstruct
    public void init() {

        // Connect to Solace
        logger.info("************* Init Called ************");

        String vcapServices = System.getenv("VCAP_SERVICES");
        logger.info(vcapServices);

        // Need to parse the Solace HOST from VCAP Services
        if (vcapServices == null || vcapServices.equals("") || vcapServices.equals("{}")) {
            logger.error("The VCAP_SERVICES variable wasn't set in the environment. Aborting connection.");
            logger.info("************* Aborting Solace initialization!! ************");
            return;
        }

        JSONObject vcapServicesJson = new JSONObject(vcapServices);

        JSONArray solMessagingArray = vcapServicesJson.getJSONArray("solace-pubsub");

        if (solMessagingArray == null) {
            logger.error("Did not find Solace provided messaging service \"solace-pubsub\"");
            logger.info("************* Aborting Solace initialization!! ************");
            return;
        }

        logger.info("Number of provided bindings: " + solMessagingArray.length());

        // Get the first Solace credentials from the array
        JSONObject solaceCredentials = null;
        if (solMessagingArray.length() > 0) {
            solaceCredentials = solMessagingArray.getJSONObject(0);
            if (solaceCredentials != null) {
                solaceCredentials = solaceCredentials.getJSONObject("credentials");
            }
        }

        if (solaceCredentials == null) {
            logger.error("Did not find Solace PubSub+ service credentials");
            logger.info("************* Aborting Solace initialization!! ************");
            return;
        }


        logger.info("Solace client initializing and using Credentials: " + solaceCredentials.toString(2));

        String clientUsername = solaceCredentials.getString("clientUsername");
        logger.info("****NOTICE!!! Using Solace client username: " + clientUsername + ". If your client certificate does not have this username in the CN, then the certificate will not work. You will get an error saying the Client Username is Shutdown!****");

        final JCSMPProperties properties = new JCSMPProperties();

        //Since we are using Maximus signed certificates, make sure we have validation turned on.
        properties.setProperty(JCSMPProperties.SSL_VALIDATE_CERTIFICATE, true);
        properties.setProperty(JCSMPProperties.SSL_VALIDATE_CERTIFICATE_DATE, true);

        //You only need truststore if the MAXIMUS root and intermediate certificates are not in VM's trusted certificate folder (e.g. /etc/ssl/certs)
        //Uncomment this and add the truststore if you know that your VM does not have the MAXIMUS root and intermediate certificates in it.
        properties.setProperty(JCSMPProperties.SSL_TRUST_STORE, "classpath:truststore.jks");
        properties.setProperty(JCSMPProperties.SSL_TRUST_STORE_FORMAT, "JKS");
        properties.setProperty(JCSMPProperties.SSL_TRUST_STORE_PASSWORD, "password");

        properties.setProperty(JCSMPProperties.SSL_KEY_STORE, "classpath:keystore.jks"); //<-- is this your keystore filename?
        properties.setProperty(JCSMPProperties.SSL_KEY_STORE_FORMAT, "JKS");
        properties.setProperty(JCSMPProperties.SSL_KEY_STORE_PASSWORD, "password"); //<-- update the keystore password here
        properties.setProperty(JCSMPProperties.SSL_PRIVATE_KEY_ALIAS, "solace-client-cert"); //<-- change the certificate alias here
        properties.setProperty(JCSMPProperties.SSL_PRIVATE_KEY_PASSWORD, "password"); //<-- update the private key password here

        JSONArray hostsArray = solaceCredentials.getJSONArray("smfTlsHosts");

        // Make a host list (for HA and non HA)
        String host = "";
        for (int i = 0; i < hostsArray.length(); i++) {
            String newHostEntry = hostsArray.getString(i);
            if (i > 0)
                host += ",";

            host += newHostEntry;
        }

        logger.info("Using host " + host);

        properties.setProperty(JCSMPProperties.HOST, host);

        String vpnName = solaceCredentials.getString("msgVpnName");
        logger.info("VPN Name: " + vpnName);

        properties.setProperty(JCSMPProperties.VPN_NAME, vpnName);

        properties.setProperty(JCSMPProperties.AUTHENTICATION_SCHEME, JCSMPProperties.AUTHENTICATION_SCHEME_CLIENT_CERTIFICATE);

        try {
            session = JCSMPFactory.onlyInstance().createSession(properties);
            session.connect();
        } catch (Exception e) {
            logger.error("Error connecting and setting up session.", e);
            logger.info("************* Aborting Solace initialization!! ************");
            return;
        }

        try {
            final XMLMessageConsumer cons = session.getMessageConsumer(new SimpleMessageListener());
            cons.start();

            producer = session.getMessageProducer(new SimplePublisherEventHandler());

            logger.info("************* Solace initialized correctly!! ************");
        } catch (Exception e) {
            logger.error("Error creating the consumer and producer.", e);
        }
    }

    @RequestMapping(value = "/message", method = RequestMethod.POST)
    public ResponseEntity<String> sendMessage(@RequestBody SimpleMessage message) {

        if (session == null || session.isClosed()) {
            logger.error("Session was null or closed, Could not send message");
            return new ResponseEntity<>("{'description': 'Somehow the session is not connected, please see logs'}",
                    HttpStatus.BAD_REQUEST);
        }

        logger.info("Sending message on topic: " + message.getTopic() + " with body: " + message.getBody());

        final Topic topic = JCSMPFactory.onlyInstance().createTopic(message.getTopic());
        TextMessage msg = JCSMPFactory.onlyInstance().createMessage(TextMessage.class);
        msg.setText(message.getBody());
        try {
            producer.send(msg, topic);

        } catch (JCSMPException e) {
            logger.error("Sending message failed.", e);
            return handleError(e);
        }
        return new ResponseEntity<>("{}", HttpStatus.OK);
    }

    @RequestMapping(value = "/message", method = RequestMethod.GET)
    public ResponseEntity<SimpleMessage> getLastMessageReceived() {

        TextMessage lastReceivedMessage = receivedMessages.poll();
        if (lastReceivedMessage != null) {
            logger.info("Sending the lastReceivedMessage");

            // Return the last received message if it exists.
            SimpleMessage receivedMessage = new SimpleMessage();

            receivedMessage.setTopic(lastReceivedMessage.getDestination().getName());
            receivedMessage.setBody(lastReceivedMessage.getText());
            return new ResponseEntity<>(receivedMessage, HttpStatus.OK);
        } else {
            logger.info("Sorry did not find a lastReceivedMessage");
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }

    }

    @RequestMapping(value = "/subscription", method = RequestMethod.POST)
    public ResponseEntity<String> addSubscription(@RequestBody SimpleSubscription subscription) {
        String subscriptionTopic = subscription.getSubscription();
        logger.info("Adding a subscription to topic: " + subscriptionTopic);

        final Topic topic = JCSMPFactory.onlyInstance().createTopic(subscriptionTopic);
        try {
            boolean waitForConfirm = true;
            session.addSubscription(topic, waitForConfirm);
        } catch (JCSMPException e) {
            logger.error("Subscription add failed.", e);
            return handleError(e);
        }
        logger.info("Finished Adding a subscription to topic: " + subscriptionTopic);
        return new ResponseEntity<>("{}", HttpStatus.OK);
    }

    /**
     * This formats a string showing the exception class name and message, as
     * well as the class name and message of the underlying cause if it exists.
     * Then it returns that string in a ResponseEntity.
     *
     * @param exception
     * @return ResponseEntity<String>
     */
    private ResponseEntity<String> handleError(Exception exception) {

        Throwable cause = exception.getCause();
        String causeString = "";

        if (cause != null) {
            causeString = "Cause: " + cause.getClass() + ": " + cause.getMessage();
        }

        String desc = String.format("{'description': ' %s: %s %s'}", exception.getClass().toString(),
                exception.getMessage(), causeString);
        return new ResponseEntity<>(desc, HttpStatus.BAD_REQUEST);

    }

}
