import javax.jms.*;
import javax.naming.Context;
import javax.naming.InitialContext;
import java.text.DecimalFormat;
import java.util.Random;
import org.apache.commons.text.RandomStringGenerator;

public class JMSPublisher {
    public static void main(String[] args){
        try{
            RandomStringGenerator stringRandomGen = new RandomStringGenerator.Builder()
                    .withinRange('A', 'Z').build();
            String randomLetters = stringRandomGen.generate(3);
            Random random = new Random();
            Context ctx = new InitialContext();
            Connection connection = ((ConnectionFactory) ctx.lookup("ConnectionFactory")).createConnection();
            connection.start();
            Session session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);
            Topic topic = session.createTopic("EM_TRADE.T");
            MessageProducer publisher = session.createProducer(topic);
            DecimalFormat df = new DecimalFormat("##.00");
            Float ranNum = random.nextInt(100) + random.nextFloat();
            String price = df.format(ranNum);
            String finalMessage = "{\"Name\":" + "\"" + randomLetters + "\"," + "\"Price\":" + "\"" + price + "\"}";
            TextMessage msg = session.createTextMessage(finalMessage);
            msg.setStringProperty("Name", randomLetters);
            msg.setFloatProperty("Price", ranNum);
            publisher.send(msg);
            System.out.println("Message sent");
            connection.close();

        } catch(Exception up){
            up.printStackTrace();
        }
    }
}
