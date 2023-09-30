import javax.jms.*;
import javax.naming.Context;
import javax.naming.InitialContext;


public class JMSAsyncReceiver implements MessageListener {

    public JMSAsyncReceiver() {
        try {
            Context ctx = new InitialContext();
            Connection connection = ((ConnectionFactory) ctx.lookup("ConnectionFactory")).createConnection();
            connection.start();
            Session session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);
            Queue queue = session.createQueue("RANDOM.Q");
            MessageConsumer receiver = session.createConsumer(queue);
            receiver.setMessageListener(this);
            System.out.println("Waiting on messages");
        } catch (Exception up) {
            up.printStackTrace();
        }
    }

    public void onMessage(Message message) {
        try {
            TextMessage msg = (TextMessage)message;
            int randomNum = msg.getIntProperty("RandomNumber");
            System.out.println(msg.getText() + ", Random number is = " + randomNum);
        } catch (Exception up) {
            up.printStackTrace();
        }
    }

    public static void main(String[] args) throws Exception {
        new Thread() {
            public void run() {
                new JMSAsyncReceiver();
            }}.start();
    }

}











