import javax.jms.*;
import javax.naming.Context;
import javax.naming.InitialContext;


public class JMSContactRecordDurableSubscriber implements MessageListener {



    public JMSContactRecordDurableSubscriber(){
        try{
            Context ctx = new InitialContext();
            Connection connection = ((ConnectionFactory) ctx.lookup("ConnectionFactory")).createConnection();
            connection.setClientID("client:1");
            connection.start();
            Session session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);
            Topic topic = session.createTopic("MARS_TOPIC.T");
            TopicSubscriber subscriber = session.createDurableSubscriber(topic, "sub:1");
            subscriber.setMessageListener(this);
            System.out.println("Listening for messages....");
        } catch(Exception up){
            up.printStackTrace();
        }
    }

    public void onMessage(Message message) {

        try {
            TextMessage msg = (TextMessage) message;
            System.out.println(msg.getText());
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
                new JMSContactRecordDurableSubscriber();
            }}.start();
    }

}
