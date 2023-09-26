import javax.jms.Connection;
import javax.jms.ConnectionFactory;
import javax.jms.MessageProducer;
import javax.jms.Queue;
import javax.jms.Session;
import javax.jms.TextMessage;
import javax.naming.Context;
import javax.naming.InitialContext;
import java.util.Random;

public class JMSSender {

    public static void main(String[] args) throws Exception {


        final int iterations = 1000;
        Random random = new Random();
        Context ctx = new InitialContext();
        Connection connection = ((ConnectionFactory) ctx.lookup("ConnectionFactory")).createConnection();
        connection.start();
        Queue queue = (Queue) ctx.lookup("RANDOM.Q");
        for (int i = 0; i < iterations; i++) {

            Session session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);
            MessageProducer sender = session.createProducer(queue);
            TextMessage msg = session.createTextMessage("This is a message");
            msg.setIntProperty("RandomNumber", random.nextInt());
            sender.send(msg);
            System.out.println("Message sent");
            Thread.sleep(random.nextInt(1000));
        }
        connection.close();
    }
}
