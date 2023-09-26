import javax.jms.*;
import org.apache.activemq.ActiveMQConnectionFactory;

public class JMSReceiver {
    public static void main(String[] args) throws Exception{

        ActiveMQConnectionFactory cf = new ActiveMQConnectionFactory("tcp://localhost:61616");
        Connection connection = cf.createConnection();
        connection.start();
        Session session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);
        Queue queue = session.createQueue("RANDOM.Q");
        MessageConsumer receiver = session.createConsumer(queue);
        TextMessage msg = (TextMessage)receiver.receive();
        System.out.println(msg.getText());
        connection.close();

    }
}
