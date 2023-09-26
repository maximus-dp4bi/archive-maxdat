import javax.jms.*;
import javax.naming.Context;
import javax.naming.InitialContext;
import org.apache.logging.log4j.Logger;
import org.apache.logging.log4j.LogManager;
import org.hibernate.HibernateException;
import org.hibernate.Transaction;
import com.google.gson.*;


public class DurableSubscriber implements MessageListener {

    static final Logger logger = LogManager.getLogger(DurableSubscriber.class.getName());
    private org.hibernate.SessionFactory hibernateSessionFactory;



    public DurableSubscriber(){
        try{

            Gson gson = new Gson();
            hibernateSessionFactory = HibernateUtil.createSessionFactory();
            Context ctx = new InitialContext();
            Connection connection = ((ConnectionFactory) ctx.lookup("ConnectionFactory")).createConnection();
            connection.setClientID("client:1");
            connection.start();
            Session session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);
            Topic topic = session.createTopic("EM_TRADE.T");
            TopicSubscriber subscriber = session.createDurableSubscriber(topic, "sub:1");
            subscriber.setMessageListener(this);



        } catch(Exception up){
            up.printStackTrace();
        }
    }

    public void onMessage(Message message) {

        org.hibernate.Session hibernateSession = hibernateSessionFactory.openSession();
        Transaction tx = null;

        try {
            StockInformation si = new StockInformation(message.getFloatProperty("Price"), message.getStringProperty("Name"));
            TextMessage msg = (TextMessage) message;
            System.out.println(msg.getText());
            String queriedMsg = msg.getText();
            logger.info(queriedMsg);
            tx = hibernateSession.beginTransaction();
            hibernateSession.persist(si);
            tx.commit();
            System.out.println("Session persisted to database");
            System.out.println("Message name is " + message.getStringProperty("Name"));
            System.out.println("Message Price is " + message.getFloatProperty("Price"));
            hibernateSession.close();

        }
        catch  (HibernateException e){
            if(tx!=null){

                tx.rollback();
                System.out.println(e);

            }

        }
        catch (Exception up) {
            up.printStackTrace();
        }
        finally {
            HibernateUtil.close();
        }
    }


    public static void main(String[] args) {
        new Thread() {
            public void run() {
                new DurableSubscriber();
            }}.start();
    }

}
