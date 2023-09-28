package lab.task04;

import javax.jms.*;

import com.sun.messaging.ConnectionConfiguration;
import com.sun.messaging.ConnectionFactory;
public class Receiver implements MessageListener{
    ConnectionFactory cf = new ConnectionFactory();
    JMSConsumer consumer;
    Receiver() {
        try (JMSContext context = cf.createContext("admin", "admin")) {
            cf.setProperty(ConnectionConfiguration.imqAddressList, "mq://127.0.0.1:7676,mq://127.0.0.1:7676");
            Destination messageQueue = context.createQueue("Servlet");
            consumer = context.createConsumer(messageQueue);
            consumer.setMessageListener(this);
            System.out.println("Listening to Servlet");
            Thread.sleep(1000);
        } catch (Exception e) {

        }
    }
    @Override
    public void onMessage(Message message) {

    }

    public static void main(String[] args) {
        new Receiver();
    }
}
