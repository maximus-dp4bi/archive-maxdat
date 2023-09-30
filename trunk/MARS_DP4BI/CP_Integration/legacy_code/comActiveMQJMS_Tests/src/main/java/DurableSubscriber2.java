import javax.jms.*;
import javax.naming.Context;
import javax.naming.InitialContext;


public class DurableSubscriber2 implements MessageListener {



    public DurableSubscriber2(){
        try{

            Context ctx = new InitialContext();
            Connection connection = ((ConnectionFactory) ctx.lookup("ConnectionFactory")).createConnection();
            connection.setClientID("client:1");
            connection.start();
            Session session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);
            Topic topic = session.createTopic("mars-events-topic-dpbi");
            TopicSubscriber subscriber = session.createDurableSubscriber(topic, topic.getTopicName());
            subscriber.setMessageListener(this);
            System.out.println("Waiting for messages...");

        } catch(Exception up){
            up.printStackTrace();
        }
    }

    public void onMessage(Message message) {

        try {
            TextMessage msg = (TextMessage) message;
            System.out.println(msg.getText());
            String queriedMsg = msg.getText();
        }

        catch (Exception up) {
            up.printStackTrace();
        }

    }

    public static void main(String[] args) {
        new Thread() {
            public void run() {
                new DurableSubscriber2();
            }}.start();
    }
}
