import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonElement;

import javax.jms.*;
import javax.naming.Context;
import javax.naming.InitialContext;
import java.text.DecimalFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.concurrent.ThreadLocalRandom;


public class JMSContactRecordPublisher {
    private static ContactRecord sampleContactRecord;
    private static DecimalFormat df = new DecimalFormat("####0.0");

    public static void main(String[] args){
        try{
            Gson gson = new GsonBuilder().serializeNulls().create();
            Context ctx = new InitialContext();
            Connection connection = ((ConnectionFactory) ctx.lookup("ConnectionFactory")).createConnection();
            connection.start();
            Session session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);
            Topic topic = session.createTopic("MARS_TOPIC.T");
            MessageProducer publisher = session.createProducer(topic);


            for(int i = 0; i < 10; i++) {
                sampleContactRecord = buildContactRecord();
                JsonElement tree = gson.toJsonTree(sampleContactRecord);
                System.out.println(tree);
                TextMessage msg = session.createTextMessage(tree.toString());
                //System.out.println("Json is " + sampleContactRecord);

                publisher.send(msg);
                System.out.println("Message sent");
            }
            connection.close();

        } catch(Exception up){
            up.printStackTrace();
        }
    }

     private static ContactRecord buildContactRecord() {

        sampleContactRecord = new ContactRecord();
        sampleContactRecord.setEventName("CONTACT_RECORD");

        if (Math.random() < 0.5) {
            int randomNum = ThreadLocalRandom.current().nextInt(0, 4);
            switch (randomNum) {
                case 0:
                    sampleContactRecord.setContactChannelType("SMS Text");
                    break;
                case 1:
                    sampleContactRecord.setContactChannelType("Email");
                    break;
                case 2:
                    sampleContactRecord.setContactChannelType("Phone");
                    break;
                case 3:
                    sampleContactRecord.setContactChannelType("Web Chat");
                    break;
            }
            sampleContactRecord.setEventType("SAVE");

            sampleContactRecord.setCreatedBy(Integer.toString(ThreadLocalRandom.current().nextInt(200, 301)));
            sampleContactRecord.setUiid(Long.toString(ThreadLocalRandom.current().nextLong(90000000, 900000000)));
            sampleContactRecord.setCorrelationId(Long.toString(ThreadLocalRandom.current().nextLong(90000000, 900000000)));
            switch (ThreadLocalRandom.current().nextInt(0, 2)) {
                case 0:
                    sampleContactRecord.setContactRecordType("Outbound");
                    break;

                case 1:
                    sampleContactRecord.setContactRecordType("Inbound");
                    break;
            }

            sampleContactRecord.setCreatedOn(LocalDateTime.now().format(DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss")));
        } else {
            sampleContactRecord.setEventType("UPDATE");
            sampleContactRecord.setContactRecordId(ThreadLocalRandom.current().nextLong(20000, 30000));
            sampleContactRecord.setLinkRefId(Double.valueOf(df.format(ThreadLocalRandom.current().nextDouble(2000, 30000))));
            sampleContactRecord.setConsumerAuthenticatedInd(ThreadLocalRandom.current().nextBoolean());
            if (Math.random() < 0.5) {
                int randomNum = ThreadLocalRandom.current().nextInt(0, 2);
                switch (randomNum) {
                    case 0:
                        sampleContactRecord.setLinkRefType("case");
                        break;
                    case 1:
                        sampleContactRecord.setLinkRefType("consumer");
                        break;
                }
            }

        }
        return sampleContactRecord;
    }
}
