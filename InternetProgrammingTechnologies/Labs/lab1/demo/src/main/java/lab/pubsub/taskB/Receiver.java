package lab.pubsub.taskB;

import com.sun.messaging.ConnectionConfiguration;

import javax.jms.*;
public class Receiver implements MessageListener{
    com.sun.messaging.ConnectionFactory cf = new com.sun.messaging.ConnectionFactory();
    JMSConsumer consumer;
    Receiver() {
        try (JMSContext jmsContext = cf.createContext("admin", "admin")) {
            cf.setProperty(ConnectionConfiguration.imqAddressList, "mq://127.0.0.1:7676,mq://127.0.0.1:7676");
            Destination messageTopic = jmsContext.createTopic("Ex_3b");
            consumer = jmsContext.createConsumer(messageTopic);
            consumer.setMessageListener(this);
            System.out.println("Listening to Ex_3b");
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
        new Receiver();
    }
}
