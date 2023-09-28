package lab.p2p.async;

import com.sun.messaging.ConnectionConfiguration;
import com.sun.messaging.ConnectionFactory;
import lab.p2p.Prospect;

import javax.jms.*;

public class ReceiverASYNC implements MessageListener {
    ConnectionFactory cf = new ConnectionFactory();
    JMSConsumer consumer;
    ReceiverASYNC() {
        try (JMSContext jmsContext = cf.createContext("admin", "admin")) {
            cf.setProperty(ConnectionConfiguration.imqAddressList, "mq://127.0.0.1:7676,mq://127.0.0.1:7676");
            Destination messageQueue = jmsContext.createQueue("Ex2_ASYNC");
            consumer = jmsContext.createConsumer(messageQueue);
            consumer.setMessageListener(this);
            System.out.println("Listening to Ex2_ASYNC");
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
            System.out.println("Message:" + message.getBody(Prospect.class));
        } catch (JMSException e) {
            throw new RuntimeException(e.getMessage());
        }
    }

    public static void main(String[] args) {
        new ReceiverASYNC();
    }
}
