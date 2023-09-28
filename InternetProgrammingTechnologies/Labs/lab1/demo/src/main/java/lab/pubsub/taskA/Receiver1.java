package lab.pubsub.taskA;

import com.sun.messaging.ConnectionConfiguration;
import com.sun.messaging.ConnectionFactory;

import javax.jms.*;

public class Receiver1 implements MessageListener {
    ConnectionFactory cf = new ConnectionFactory();
    JMSConsumer consumer;
    Receiver1() {
        try (JMSContext jmsContext = cf.createContext("admin", "admin",JMSContext.AUTO_ACKNOWLEDGE)) {
            cf.setProperty(ConnectionConfiguration.imqAddressList, "mq://127.0.0.1:7676,mq://127.0.0.1:7676");
            Destination messageTopic = jmsContext.createTopic("Ex_3");
            consumer = jmsContext.createConsumer(messageTopic);
            consumer.setMessageListener(this);
            System.out.println("Listening to Ex_3");
            while (true) {
                Thread.sleep(1000);
            }
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
    }
    @Override
    public void onMessage(Message message) {
        try {
            System.out.println("Message:" + message.getBody(String.class));
        } catch (JMSException e) {
            throw new RuntimeException(e.getMessage());
        }
    }

    public static void main(String[] args) {
        new Receiver1();
    }
}
